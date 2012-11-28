/**
 *  IkeaFit3DAppDelegate.m
 *  IkeaFit3D
 *
 *  Created by Alice.Chen on 7/31/12.
 *  Copyright __MyCompanyName__ 2012. All rights reserved.
 */

#import "IkeaFit3DAppDelegate.h"

@implementation IkeaFit3DAppDelegate

@synthesize window;
@synthesize itemCount;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window.rootViewController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"MainNavigationController"];
    itemCount = 0;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
	[[CCDirector sharedDirector] pause];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	[[CCDirector sharedDirector] resume];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [[CCDirector sharedDirector] purgeCachedData];
}

-(void) applicationDidEnterBackground:(UIApplication*)application {
	//[[CCDirector sharedDirector] stopAnimation];
    
}

-(void) applicationWillEnterForeground:(UIApplication*)application {
	//[[CCDirector sharedDirector] startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	CCDirector *director = [CCDirector sharedDirector];
    
	[[director openGLView] removeFromSuperview];
    
	[director end];
    
}

- (void)applicationSignificantTimeChange:(UIApplication *)application {
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}
@end
