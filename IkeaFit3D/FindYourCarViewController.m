//
//  FindYourCarViewController.m
//  IkeaFit3D
//
//  Created by Alice.Chen on 7/31/12.
//
//

#import "FindYourCarViewController.h"

@interface FindYourCarViewController ()

@end

@implementation FindYourCarViewController
@synthesize selectCarView;

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
    self.navigationItem.hidesBackButton = YES;
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setSelectCarView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [selectCarView release];
    [super dealloc];
}

- (IBAction)swipeCar:(UISwipeGestureRecognizer *)sender {
    
    UIView* itemView = [(UITapGestureRecognizer*)sender view];
    CGRect viewRect = [itemView frame];
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"swiped left");
        NSLog(@"viewRect.origin.x= %f", viewRect.origin.x);

        if(viewRect.origin.x != -1920){
            
            [UIView animateWithDuration:0.1 animations:^{
                CGRect itemRect = [itemView frame];
                itemRect.origin.x -=320;
                [itemView setFrame:itemRect];
            }
                             completion:^(BOOL finished){
                                 if(finished){

                                 }
                             }
             ];
        }else{
            CGRect itemRect = [itemView frame];
            itemRect.origin.x = 0;
            [itemView setFrame:itemRect];
        }

    }else{
        NSLog(@"swiped right");
        NSLog(@"viewRect.origin.x= %f", viewRect.origin.x);

        
        if(viewRect.origin.x != 0){
            
            [UIView animateWithDuration:0.1 animations:^{
                CGRect itemRect = [itemView frame];
                itemRect.origin.x +=320;
                [itemView setFrame:itemRect];
            }
                             completion:^(BOOL finished){
                                 if(finished){
                                     
                                 }
                             }
             ];
        }else{
            CGRect itemRect = [itemView frame];
            itemRect.origin.x = -1920;
            [itemView setFrame:itemRect];
        }

    }
}
@end
