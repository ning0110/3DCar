//
//  FindYourCarViewController.h
//  IkeaFit3D
//
//  Created by Alice.Chen on 7/31/12.
//
//

#import <UIKit/UIKit.h>

@interface FindYourCarViewController : UIViewController

@property (retain, nonatomic) IBOutlet UIView *selectCarView;

- (IBAction)swipeCar:(UISwipeGestureRecognizer *)sender;
@end
