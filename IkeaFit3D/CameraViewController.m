//
//  CameraViewController.m
//  IkeaFit3D
//
//  Created by Alice.Chen on 8/6/12.
//
//

#import "CameraViewController.h"
#import "IkeaFit3DScene.h"
#import "IkeaFit3DLayer.h"
#import "TrunkViewController.h"
#import "IkeaFit3DAppDelegate.h"

@interface CameraViewController ()

@end

@implementation CameraViewController

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
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        self.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    } else {
        
        self.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.showsCameraControls = NO;
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
        
        self.cameraOverlayView = overlayView;
        
        UIImageView *bottomBar = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"camera-bar-bg@2x.png"]];
        bottomBar.frame =  CGRectMake(0,426,320,55);
        [self.view addSubview:bottomBar];
        
        UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(110, 437, 100, 34)];
        [cancelBtn setBackgroundImage:[UIImage imageNamed:@"camera-cancel-btn@2x.png"] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:cancelBtn];
        
        //[self performSelector:@selector(addItem) withObject:nil afterDelay:5];
        
        timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(displayLoading) userInfo:nil repeats:NO];
        timer = [NSTimer scheduledTimerWithTimeInterval:4.8 target:self selector:@selector(displaySuccess) userInfo:nil repeats:NO];
        timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(addItem) userInfo:nil repeats:NO];

        
    }
    


}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)cancelButtonPressed:(UIButton *)sender {
    [self dismissModalViewControllerAnimated:YES];
    [timer invalidate];
    
}

-(void)displayLoading{
    [indicator startAnimating];
}

-(void)displaySuccess{
    UIImageView *successView = [[UIImageView alloc] initWithFrame:CGRectMake(68,206,185,51)];
    successView.image = [UIImage imageNamed:@"camera-success@2x.png"];
    [indicator stopAnimating];
    [self.cameraOverlayView addSubview:successView];

}

-(void)addItem{
    NSLog(@"add item");
    CCScene * scene = [[CCDirector sharedDirector] runningScene];
    id layer = [scene getChildByTag:11];
    
    IkeaFit3DAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    delegate.itemCount +=1;
    
    [layer tellSceneToRemoveBoxes];
    [layer tellSceneToShowBoxes:delegate.itemCount];
    
    
    
    TrunkViewController *parentView = (TrunkViewController*)[[self navigationController] presentingViewController];
           if( [parentView.listView viewWithTag:delegate.itemCount] == nil){
            [parentView addListItem:delegate.itemCount];
        }


    
    [self dismissModalViewControllerAnimated:YES];
}


@end
