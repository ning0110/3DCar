/**
 *  IkeaFit3DScene.h
 *  IkeaFit3D
 *
 *  Created by Alice.Chen on 7/31/12.
 *  Copyright __MyCompanyName__ 2012. All rights reserved.
 */


#import "CC3Scene.h"

/** A sample application-specific CC3Scene subclass.*/
@interface IkeaFit3DScene : CC3Scene {
    CGFloat startX, endX, startY, endY;
    BOOL isFullScreen;
}

-(void)panTheCar:(CGFloat)x yaxis:(CGFloat)y;
-(void)makeFullScreen;
-(void)exitFullScreen;
-(void)showBox:(int)numOfBoxes;
-(void)removeBoxes;

@end
