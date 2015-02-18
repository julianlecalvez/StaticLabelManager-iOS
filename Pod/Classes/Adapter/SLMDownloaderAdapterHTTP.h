//
//  SLMAdapterHTTP.h
//  Pods
//
//  Created by Julian Le Calvez on 09/02/15.
//
//

#import <Foundation/Foundation.h>
#import "SLMDownloaderAdapterProtocol.h"

/**
 This class is the default downloader adapter, which is a simple HTTP downloader. This class will get and return the content of remote URLs for both labels and version files.
 */
@interface SLMDownloaderAdapterHTTP : NSObject <SLMDownloaderAdapterProtocol>

/**
 This method will download and return the content of the versionFile URL provided in the params dictionary.
 @param params Dictionary of parameters
 @return The content of the remote version file
 */
-(NSString *)versionContentWithParams:(NSDictionary *)params;

/**
 This method will download and return the content of the labelsFile URL provided in the params dictionary.
 @param params Dictionary of parameters
 @return The content of the remote labels file
 */
-(NSString *)labelsContentWithParams:(NSDictionary *)params;

@end
