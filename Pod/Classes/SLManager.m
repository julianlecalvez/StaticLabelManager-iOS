//
//  SLManager.m
//  Pods
//
//  Created by Julian Le Calvez on 09/02/15.
//
//

#import "SLManager.h"

// Private Methods 
@interface SLManager (PrivateMethods)
// This method is used to setup the bundle properly 
- (NSBundle *)createSLMBundle;
@end

@implementation SLManager

@synthesize versionFileUrl;
@synthesize labelsFileUrl;
@synthesize delegate;

static SLManager *instance = nil;
+ (SLManager *)sharedManager {
    if (instance == nil) instance = [[SLManager alloc] init];
    return instance;
}

- (void)setDownloaderAdapter:(id<SLMDownloaderAdapterProtocol>)adapter {
    _importer.adapter = adapter;
}

-(id)init {
    self = [super init];
    
    if (self) {
        _importer = [[SLMImporter alloc] init];
        _importer.manager = self;
        
        // Setup the target bundle and table name, then load data
        _tableName = @"slm";
        _resourceBundle = [self createSLMBundle];
        [self reloadData];
    }
    
    return self;
}

- (void)update {
    // Check configuration
    if (self.versionFileUrl == nil || self.labelsFileUrl == nil) {
        // Raise an exception if URL confguration hasn't been done yet
        [NSException raise:@"SLManagerConfigurationError" format:@"StaticLabelManager needs to know both the location of your version file and your label file. Please check the documentation to know how to fix it."];
        //NSLog(@"Warning: StaticLabelManager needs to know both the location of your version file and your label file. Please check the documentation to know how to fix it.");
        return;
    }
    
    // Add needed params for importer
    NSDictionary *slmSettings = [NSDictionary dictionaryWithObjectsAndKeys:_tableName, @"labelsFileName", _resourceBundle, @"resourceBundle", self.labelsFileUrl, @"labelsFile", self.versionFileUrl, @"versionFile", nil];
    
    // Run downloader for label update
    dispatch_queue_t q = dispatch_queue_create("com.julianlecalvez.staticlabelmanager.main", NULL);
    dispatch_async(q, ^{
        [_importer runWithParam:slmSettings];
    });
}

- (void)reloadData {
    NSString *resource = [_resourceBundle pathForResource:_tableName ofType:@"strings"];
    _data = [NSDictionary dictionary];
    if ([[NSFileManager defaultManager] fileExistsAtPath:resource]) {
        _data = [NSDictionary dictionaryWithContentsOfFile:resource];
    }
}

- (NSBundle *)createSLMBundle {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *slmDirectory = [[documentDirectory mutableCopy] stringByAppendingPathComponent:_tableName];
    
    // Create the target directory
    BOOL isDirectory;
    if (![fm fileExistsAtPath:slmDirectory isDirectory:&isDirectory] || !isDirectory) {
        [fm createDirectoryAtPath:slmDirectory withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    // Create empty files which will be load into the bundle
    NSString *tmpFileName = [NSString stringWithFormat:@"%@/%@.strings", slmDirectory, _tableName];
    NSString *newTmpFileName = [NSString stringWithFormat:@"%@/%@_new.strings", slmDirectory, _tableName];
    if (![fm fileExistsAtPath:tmpFileName]) {
        // if it's the first time, we copy default labels file with the same name or we create an empty one
        NSString *defaultLabelsPath = [[NSBundle mainBundle] pathForResource:_tableName ofType:@"strings"];
        if ([fm fileExistsAtPath:defaultLabelsPath]) {
            [fm copyItemAtPath:defaultLabelsPath toPath:tmpFileName error:nil];
        }
        else {
            [fm createFileAtPath:tmpFileName contents:[@"\"FILE_VERSION\" = \"0\";" dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
        }
    }
    if (![fm fileExistsAtPath:newTmpFileName]) [fm createFileAtPath:newTmpFileName contents:nil attributes:nil];
    
    // Create the bundle
    return [NSBundle bundleWithPath:slmDirectory];
}


#pragma Delegate Methods 
-(void)dataAreAvailable{
    [self reloadData];
    if (self.delegate && [self.delegate respondsToSelector:@selector(managerDidFinishUpdate)]) {
        [self.delegate managerDidFinishUpdate];
    }
}
-(void)throwError:(NSError *)error {
    if (self.delegate && [self.delegate respondsToSelector:@selector(managerDidFailWithError:)]) {
        [self.delegate managerDidFailWithError:error];
    }
}

- (NSString *)get:(NSString *)code {
    // get value
    return [self get:code withDefault:@""];
}

- (NSString *)get:(NSString *)code withDefault:(NSString *)defaultValue {
    NSString *val = [_data objectForKey:code];
    if (val == nil) val = defaultValue;
    return val;
}

-(void)unload {
    instance = nil;
}

@end
