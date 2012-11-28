//
//  TrunkViewController.h
//  IkeaFit3D
//
//  Created by Alice.Chen on 7/31/12.
//
//

#import <UIKit/UIKit.h>
#import "CCNodeController.h"

typedef enum {
    lDefault,
    lHidden,
    lShown,
}ViewState;

@interface TrunkViewController : UIViewController <UIGestureRecognizerDelegate, UIScrollViewDelegate, UIImagePickerControllerDelegate> {
    UIWindow* window;
	CCNodeController* viewController;
    CGFloat startX, endX, startY, endY;
    UIView *TrunkView;
    UIView *ListView;
    ViewState currentState;
    float yposition;
    NSTimer *timer1;
    NSTimer *timer2;
    NSTimer *timer3;
    UIActivityIndicatorView *indicator;
    UIImagePickerController *picker;
    int totalItemCount;
    int totalOutTrunkItemCount;
    NSMutableArray *itemsArray;
}

@property (nonatomic, retain) UIWindow* window;
@property (strong, nonatomic) IBOutlet UIView  *trunkView;
@property (strong, nonatomic) IBOutlet UIView  *listView;
@property (assign, nonatomic) ViewState CurrentState;
@property (retain, nonatomic) IBOutlet UIButton *dragButton;
@property (retain, nonatomic) IBOutlet UIScrollView *listScrollView;
@property (retain, nonatomic) IBOutlet UIImageView *emptyList;
@property (assign, nonatomic) int totalItemCount;
@property (assign, nonatomic) int totalOutTrunkItemCount;
@property (retain, nonatomic) IBOutlet UILabel *trunkStatusLabel;


- (IBAction)itemButtonPressed:(UIButton *)sender;
- (void)move:(id)sender;
- (void) setCurrentViewState:(ViewState)state;
- (IBAction)handleSwipeUp:(UISwipeGestureRecognizer *)sender;
- (IBAction)handleSwipeDown:(UISwipeGestureRecognizer *)sender;
- (IBAction)listSwipe:(UISwipeGestureRecognizer *)sender;
- (void) itemOutTrunk:(UIView*)itemView delete:(BOOL)isDelete;
- (void) addListItem;
- (void) pressInTrunk:(int)index;
- (void) pressOutTrunk:(int)index;
- (void) deleteListItem:(int)index;

- (IBAction)startScan:(id)sender;
- (IBAction)cancelButtonPressed:(UIButton *)sender;
- (void)displayLoading;
- (void)displaySuccess;
- (void)addItem;
- (void)loadItems;
- (void)displayTrunkStatus;
- (void)hideTrunkStatus;

@end
