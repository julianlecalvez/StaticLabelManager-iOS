//
//  SLMDownloader.h
//  Pods
//
//  Created by Julian Le Calvez on 09/02/15.
//
//

#import <Foundation/Foundation.h>
#import "SLMDownloaderAdapterProtocol.h"

@protocol SLMManagerProtocol <NSObject>
- (void)dataAreAvailable;
- (void)throwError:(NSError *)error;
@end

/**
 This class manages the import process of the new label file. It is responsible to check the version to be sure the label file has to be updated, then call the downloader which will return the remote file content, and finally install the new label file locally. 
 This method has a default downloader adapter which a simple HTTP download from a URL, but you can create your own adapter to be able to get the file content from another source.
 */
@interface SLMImporter : NSObject {
    /**
     The downloader adapter to be used (should be conformed to the SLMDownloaderAdapterProtocol protocol)
     */
    id<SLMDownloaderAdapterProtocol>adapter;
    
    /**
     A reference to the SLManager which called the importer, to notify of changes and errors
     */
    __weak id<SLMManagerProtocol>manager;
}

@property (nonatomic, strong) id<SLMDownloaderAdapterProtocol> adapter;
@property (nonatomic, weak) id<SLMManagerProtocol>manager;

/**
 This method is the heart of the class and coordinate the update job. This is the one called asynchronously by the SLManager. 
 */
-(void)runWithParam:(NSDictionary *)params;

@end
