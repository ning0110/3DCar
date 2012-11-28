/**
 *  IkeaFit3DScene.m
 *  IkeaFit3D
 *
 *  Created by Alice.Chen on 7/31/12.
 *  Copyright __MyCompanyName__ 2012. All rights reserved.
 */

#import "IkeaFit3DScene.h"
#import "CC3PODResourceNode.h"
#import "CC3ActionInterval.h"
#import "CC3MeshNode.h"
#import "CC3ParametricMeshNodes.h"
#import "CC3Camera.h"
#import "CC3Light.h"


@implementation IkeaFit3DScene

-(void) dealloc {
	[super dealloc];
}

/**
 * Constructs the 3D scene.
 *
 * Adds 3D objects to the scene, loading a 3D 'hello, world' message
 * from a POD file, and creating the camera and light programatically.
 *
 * When adapting this template to your application, remove all of the content
 * of this method, and add your own to construct your 3D model scene.
 *
 * NOTE: The POD file used for the 'hello, world' message model is fairly large,
 * because converting a font to a mesh results in a LOT of triangles. When adapting
 * this template project for your own application, REMOVE the POD file 'hello-world.pod'
 * from the Resources folder of your project!!
 */
-(void) initializeScene {
    isFullScreen = NO;
    
	// Create the camera, place it back a bit, and add it to the scene
	CC3Camera* cam = [CC3Camera nodeWithName: @"Camera"];
	cam.location = cc3v( 0.0, 0.0, 35.0 );
	[self addChild: cam];
    
	// Create a light, place it back and to the left at a specific
	// position (not just directional lighting), and add it to the scene
	CC3Light* lamp = [CC3Light nodeWithName: @"Lamp"];
	lamp.location = cc3v( 0.0, 15.0, 0.0 );
	lamp.isDirectionalOnly = YES;
	[cam addChild: lamp];
    
	// This is the simplest way to load a POD resource file and add the
	// nodes to the CC3Scene, if no customized resource subclass is needed.
	[self addContentFromPODFile: @"Car_8_15_d_greyWheels.pod" withName:@"testcar"];
	
	// Create OpenGL ES buffers for the vertex arrays to keep things fast and efficient,
	// and to save memory, release the vertex data in main memory because it is now redundant.
	[self createGLBuffers];
	[self releaseRedundantData];
	
    //self.ambientLight = kCC3DefaultLightColorAmbientScene;
    
    
    
	// That's it! The scene is now constructed and is good to go.
	
	// If you encounter problems displaying your models, you can uncomment one or
	// more of the following lines to help you troubleshoot. You can also use these
	// features on a single node, or a structure of nodes. See the CC3Node notes.
	
	// Displays short descriptive text for each node (including class, node name & tag).
	// The text is displayed centered on the pivot point (origin) of the node.
    //	self.shouldDrawAllDescriptors = YES;
	
	// Displays bounding boxes around those nodes with local content (eg- meshes).
    //	self.shouldDrawAllLocalContentWireframeBoxes = YES;
	
	// Displays bounding boxes around all nodes. The bounding box for each node
	// will encompass its child nodes.
    //	self.shouldDrawAllWireframeBoxes = YES;
	
	// Moves the camera so that it will display the entire scene.
    //	[self.activeCamera moveWithDuration: 3.0 toShowAllOf: self];
	
	// If you encounter issues creating and adding nodes, or loading models from
	// files, the following line is used to log the full structure of the scene.
	LogCleanDebug(@"The structure of this scene is: %@", [self structureDescription]);
	
	// ------------------------------------------
    
	// But to add some dynamism, we'll animate the 'hello, world' message
	// using a couple of cocos2d actions...
	
	// Fetch the 'hello, world' 3D text object that was loaded from the
	// POD file and start it rotating
    
	CC3MeshNode* testcar = (CC3MeshNode*)[self getNodeNamed: @"testcar"];
    //testcar.scale = cc3v(0.4,0.4,0.4);
    testcar.location = cc3v(4.2, -7, 0);
    testcar.rotation = cc3v(-1, 180, 0);
    testcar.shouldUseLighting = NO;

    
    //[self showBox:3];
    
    
    //id move3d=[CC3MoveTo actionWithDuration:1 moveTo:cc3v(posx,0,100)];
    //id remove=[CCCallFuncND actionWithTarget:self selector:@selector(removeObj:)];
    //[aNode runAction:[CCSequence actions:move3d,nil]];
    
    /*	CCActionInterval* partialRot = [CC3RotateBy actionWithDuration: 1.0
     rotateBy: cc3v(0.0, 30.0, 0.0)];
     [testcar runAction: [CCRepeatForever actionWithAction: partialRot]];
     
     // To make things a bit more appealing, set up a repeating up/down cycle to
     // change the color of the text from the original red to blue, and back again.
     GLfloat tintTime = 8.0f;
     ccColor3B startColor = testcar.color;
     ccColor3B endColor = { 50, 0, 200 };
     CCActionInterval* tintDown = [CCTintTo actionWithDuration: tintTime
     red: endColor.r
     green: endColor.g
     blue: endColor.b];
     CCActionInterval* tintUp = [CCTintTo actionWithDuration: tintTime
     red: startColor.r
     green: startColor.g
     blue: startColor.b];
	 CCActionInterval* tintCycle = [CCSequence actionOne: tintDown two: tintUp];
     [testcar runAction: [CCRepeatForever actionWithAction: tintCycle]];*/
}


#pragma mark Updating custom activity

/**
 * This template method is invoked periodically whenever the 3D nodes are to be updated.
 *
 * This method provides your app with an opportunity to perform update activities before
 * any changes are applied to the transformMatrix of the 3D nodes in the scene.
 *
 * For more info, read the notes of this method on CC3Node.
 */
-(void) updateBeforeTransform: (CC3NodeUpdatingVisitor*) visitor {}

/**
 * This template method is invoked periodically whenever the 3D nodes are to be updated.
 *
 * This method provides your app with an opportunity to perform update activities after
 * the transformMatrix of the 3D nodes in the scen have been recalculated.
 *
 * For more info, read the notes of this method on CC3Node.
 */
-(void) updateAfterTransform: (CC3NodeUpdatingVisitor*) visitor {}


#pragma mark Scene opening and closing

/**
 * Callback template method that is invoked automatically when the CC3Layer that
 * holds this scene is first displayed.
 *
 * This method is a good place to invoke one of CC3Camera moveToShowAllOf:... family
 * of methods, used to cause the camera to automatically focus on and frame a particular
 * node, or the entire scene.
 *
 * For more info, read the notes of this method on CC3Scene.
 */
-(void) onOpen {
    
	// Uncomment this line to have the camera move to show the entire scene.
	// This must be done after the CC3Layer has been attached to the view,
	// because this makes use of the camera frustum and projection.
    //	[self.activeCamera moveWithDuration: 3.0 toShowAllOf: self];
    
	// Uncomment this line to draw the bounding box of the scene.
    //	self.shouldDrawWireframeBox = YES;
}

/**
 * Callback template method that is invoked automatically when the CC3Layer that
 * holds this scene has been removed from display.
 *
 * For more info, read the notes of this method on CC3Scene.
 */
-(void) onClose {}


#pragma mark Handling touch events

/**
 * This method is invoked from the CC3Layer whenever a touch event occurs, if that layer
 * has indicated that it is interested in receiving touch events, and is handling them.
 *
 * Override this method to handle touch events, or remove this method to make use of
 * the superclass behaviour of selecting 3D nodes on each touch-down event.
 *
 * This method is not invoked when gestures are used for user interaction. Your custom
 * CC3Layer processes gestures and invokes higher-level application-defined behaviour
 * on this customized CC3Scene subclass.
 *
 * For more info, read the notes of this method on CC3Scene.
 */
-(void) touchEvent: (uint) touchType at: (CGPoint) touchPoint {
    
    
}

/**
 * This callback template method is invoked automatically when a node has been picked
 * by the invocation of the pickNodeFromTapAt: or pickNodeFromTouchEvent:at: methods,
 * as a result of a touch event or tap gesture.
 *
 * Override this method to perform activities on 3D nodes that have been picked by the user.
 *
 * For more info, read the notes of this method on CC3Scene.
 */
-(void) nodeSelected: (CC3Node*) aNode byTouchEvent: (uint) touchType at: (CGPoint) touchPoint {}

-(void)panTheCar:(CGFloat)x yaxis:(CGFloat)y
{
    CC3MeshNode* car = (CC3MeshNode*)[self getNodeNamed:@"testcar"];
    
    CC3Vector current = car.rotation;
    NSLog(@"current x rotation: %f", current.y);
    
    // Set rotation limit
    if((x>0 && current.y >195) || (x<0 &&current.y <165)){
     x = 0.0;
     }
     
    if(!isFullScreen){
        if((y>0 && current.x >0) || (y<0 &&current.x <-8)){
            y = 0.0;
        }
    }else{
        if((y>0 && current.x >-7) || (y<0 &&current.x <-17)){
            y = 0.0;
        }
    }
    
    CC3Vector changeVector = cc3v(y, x,0.0);
    
    CC3Vector increment = CC3VectorAdd(current, changeVector);
    
    [car setRotation:increment];
    
}

-(void)makeFullScreen{
    CC3MeshNode* car = (CC3MeshNode*)[self getNodeNamed:@"testcar"];
    //car.location = cc3v(0, 5, 0);
    //car.rotation = cc3v(-18, 180, 0);
    
    car.location = cc3v(5.0, 0, 0);
    car.rotation = cc3v(-9, 180, 0);
    car.scale = cc3v(1.1, 1.1, 1.1);
    isFullScreen = YES;
}

-(void)exitFullScreen{
    CC3MeshNode* car = (CC3MeshNode*)[self getNodeNamed:@"testcar"];
    //car.location = cc3v(0, -2, 0);
    //car.rotation = cc3v(-11, 180, 0);
    car.location = cc3v(4.5, -7, 0);
    car.rotation = cc3v(-2, 180, 0);
    car.scale = cc3v(1.0, 1.0, 1.0);
    isFullScreen = NO;
}

-(void)showBox:(int)numOfBoxes {
    
    CC3MeshNode* testcar = (CC3MeshNode*)[self getNodeNamed:@"testcar"];
    
    //Add Box Node1
    CC3MeshNode* aNode1;
    aNode1 = [CC3BoxNode nodeWithName: @"box1"];
    CC3BoundingBox bBox1;
    bBox1.minimum = cc3v( 1.7, 1.2, -0.5);
    bBox1.maximum = cc3v( 7.7, 4.2,  0.0);
    [aNode1 populateAsSolidBox: bBox1];
    [aNode1 setLocation:cc3v(0.0f,0.0f,-35.5f)];
    CC3Material *board1 = [CC3Material materialWithName:@"board"];
    board1.texture = [CC3Texture textureFromFile:@"cardboard_texture.png"];
    aNode1.material = board1;
    [testcar addChild:aNode1];
    
    //Box animation
    CC3Vector newLocVector1 = cc3v(0.0, -1.0, -11.5);
    CCActionInterval* boxAction1 = [CC3MoveTo actionWithDuration:1.0f moveTo: newLocVector1];
    boxAction1 = [CCEaseOut actionWithAction: [CCEaseIn actionWithAction: boxAction1 rate: 20.0f] rate: 1.6f];
    
    //CC3Material *board2 = [CC3Material materialWithName:@"board"];
    //board2.texture = [CC3Texture textureFromFile:@"cardboard-texture.jpg"];
    
    //Add box 3
    CC3MeshNode* aNode2;
    aNode2 = [CC3BoxNode nodeWithName: @"box2"];
    CC3BoundingBox bBox2;
    bBox2.minimum = cc3v(1.5, 1.2, -1.5);
    bBox2.maximum = cc3v(8.1, 1.7, 1.0);
    [aNode2 populateAsSolidBox: bBox2];
    [aNode2 setLocation:cc3v(0.0f,0.0f,-35.5f)];
    aNode2.material = board1;
    [testcar addChild:aNode2];
    
    //Box animation
    CC3Vector newLocVector2 = cc3v(0.0, -1.0, -14);
    CCActionInterval* boxAction2 = [CC3MoveTo actionWithDuration:1.5f moveTo: newLocVector2];
    boxAction2 = [CCEaseOut actionWithAction: [CCEaseIn actionWithAction: boxAction2 rate: 20.0f] rate: 1.6f];
    
    
    
    //Add Box Node
    CC3MeshNode* aNode3;
    aNode3 = [CC3BoxNode nodeWithName: @"box3"];
    CC3BoundingBox bBox3;
    bBox3.minimum = cc3v(6, 1.7, -0.5);
    bBox3.maximum = cc3v(8, 3.7,  1.0);
    [aNode3 populateAsSolidBox: bBox3];
    [aNode3 setLocation:cc3v(0.0f,0.0f,-35.5f)];
    aNode3.material = board1;
    [testcar addChild:aNode3];
    
    //Box animation
    CC3Vector newLocVector3 = cc3v(0.0, -1.0, -14);
    CCActionInterval* boxAction3 = [CC3MoveTo actionWithDuration:2.0f moveTo: newLocVector3];
    boxAction3 = [CCEaseOut actionWithAction: [CCEaseIn actionWithAction: boxAction3 rate: 20.0f] rate: 1.6f];
    
    
    //Add Box Node
    CC3MeshNode* aNode4;
    aNode4 = [CC3BoxNode nodeWithName: @"box4"];
    CC3BoundingBox bBox4;
    bBox4.minimum = cc3v(2, 1.2, -0.5);
    bBox4.maximum = cc3v(4, 5.2,  0.0);
    [aNode4 populateAsSolidBox: bBox4];
    [aNode4 setLocation:cc3v(0.0f,30.5f,0.0f)];
    aNode4.material = board1;
    [testcar addChild:aNode4];
    
    //Box animation
    CC3Vector newLocVector4 = cc3v(0.0, -1.0, -12.0);
    CCActionInterval* boxAction4 = [CC3MoveTo actionWithDuration:2.5f moveTo: newLocVector4];
    boxAction4 = [CCEaseOut actionWithAction: [CCEaseIn actionWithAction: boxAction4 rate: 20.0f] rate: 1.6f];
    
    
    //Add Box Node
    CC3MeshNode* aNode5;
    aNode5 = [CC3BoxNode nodeWithName: @"box5"];
    CC3BoundingBox bBox5;
    bBox5.minimum = cc3v(1.5, 1.7, -0.5);
    bBox5.maximum = cc3v(5.5, 3.2,  1.0);
    
    [aNode5 populateAsSolidBox: bBox5];
    [aNode5 setLocation:cc3v(0.0f,0.0f,-35.5f)];
    [aNode5 setRotation:cc3v(0.0f,3.0f,0.0f)];
    aNode5.material = board1;
    [testcar addChild:aNode5];
    
    //Box animation
    CC3Vector newLocVector5 = cc3v(0.0, -1.0, -14.5);
    CCActionInterval* boxAction5 = [CC3MoveTo actionWithDuration:3.0f moveTo: newLocVector5];
    boxAction5 = [CCEaseOut actionWithAction: [CCEaseIn actionWithAction: boxAction5 rate: 20.0f] rate: 1.6f];
    
    
    //Add Box Node
    CC3MeshNode* aNode6;
    aNode6 = [CC3BoxNode nodeWithName: @"box6"];
    CC3BoundingBox bBox6;
    bBox6.minimum = cc3v(3.0, 3.2, -0.5);
    bBox6.maximum = cc3v(5.5, 4.2,  1.0);
    
    [aNode6 populateAsSolidBox: bBox6];
    [aNode6 setLocation:cc3v(0.0f,0.0f,-35.5f)];
    [aNode6 setRotation:cc3v(0.0f,-5.0f,0.0f)];
    aNode6.material = board1;
    [testcar addChild:aNode6];
    
    //Box animation
    CC3Vector newLocVector6 = cc3v(0.0, -1.0, -14.5);
    CCActionInterval* boxAction6 = [CC3MoveTo actionWithDuration:3.5f moveTo: newLocVector6];
    boxAction6 = [CCEaseOut actionWithAction: [CCEaseIn actionWithAction: boxAction6 rate: 20.0f] rate: 1.6f];
    
    
    
    switch (numOfBoxes){
        case 1:{
            [aNode1 runAction:boxAction1];
        }
                
        break;
        case 2:{
            [aNode1 runAction:boxAction1];
            [aNode2 runAction:boxAction2];
        }
        break;
        case 3:{
            [aNode1 runAction:boxAction1];
            [aNode2 runAction:boxAction2];
            [aNode3 runAction:boxAction3];
        }
        break;
        case 4:{
            [aNode1 runAction:boxAction1];
            [aNode2 runAction:boxAction2];
            [aNode3 runAction:boxAction3];
            [aNode4 runAction:boxAction4];
        }
        break;
        case 5:{
            [aNode1 runAction:boxAction1];
            [aNode2 runAction:boxAction2];
            [aNode3 runAction:boxAction3];
            [aNode4 runAction:boxAction4];
            [aNode5 runAction:boxAction5];
        }
        break;
        case 6:{
            [aNode1 runAction:boxAction1];
            [aNode2 runAction:boxAction2];
            [aNode3 runAction:boxAction3];
            [aNode4 runAction:boxAction4];
            [aNode5 runAction:boxAction5];
            [aNode6 runAction:boxAction6];
        }
        break;
    }
    

}

- (void) removeBoxes{
    CC3MeshNode* testcar = (CC3MeshNode*)[self getNodeNamed:@"testcar"];
    
    CC3MeshNode* box1 = (CC3MeshNode*)[testcar getNodeNamed:@"box1"];
    CC3MeshNode* box2 = (CC3MeshNode*)[testcar getNodeNamed:@"box2"];
    CC3MeshNode* box3 = (CC3MeshNode*)[testcar getNodeNamed:@"box3"];
    CC3MeshNode* box4 = (CC3MeshNode*)[testcar getNodeNamed:@"box4"];
    CC3MeshNode* box5 = (CC3MeshNode*)[testcar getNodeNamed:@"box5"];
    CC3MeshNode* box6 = (CC3MeshNode*)[testcar getNodeNamed:@"box6"];
    [testcar removeChild:box1];
    [testcar removeChild:box2];
    [testcar removeChild:box3];
    [testcar removeChild:box4];
    [testcar removeChild:box5];
    [testcar removeChild:box6];
}

@end

