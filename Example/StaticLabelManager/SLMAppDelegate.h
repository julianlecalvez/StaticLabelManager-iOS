//
//  SLMAppDelegate.h
//  StaticLabelManager
//
//  Created by CocoaPods on 02/09/2015.
//  Copyright (c) 2014 Julian Le Calvez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StaticLabelManager/SLManagerDelegate.h>

@interface SLMAppDelegate : UIResponder <UIApplicationDelegate, SLManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
