//
//  TrunkViewController.m
//  IkeaFit3D
//
//  Created by Alice.Chen on 7/31/12.
//
//

#import "TrunkViewController.h"
#import "IkeaFit3DLayer.h"
#import "IkeaFit3DScene.h"
#import "CC3EAGLView.h"
#import <QuartzCore/QuartzCore.h>
#import "IkeaFit3DAppDelegate.h"
#import "DetailViewController.h"

@interface TrunkViewController ()

@end

@implementation TrunkViewController
@synthesize listScrollView;
@synthesize emptyList;

@synthesize window;
@synthesize trunkView = TrunkView;
@synthesize listView = ListView;
@synthesize CurrentState = currentState;
@synthesize dragButton;
@synthesize totalItemCount;
@synthesize totalOutTrunkItemCount;
@synthesize trunkStatusLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
    [self.navigationController setNavigationBarHidden:YES animated:NO];

 	[self setCurrentViewState:lDefault];
	
    totalItemCount = 0;
    yposition = 0;
    itemsArray = [[NSMutableArray alloc] init];
    
    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    if( ! [CCDirector setDirectorType:kCCDirectorTypeDisplayLink] )
		[CCDirector setDirectorType:kCCDirectorTypeDefault];
	
	CCDirector *director = [CCDirector sharedDirector];
    
    [director setDeviceOrientation:kCCDeviceOrientationPortrait];
    
	[director setAnimationInterval:1.0/60];
	[director setDisplayFPS:NO];
    
    CC3EAGLView *glView = [CC3EAGLView viewWithFrame: [window bounds]
									  pixelFormat: kEAGLColorFormatRGBA8
									  depthFormat: GL_DEPTH_COMPONENT16_OES
							   preserveBackbuffer: NO
									   sharegroup: nil
									multiSampling: YES
								  numberOfSamples: 15];
    
    // Turn on multiple touches if needed
	[glView setMultipleTouchEnabled: YES];
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [panRecognizer setDelegate:self];
    [glView addGestureRecognizer:panRecognizer];
    

    // attach the openglView to the director
	[director setOpenGLView:glView];

    
    [self.trunkView addSubview: glView];

    [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];

    
    CC3Layer* cc3Layer = [[IkeaFit3DLayer alloc] initWithColor:ccc4(248,189,27,255)];
	[cc3Layer scheduleUpdate];
    cc3Layer.isTouchEnabled = YES;
	
	// Create the customized 3D scene, attach it to the layer, and start it playing.
	cc3Layer.cc3Scene = [IkeaFit3DScene scene];

	ControllableCCLayer* mainLayer = cc3Layer;
    mainLayer.tag = 11;

    viewController = [[CCNodeController controller] retain];
	viewController.doesAutoRotate = NO;
	[viewController runSceneOnNode: mainLayer];		// attach the layer to the controller and run a scene with it
    
    //list view initializing
    
    listScrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common-bg.png"]];

    listScrollView.delegate = self;
    listScrollView.scrollEnabled = YES;
    
    listScrollView.contentSize = CGSizeMake(320, 650);
    
    yposition = 0;

   //[self addListItem:1];
    
}

- (void)viewDidUnload
{
    [self.trunkView release];
    self.trunkView = nil;
    [self.listView release];
    self.listView = nil;
    [self setDragButton:nil];
    [self setListScrollView:nil];
    [self setEmptyList:nil];
    [self setTrunkStatusLabel:nil];
    [super viewDidUnload];
    [viewController release];
    
    // Release any retained subviews of the main view.
}

-(void)viewDidAppear:(BOOL)animated{
/*    IkeaFit3DAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    if(delegate.itemCount !=0){
        if( [self.listView viewWithTag:delegate.itemCount] == nil){
            [self addListItem:delegate.itemCount];
        }
    }*/
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)move:(id)sender{
    CCScene * scene = [[CCDirector sharedDirector] runningScene];
    id layer = [scene getChildByTag:11];
    CCDirector *director = [CCDirector sharedDirector];
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateChanged){
        CGPoint tp = [(UIPanGestureRecognizer*)sender locationInView:[director openGLView]];
        CGFloat delX = tp.x - startX;
        CGFloat delY = - tp.y + startY;
        startX = tp.x;
        startY = tp.y;
        
        
        [layer tellSceneToSpinIt:delX yaxis:delY];
    }
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        CGPoint tp = [(UIPanGestureRecognizer*)sender locationInView:[director openGLView]];
        
        startX = tp.x;
        startY = tp.y;
    }
}


- (void) setCurrentViewState:(ViewState)state{
    self.CurrentState = state;
}

- (void)dealloc {
    [self.trunkView release];
    [self.listView release];
    [dragButton release];
    [listScrollView release];
    [emptyList release];
    [trunkStatusLabel release];
    [super dealloc];
}

- (IBAction)handleSwipeUp:(UISwipeGestureRecognizer *)sender {
    NSLog(@"swipe up");
    
    switch ([self CurrentState]) {
        case lDefault:
        {
            CGRect currTopViewRect = [[self trunkView] frame];
            //currTopViewRect.origin.y -= currTopViewRect.size.height/2+49;
            currTopViewRect.origin.y = -480;
            CGRect currBottomViewRect = [[self listView] frame];
            currBottomViewRect.origin.y = 0;
            [UIView animateWithDuration:0.5 animations:^{
                [[self trunkView] setFrame:currTopViewRect];
                [[self listView] setFrame:currBottomViewRect];
            }
                             completion:^(BOOL finished){
                                 if(finished){
                                     [self setCurrentState:lShown];
                                 }
                             }
             ];
        }
            break;
        
        case lHidden:
        {
            CGRect currTopViewRect = [[self trunkView] frame];
            //currTopViewRect.origin.y -= currTopViewRect.size.height/2+49;
            currTopViewRect.origin.y = -265;
            CGRect currBottomViewRect = [[self listView] frame];
            //currBottomViewRect.origin.y = currBottomViewRect.size.height/2-49;
            currBottomViewRect.origin.y = 215;
            [UIView animateWithDuration:0.5 animations:^{
                [[self trunkView] setFrame:currTopViewRect];
                [[self listView] setFrame:currBottomViewRect];
            }
                             completion:^(BOOL finished){
                                 if(finished){
                                     [self setCurrentState:lDefault];
                                 }
                             }
             ];
            
            CCScene * scene = [[CCDirector sharedDirector] runningScene];
            id layer = [scene getChildByTag:11];
            
            [layer tellSceneToExitFullScreen];
        
        }
            break;
            
        case lShown:
        {
            //do nothing
        }
            break;
    }

}

- (IBAction)handleSwipeDown:(UISwipeGestureRecognizer *)sender {
    NSLog(@"swipe down");
    switch ([self CurrentState]) {
        case lDefault:
        {
            CGRect currTopViewRect = [[self trunkView] frame];
            //currTopViewRect.origin.y += currTopViewRect.size.height/2 -49;
            currTopViewRect.origin.y = 0;
            CGRect currBottomViewRect = [[self listView] frame];
            if(totalOutTrunkItemCount > 0){
                currBottomViewRect.origin.y = 407;
            }else{
                currBottomViewRect.origin.y = 431;
            }
                [UIView animateWithDuration:0.5 animations:^{
                [[self trunkView] setFrame:currTopViewRect];
                [[self listView] setFrame:currBottomViewRect];
                
                CCScene * scene = [[CCDirector sharedDirector] runningScene];
                id layer = [scene getChildByTag:11];
                
                [layer tellSceneToFullScreen];
            }
                             completion:^(BOOL finished){
                                 if(finished){
                                     [self setCurrentState:lHidden];
                                     
                                 }
                             }
             ];
            

        
        }
            break;
        
        case lHidden:
        {
            //do nothing
        }
            break;
        case lShown:
        {
            [UIView animateWithDuration:0.5 animations:^{
                CGRect currTopViewRect = [[self trunkView] frame];
                //currTopViewRect.origin.y += currTopViewRect.size.height/2 -49;
                currTopViewRect.origin.y = -265;
                [[self trunkView] setFrame:currTopViewRect];
                CGRect currBottomViewRect = [[self listView] frame];
                //currBottomViewRect.origin.y = currBottomViewRect.size.height/2 -49;
                currBottomViewRect.origin.y = 215;
                [[self listView] setFrame:currBottomViewRect];
            }
                             completion:^(BOOL finished){
                                 if(finished){
                                     [self setCurrentState:lDefault];
                                 }
                             }
             ];
            
            CCScene * scene = [[CCDirector sharedDirector] runningScene];
            id layer = [scene getChildByTag:11];
            
            [layer tellSceneToExitFullScreen];

        }
            break;
    }
}

- (IBAction)listSwipe:(UISwipeGestureRecognizer *)sender {

    UIView* itemView = [(UITapGestureRecognizer*)sender view];

    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self itemOutTrunk:itemView delete:YES];
    }else{
        [self itemInTrunk:itemView];
    }
    
    
    
    NSMutableArray *myArray = [[NSMutableArray alloc]initWithObjects:@"test1",@"test2",@"test3", nil];

}

- (void) itemOutTrunk:(UIView*)itemView delete:(BOOL)isDelete {
    
    CGRect btnRect = [itemView frame];
    if(btnRect.origin.x == 0){
        
        [UIView animateWithDuration:0.1 animations:^{
            CGRect itemRect = [itemView frame];
            itemRect.origin.x -=78;
            [itemView setFrame:itemRect];
        }
                         completion:^(BOOL finished){
                             if(finished){
                                 //[self setCurrentState:lDefault];
                                 
                                 int index = [(UIButton *)itemView tag];
                                 NSMutableArray *objectArray = [itemsArray objectAtIndex:index-1];
                                 NSNumber *itemNumber = [objectArray objectAtIndex:0];
                                 
                                 if([itemNumber intValue] != 3 && [itemNumber intValue] !=6){
                                     if(isDelete){
                                         totalItemCount-=1;
                                         [objectArray replaceObjectAtIndex:1 withObject:@"NO"];

                                     }                                     
                                     CCScene * scene = [[CCDirector sharedDirector] runningScene];
                                     id layer = [scene getChildByTag:11];
                                     
                                     [layer tellSceneToRemoveBoxes];
                                     [layer tellSceneToShowBoxes:totalItemCount];
                                 }
                                 
                             }
                         }
         ];
    }

}

- (void) itemInTrunk:(UIView*)itemView {
    CGRect btnRect = itemView.frame;
    if(btnRect.origin.x == -78){
        
        [UIView animateWithDuration:0.1 animations:^{
            CGRect itemRect = [itemView frame];
            itemRect.origin.x +=78;
            [itemView setFrame:itemRect];
        }
                         completion:^(BOOL finished){
                             if(finished){
                                 //[self setCurrentState:lDefault];
                                 
                                 int index = [(UIButton *)itemView tag];
                                 NSMutableArray *objectArray = [itemsArray objectAtIndex:index-1];
                                 NSNumber *itemNumber = [objectArray objectAtIndex:0];
                                 
                                 if([itemNumber intValue] != 3 && [itemNumber intValue] !=6){
                                     totalItemCount+=1;
                                     [objectArray replaceObjectAtIndex:1 withObject:@"YES"];
                                     
                                     CCScene * scene = [[CCDirector sharedDirector] runningScene];
                                     id layer = [scene getChildByTag:11];
                                     
                                     [layer tellSceneToRemoveBoxes];
                                     [layer tellSceneToShowBoxes:totalItemCount];
                                 }
                                 
                             }
                         }
         ];
    }

}


-(void) addListItem{
    emptyList.hidden = YES;
    int itemToAdd;

    if(totalItemCount <= 5){
        itemToAdd = 1 + random() % 6;
    }else{
        itemToAdd = 3;
    }
    
    if(itemToAdd != 3 && itemToAdd !=6){
        totalItemCount+=1;
        CCScene * scene = [[CCDirector sharedDirector] runningScene];
        id layer = [scene getChildByTag:11];
        
        [layer tellSceneToRemoveBoxes];
        [layer tellSceneToShowBoxes:totalItemCount];
        [itemsArray addObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:itemToAdd], @"YES", nil]];
    }else{
        [itemsArray addObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:itemToAdd], @"NO", nil]];
        totalOutTrunkItemCount+=1;
       
    }

    [self loadItems];
}

- (IBAction)itemButtonPressed:(UIButton *)sender {
    NSLog(@"itemButtonPressed!");
    [self performSegueWithIdentifier:@"detailViewSegue" sender:sender];
}

-(void) pressInTrunk:(int)index {
    
    UIButton *btn = (UIButton *)[listScrollView viewWithTag:index];
    
    [self itemInTrunk:btn];
}

-(void) pressOutTrunk:(int)index {
    NSArray *objectArray = [itemsArray objectAtIndex:index-1];
    NSString *isInTrunk = [objectArray objectAtIndex:1];

    UIButton *btn = (UIButton *)[listScrollView viewWithTag:index];

    if(isInTrunk == @"NO"){
        [self itemOutTrunk:btn delete:NO];
    }
    else{
        [self itemOutTrunk:btn delete:YES];
    }
}

-(void) deleteListItem:(int)index {
    NSArray *objectArray = [itemsArray objectAtIndex:index-1];
    NSNumber *itemNumber = [objectArray objectAtIndex:0];
    NSString *isInTrunk = [objectArray objectAtIndex:1];

    if([itemNumber intValue] != 3 && [itemNumber intValue] !=6){
        if(isInTrunk != @"NO"){
            totalItemCount-=1;
            CCScene * scene = [[CCDirector sharedDirector] runningScene];
            id layer = [scene getChildByTag:11];
            
            [layer tellSceneToRemoveBoxes];
            [layer tellSceneToShowBoxes:totalItemCount];
        }

    }else{
        // hide trunk status
        totalOutTrunkItemCount-=1;
        if(totalOutTrunkItemCount == 0){
            [self hideTrunkStatus];
        }
    }

    [itemsArray removeObjectAtIndex:index-1];
    NSLog(@"array is now: %@", [itemsArray description]);
    

    
    [self loadItems];
}

-(void) loadItems {
    
    UIButton *listItem;
    yposition = 0;
    
    for (UIView *view in listScrollView.subviews) {
        [view removeFromSuperview];
    }
    
    
    [listScrollView setContentSize:CGSizeMake(320,73*[itemsArray count]+264)];
    
    if(totalOutTrunkItemCount > 0){
        [trunkStatusLabel setText:[NSString stringWithFormat:@"%d of %d ITEMS WON'T FIT", totalOutTrunkItemCount, [itemsArray count]]];
        if(trunkStatusLabel.hidden){
            [self displayTrunkStatus];
        }
        
        UIButton *btnDelivery = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btnDelivery.frame = CGRectMake(0, 0, 320, 73);
        [btnDelivery setBackgroundImage:[UIImage imageNamed:@"btn-delivery@2x.png"] forState:UIControlStateNormal];
        //[btnDelivery addTarget:self action:@selector(getDelivery) forControlEvents:UIControlEventTouchUpInside];
                
        [listScrollView addSubview:btnDelivery];
        
        [listScrollView setContentSize:CGSizeMake(320,73*[itemsArray count]+264+113)];
        
        yposition +=73;
    }
    
    for (int x=[itemsArray count]-1; x>=0 ; x--) {
        listItem = [UIButton buttonWithType:UIButtonTypeCustom];
        listItem.tag = x+1;
        listItem.frame = CGRectMake(0,yposition,398,73);
        
        NSMutableArray *objectArray = [itemsArray objectAtIndex:x];
        NSNumber *itemNumber = [objectArray objectAtIndex:0];
        NSString *isInTrunk = [objectArray objectAtIndex:1];
        
        NSString *imageStrName = [NSString stringWithFormat:@"%@%d%@", @"listItemBgNew-", [itemNumber intValue] ,@"@2x.png"];
        [listItem setBackgroundImage:[UIImage imageNamed:imageStrName] forState:UIControlStateNormal];
        [listItem setImage:[UIImage imageNamed:@"list-bg-fit-dIcon@2x.png"] forState:UIControlStateNormal];
        
        if([itemNumber intValue] != 3 && [itemNumber intValue] !=6 && isInTrunk == @"NO"){
            [self itemOutTrunk:listItem delete:NO];
        }
        
        [listScrollView addSubview:listItem];
        
        UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc]
                                                  initWithTarget:self action:@selector(listSwipe:)];
        
        swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
        [listItem addGestureRecognizer:swipeGesture];
        
        UISwipeGestureRecognizer *swipeGestureL = [[UISwipeGestureRecognizer alloc]
                                                   initWithTarget:self action:@selector(listSwipe:)];
        
        swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
        [listItem addGestureRecognizer:swipeGestureL];
        
        [listItem addTarget:self action:@selector(itemButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        yposition+=73;

    }



}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"detailViewSegue"]) {
        
        // Get destination view
        DetailViewController *detailVC = [segue destinationViewController];
        
        NSMutableArray *objectArray = [itemsArray objectAtIndex:[(UIButton *)sender tag]-1];
        NSString *isInTrunk = [objectArray objectAtIndex:1];
        NSNumber *itemNumber = [objectArray objectAtIndex:0];

        // Pass the information to your destination view
        [detailVC setViewDetails:[(UIButton *)sender tag] isInTrunk:isInTrunk itemNumber:itemNumber];
    }
}

- (IBAction)startScan:(id)sender{
    picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    } else {
        
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.showsCameraControls = NO;
        
        UIView *overlayView = [[UIView alloc] initWithFrame:self.view.frame];
        UIImageView *instructionView = [[UIImageView alloc] initWithFrame:CGRectMake(23,10,270,44)];
        instructionView.image = [UIImage imageNamed:@"camera-instruction@2x.png"];
        
        UIImageView *frameView = [[UIImageView alloc] initWithFrame:CGRectMake(31,144,259,175)];
        frameView.image = [UIImage imageNamed:@"camera-frame@2x.png"];
        
        indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [indicator setCenter:CGPointMake(160,232)];
        
        
        
        [overlayView addSubview:instructionView];
        [overlayView addSubview:frameView];
        [overlayView addSubview:indicator];
        
        overlayView.userInteractionEnabled = YES;
        
        picker.cameraOverlayView = overlayView;
        
        UIImageView *bottomBar = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"camera-bar-bg@2x.png"]];
        bottomBar.frame =  CGRectMake(0,426,320,55);
        [picker.view addSubview:bottomBar];
        
        UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(110, 437, 100, 34)];
        [cancelBtn setBackgroundImage:[UIImage imageNamed:@"camera-cancel-btn@2x.png"] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [picker.view addSubview:cancelBtn];
        
        [self presentModalViewController: picker animated: YES];
        
        //[self performSelector:@selector(addItem) withObject:nil afterDelay:5];
        
        timer1 = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(displayLoading) userInfo:nil repeats:NO];
        timer2 = [NSTimer scheduledTimerWithTimeInterval:3.5 target:self selector:@selector(displaySuccess) userInfo:nil repeats:NO];
        timer3 = [NSTimer scheduledTimerWithTimeInterval:3.8 target:self selector:@selector(addItem) userInfo:nil repeats:NO];
        
        [picker release];
        
    }
    



}

- (IBAction)cancelButtonPressed:(UIButton *)sender {
    [timer1 invalidate];
    [timer2 invalidate];
    [timer3 invalidate];

    [self dismissModalViewControllerAnimated:YES];
}

-(void)displayLoading{
    [indicator startAnimating];
}

-(void)displaySuccess{
    UIImageView *successView = [[UIImageView alloc] initWithFrame:CGRectMake(68,206,185,51)];
    successView.image = [UIImage imageNamed:@"camera-success@2x.png"];
    [indicator stopAnimating];
    [picker.cameraOverlayView addSubview:successView];
}

-(void)addItem{

    [self addListItem];

    [self dismissModalViewControllerAnimated:YES];
}

-(void)displayTrunkStatus {
    trunkStatusLabel.hidden = NO;
    CGRect listFrame = [listScrollView frame];
    listFrame.origin.y += 24;
    listScrollView.frame = listFrame;
}

-(void)hideTrunkStatus {
    trunkStatusLabel.hidden = YES;
    CGRect listFrame = [listScrollView frame];
    listFrame.origin.y -= 24;
    listScrollView.frame = listFrame;
}



@end
