/**
 *  IkeaFit3DLayer.m
 *  IkeaFit3D
 *
 *  Created by Alice.Chen on 7/31/12.
 *  Copyright __MyCompanyName__ 2012. All rights reserved.
 */

#import "IkeaFit3DLayer.h"
#import "IkeaFit3DScene.h"


@implementation IkeaFit3DLayer

- (void)dealloc {
    [super dealloc];
}


/**
 * Override to set up your 2D controls and other initial state.
 *
 * For more info, read the notes of this method on CC3Layer.
 */
-(void) initializeControls {
    
}

-(IkeaFit3DScene*) carScene {
	return (IkeaFit3DScene*) cc3Scene;
}

-(void)tellSceneToSpinIt:(CGFloat)x yaxis:(CGFloat)y
{
    [self.carScene panTheCar:x yaxis:y];
}

-(void)tellSceneToFullScreen{
    [self.carScene makeFullScreen];
}

-(void)tellSceneToExitFullScreen{
    [self.carScene exitFullScreen];
}

-(void)tellSceneToShowBoxes:(int)numOfBoxes{
    [self.carScene showBox:numOfBoxes];
}

-(void)tellSceneToRemoveBoxes{
    [self.carScene removeBoxes];
}

#pragma mark Updating layer

/**
 * Override to perform set-up activity prior to the scene being opened
 * on the view, such as adding gesture recognizers.
 *
 * For more info, read the notes of this method on CC3Layer.
 */
-(void) onOpenCC3Layer {}

/**
 * Override to perform tear-down activity prior to the scene disappearing.
 *
 * For more info, read the notes of this method on CC3Layer.
 */
-(void) onCloseCC3Layer {}

/**
 * The ccTouchMoved:withEvent: method is optional for the <CCTouchDelegateProtocol>.
 * The event dispatcher will not dispatch events for which there is no method
 * implementation. Since the touch-move events are both voluminous and seldom used,
 * the implementation of ccTouchMoved:withEvent: has been left out of the default
 * CC3Layer implementation. To receive and handle touch-move events for object
 * picking, uncomment the following method implementation.
 */
/*
 -(void) ccTouchMoved: (UITouch *)touch withEvent: (UIEvent *)event {
 [self handleTouch: touch ofType: kCCTouchMoved];
 }
 */
@end
