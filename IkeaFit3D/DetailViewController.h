//
//  DetailViewController.h
//  IkeaFit3D
//
//  Created by Alice.Chen on 8/7/12.
//
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController{
    int selectedIndex;
    NSString* isInTrunk;
    NSNumber* itemNumber;
}
@property (retain, nonatomic) IBOutlet UIBarButtonItem *backBtn;
- (IBAction)backBtnPressed:(id)sender;

@property (retain, nonatomic) IBOutlet UIImageView *detailContentImageView;
@property (retain, nonatomic) IBOutlet UIButton *btnInTrunk;
@property (retain, nonatomic) IBOutlet UIButton *btnOutTrunk;
@property (retain, nonatomic) IBOutlet UIButton *btnDelete;
@property (assign, nonatomic) int selectedIndex;
@property (assign, nonatomic) NSString* isInTrunk;
@property (assign, nonatomic) NSNumber* itemNumber;

- (IBAction)deleteBtnPressed:(id)sender;
- (IBAction)outTrunkBtnPressed:(id)sender;
- (IBAction)inTrunkBtnPressed:(id)sender;
-(void) setViewDetails:(int)tagIndex isInTrunk:(NSString*)inTrunk itemNumber:(NSNumber*)itemNum;

@end
