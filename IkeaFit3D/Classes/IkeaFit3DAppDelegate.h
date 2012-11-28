/**
 *  IkeaFit3DAppDelegate.h
 *  IkeaFit3D
 *
 *  Created by Alice.Chen on 7/31/12.
 *  Copyright __MyCompanyName__ 2012. All rights reserved.
 */

#import <UIKit/UIKit.h>
#import "CCNodeController.h"

@interface IkeaFit3DAppDelegate : NSObject <UIApplicationDelegate, UIGestureRecognizerDelegate> {
	UIWindow* window;
}

@property (nonatomic, retain) UIWindow* window;
@property (assign, nonatomic) int itemCount;

@end
