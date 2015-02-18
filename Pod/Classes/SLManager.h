//
//  SLManager.h
//  Pods
//
//  Created by Julian Le Calvez on 09/02/15.
//
//

#import <Foundation/Foundation.h>
#import "SLMImporter.h"
#import "SLMDownloaderAdapterProtocol.h"
#import "SLManagerDelegate.h"

/**
 SLManager is the main manager of the library. Your application will only interact with this class. This class is a singleton. Basically, you will setup the class with your own settings, like your remote labels file URL and then you will get all the label through it.
 */

@interface SLManager : NSObject <SLMManagerProtocol> {
    /**
     * The URL of the remote version file
     */
    NSURL *versionFileUrl;
    
    /**
     * The URL of the remote labels file
     */
    NSURL *labelsFileUrl;
    
    /**
     * Delegate to handle importer errors and/or success of label update
     */
    __weak id<SLManagerDelegate>delegate;
}

// Config members
@property (nonatomic, strong) NSURL *versionFileUrl;
@property (nonatomic, strong) NSURL *labelsFileUrl;
@property (nonatomic, weak) id<SLManagerDelegate>delegate;

// Internal vars
@property (nonatomic, strong) NSBundle *resourceBundle;
@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, strong) NSString *tableName;
@property (nonatomic, strong) SLMImporter *importer;

/**
 * Singleton method
 */
+ (SLManager *)sharedManager;

/**
 This method will start running the labels update process, only if a new version exists
 The update is done asynchronously this is why it doesn't return anything. But you use the delegate member to be notified of errors and successful update.
 */
- (void)update;

/**
 This is the basic method to get a label from the labels list. If the label is not found, the method will return an empty string. 
 @param code The label code to find
 @return the label corresponding to the code, or an empty string if the label is not found
 */
- (NSString *)get:(NSString *)code;

/**
 This method is also used to get a label, but it accepts a default value in the case the label is not found. 
 @param code The label code to find 
 @param defaultValue The default value to return if the code doesn't exists in the file 
 @return the label corresponding to the code, or the defaultValue value if the label doesn't exist
 */
- (NSString *)get:(NSString *)code withDefault:(NSString *)defaultValue;

/**
 This method can be called to set a different downloader adapter than the default one. See the documentation to know more about custom downloader adapter
 */
- (void)setDownloaderAdapter:(id<SLMDownloaderAdapterProtocol>)adapter;

/**
 This method is use to dealloc the singleton instance. Used during TDD or specific needs.
 */
- (void)unload;

@end
