//
//  SLMDownloaderAdapterProtocol.h
//  Pods
//
//  Created by Julian Le Calvez Le Calvez on 17/02/15.
//
//

#ifndef Pods_SLMDownloaderAdapterProtocol_h
#define Pods_SLMDownloaderAdapterProtocol_h

/**
 This protocol is used for new downloader adapters which have to be conformed to it
 */
@protocol SLMDownloaderAdapterProtocol <NSObject>

/**
 The last error that occured. The importer will get this value if the result of the download methods is nil. Be sure to update this value with every error that could happen.
 */
@property (nonatomic, strong, readonly) NSError *lastError;

/**
 This method is responsible for the download of the remote version file. The result will be the formatted content of the version file.
 @param params Dictionary of parameters that can be used. It contains the labels file URL and version file URL.
 @return Formatted content of the version file that should be a simple version number
 */
- (NSString *)versionContentWithParams:(NSDictionary *)params;

/**
 This method is responsible for the download of the remote labels file. The result will be the formatted content of the labels file.
 @param params Dictionary of parameters that can be used. It contains the labels file URL and version file URL.
 @return Formatted content of the labels file that should respect the .strings file format
 */
- (NSString *)labelsContentWithParams:(NSDictionary *)params;

@end

#endif
