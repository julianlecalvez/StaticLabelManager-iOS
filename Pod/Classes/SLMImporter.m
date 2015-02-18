//
//  SLMDownloader.m
//  Pods
//
//  Created by Julian Le Calvez on 09/02/15.
//
//

#import "SLMImporter.h"
#import "SLManager.h"
#import "SLMDownloaderAdapterHTTP.h"

@implementation SLMImporter

@synthesize adapter;
@synthesize manager;

-(id)init {
    self = [super init];
    
    if (self) {
        // Default adapter 
        self.adapter = [[SLMDownloaderAdapterHTTP alloc] init];
    }
    
    return self;
}

-(void)setAdapter:(id<SLMDownloaderAdapterProtocol>)adapterInstance {
    // Change adapter only if protocol is ok
    if ([adapterInstance conformsToProtocol:@protocol(SLMDownloaderAdapterProtocol)]) {
        adapter = adapterInstance;
    }
    else {
        NSLog(@"Warning: StaticLabelManager needs a valid Downloader adapter. Please check the documentation to know how to create your own downloader adapter.");
    }
}

-(void)runWithParam:(NSDictionary *)params {
    // Get version file
    NSString *remoteVersionStr = [self.adapter versionContentWithParams:params];
    if (remoteVersionStr == nil) {
        [self sendError:self.adapter.lastError];
        return;
    }
    
    NSUInteger remoteVersion = [remoteVersionStr intValue];
    NSUInteger currentVersion = [[[SLManager sharedManager] get:@"FILE_VERSION" withDefault:@"0"] intValue];
    
    // Only if remote version is strictly superior to the current version, we download and install the new label file
    if (remoteVersion > currentVersion) {
        NSString *newLabelsFile = [self.adapter labelsContentWithParams:params];
        if (newLabelsFile == nil) {
            [self sendError:self.adapter.lastError];
            return;
        }
        
        NSString *tableName = [params objectForKey:@"labelsFileName"];
        NSBundle *targetBundle = [params objectForKey:@"resourceBundle"];
        
        dispatch_queue_t q = dispatch_queue_create("com.julianlecalvez.staticlabelmanager.update", NULL);
        // install and replace previous label file
        dispatch_sync(q, ^{
            // Put in tmp file
            NSFileManager *fm = [NSFileManager defaultManager];
            NSString *tmpFileName = [NSString stringWithFormat:@"%@/%@_new.strings", [targetBundle resourcePath], tableName];
            if ([fm createFileAtPath:tmpFileName contents:[newLabelsFile dataUsingEncoding:NSUTF8StringEncoding] attributes:nil]) {
                // Compare the two versions (FILE_VERSION should be at the end to be sure the new file is NOT truncated)
                NSString *newVersionStr = [targetBundle localizedStringForKey:@"FILE_VERSION" value:@"0" table:[NSString stringWithFormat:@"%@_new", tableName]];
                NSUInteger newVersion = [newVersionStr intValue];
                NSUInteger currentVersion = [[targetBundle localizedStringForKey:@"FILE_VERSION" value:@"0" table:tableName] intValue];
                
                // Check validity and replace normal file
                if (newVersion > currentVersion) {
                    NSString *labelFilePath = [NSString stringWithFormat:@"%@/%@.strings", [targetBundle resourcePath], tableName];
                    
                    NSError *error;
                    if ([fm isReadableFileAtPath:tmpFileName]) {
                        // Erase old file with the new one
                        NSURL *destUrl = [NSURL URLWithString:[NSString stringWithFormat:@"file:///%@", labelFilePath]];
                        NSURL *fromUrl = [NSURL URLWithString:[NSString stringWithFormat:@"file:///%@", tmpFileName]];
                        [fm replaceItemAtURL:destUrl withItemAtURL:fromUrl backupItemName:[NSString stringWithFormat:@"%@_backup.strings", tableName] options:NSFileManagerItemReplacementUsingNewMetadataOnly resultingItemURL:nil error:&error];
                    }
                    // Call the delegate 
                    if (error) {
                        [self sendError:error];
                    }
                    else {
                        if (self.manager && [self.manager respondsToSelector:@selector(dataAreAvailable)]) {
                            [self.manager dataAreAvailable];
                        }
                    }
                }
            }
        });
    }
}

- (void)sendError:(NSError *)error {
    if (self.manager && [self.manager respondsToSelector:@selector(throwError:)]) {
        [self.manager throwError:error];
    }
}

@end
