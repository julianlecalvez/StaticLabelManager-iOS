//
//  SLMAdapterHTTP.m
//  Pods
//
//  Created by Julian Le Calvez on 09/02/15.
//
//

#import "SLMDownloaderAdapterHTTP.h"

@interface SLMDownloaderAdapterHTTP (PrivateMethods)
// Common method used to actually download the content
-(NSString *)contentForUrl:(NSURL *)url;
@end

@implementation SLMDownloaderAdapterHTTP

@synthesize lastError;

-(NSString *)contentForUrl:(NSURL *)url {
    NSError *error = nil;
    
    // Return version file to check
    NSString *content = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    
    if (error) {
        lastError = error;
        return nil;
    }
    return content;
}

-(NSString *)versionContentWithParams:(NSDictionary *)params {
    NSURL *versionUrl = [params objectForKey:@"versionFile"];
    return [self contentForUrl:versionUrl];
}

-(NSString *)labelsContentWithParams:(NSDictionary *)params {
    NSURL *labelsUrl = [params objectForKey:@"labelsFile"];
    return [self contentForUrl:labelsUrl];
}

@end
