/**
 *  IkeaFit3DLayer.h
 *  IkeaFit3D
 *
 *  Created by Alice.Chen on 7/31/12.
 *  Copyright __MyCompanyName__ 2012. All rights reserved.
 */


#import "CC3Layer.h"


/** A sample application-specific CC3Layer subclass. */
@interface IkeaFit3DLayer : CC3Layer {
}

-(void)tellSceneToSpinIt:(CGFloat)x yaxis:(CGFloat)y;
-(void)tellSceneToFullScreen;
-(void)tellSceneToExitFullScreen;
-(void)tellSceneToShowBoxes:(int)numOfBoxes;
-(void)tellSceneToRemoveBoxes;

@end
