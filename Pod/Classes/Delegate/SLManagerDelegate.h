//
//  SLManagerDelegate.h
//  Pods
//
//  Created by Julian Le Calvez on 18/02/15.
//
//

#ifndef Pods_SLManagerDelegate_h
#define Pods_SLManagerDelegate_h

/**
 The SLManagerDelegate methods can be implemented to be notified of changes that happen during the update process of the library.
 */
@protocol SLManagerDelegate <NSObject>

/**
 Will be called when the manager has updated all the labels with the new installed labels file.
 */
-(void)managerDidFinishUpdate;

/**
 Will be called when an error occurs e.g.: network errors, local FS writing errors.
 @param error The error description 
 */
-(void)managerDidFailWithError:(NSError *)error;

@end

#endif
