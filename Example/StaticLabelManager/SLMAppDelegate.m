//
//  SLMAppDelegate.m
//  StaticLabelManager
//
//  Created by CocoaPods on 02/09/2015.
//  Copyright (c) 2014 Julian Le Calvez. All rights reserved.
//

#import "SLMAppDelegate.h"
#import <StaticLabelManager/SLManager.h>

@implementation SLMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Setup configuration
    SLManager *manager = [SLManager sharedManager];
    manager.delegate = self;
    manager.versionFileUrl = [NSURL URLWithString:@"http://www.julianlecalvez.com/static-label-manager/version.txt"];
    manager.labelsFileUrl = [NSURL URLWithString:@"http://www.julianlecalvez.com/static-label-manager/labels.strings"];
    [manager update];
    
    // Run a loop to display 5 labels every one seconds
    NSString *code = @"test1";
    dispatch_async(dispatch_get_main_queue(), ^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"%@: %@", code, [[SLManager sharedManager] get:code withDefault:@"###"]);
            sleep(1);
        }
    });
    
    return YES;
}

-(void)managerDidFinishUpdate {
    NSLog(@"labels version updated!");
    [SLManager sharedManager].delegate = nil; // to avoid unecessary calls
    sleep(2);
    // Try to update again
    [SLManager sharedManager].versionFileUrl = [NSURL URLWithString:@"http://www.julianlecalvez.com/static-label-manager/version2.txt"];
    [SLManager sharedManager].labelsFileUrl = [NSURL URLWithString:@"http://www.julianlecalvez.com/static-label-manager/labels2.strings"];
    [[SLManager sharedManager] update];
}
-(void)managerDidFailWithError:(NSError *)error {
    NSLog(@"SLManager Error: %@", error);
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
