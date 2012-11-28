//
//  DetailViewController.m
//  IkeaFit3D
//
//  Created by Alice.Chen on 8/7/12.
//
//

#import "DetailViewController.h"
#import "TrunkViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize detailContentImageView;
@synthesize btnInTrunk;
@synthesize btnOutTrunk;
@synthesize btnDelete;
@synthesize backBtn;
@synthesize selectedIndex;
@synthesize isInTrunk;
@synthesize itemNumber;

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
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 55, 24)];
    [backButton setImage:[UIImage imageNamed:@"back-btn@2x.png"] forState:UIControlStateNormal];
    [backButton setShowsTouchWhenHighlighted:TRUE];
    [backButton addTarget:self action:@selector(backBtnPressed:) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *barBackItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.hidesBackButton = TRUE;
    self.navigationItem.leftBarButtonItem = barBackItem;

    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"detail-nav-bar.png"] forBarMetrics:UIBarMetricsDefault];
    
    [[self btnInTrunk] setImage:[UIImage imageNamed:@"in-trunk-btn-selected@2x.png"] forState:UIControlStateSelected];
    
    [[self btnOutTrunk] setImage:[UIImage imageNamed:@"out-of-trunk-btn-selected@2x.png"] forState:UIControlStateSelected];


    
    if(self.isInTrunk != @"NO"){
        [btnInTrunk setSelected:YES];
        [btnOutTrunk setSelected:NO];
    }
    else{
        [btnInTrunk setSelected:NO];
        [btnOutTrunk setSelected:YES];
    }
    
    if([self.itemNumber intValue] == 3 || [self.itemNumber intValue] ==6){
        [detailContentImageView setImage:[UIImage imageNamed:@"detail-content-2@2x.png"]];
    }

}

- (IBAction)deleteBtnPressed:(id)sender {
    NSArray *viewControllerArray = [self.navigationController viewControllers];
    int parentViewControllerIndex = [viewControllerArray count] - 2;
    [[viewControllerArray objectAtIndex:parentViewControllerIndex] deleteListItem:self.selectedIndex];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)outTrunkBtnPressed:(id)sender {
    NSArray *viewControllerArray = [self.navigationController viewControllers];
    int parentViewControllerIndex = [viewControllerArray count] - 2;
    [[viewControllerArray objectAtIndex:parentViewControllerIndex] pressOutTrunk:self.selectedIndex];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)inTrunkBtnPressed:(id)sender {
    NSArray *viewControllerArray = [self.navigationController viewControllers];
    int parentViewControllerIndex = [viewControllerArray count] - 2;
    [[viewControllerArray objectAtIndex:parentViewControllerIndex] pressInTrunk:self.selectedIndex];
    [self.navigationController popViewControllerAnimated:YES];

}

-(void) setViewDetails:(int)tagIndex isInTrunk:(NSString*)inTrunk itemNumber:(NSNumber*)itemNum{
    self.selectedIndex = tagIndex;
    self.isInTrunk = inTrunk;
    self.itemNumber = itemNum;
}

- (void)viewDidUnload
{
    [self setBackBtn:nil];
    [self setBtnInTrunk:nil];
    [self setBtnOutTrunk:nil];
    [self setBtnDelete:nil];
    [self setDetailContentImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [backBtn release];
    [btnInTrunk release];
    [btnOutTrunk release];
    [btnDelete release];
    [detailContentImageView release];
    [super dealloc];
}
- (IBAction)backBtnPressed:(id)sender {

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationItem.hidesBackButton = YES;
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


@end
