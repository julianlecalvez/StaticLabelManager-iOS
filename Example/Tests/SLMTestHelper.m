//
//  SLMTestHelper.m
//  StaticLabelManager
//
//  Created by Julian on 18/02/15.
//  Copyright (c) 2015 Julian. All rights reserved.
//

#import "SLMTestHelper.h"

@implementation SLMTestHelper

+(void)clearSLMFolder {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *slmDirectory = [[documentDirectory mutableCopy] stringByAppendingPathComponent:@"slm"];
    NSLog(@"slmDirectory: %@", slmDirectory);
    // Delete directory if exists
    BOOL isDirectory;
    if ([fm fileExistsAtPath:slmDirectory isDirectory:&isDirectory] && isDirectory) {
        [fm removeItemAtPath:slmDirectory error:nil];
    }
    [[SLManager sharedManager] unload];
}

@end
