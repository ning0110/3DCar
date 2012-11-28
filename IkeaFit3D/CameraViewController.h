//
//  CameraViewController.h
//  IkeaFit3D
//
//  Created by Alice.Chen on 8/6/12.
//
//

#import <UIKit/UIKit.h>

@interface CameraViewController : UIImagePickerController <UIImagePickerControllerDelegate>
{
    NSTimer *timer;
    UIActivityIndicatorView *indicator;

}

- (IBAction)cancelButtonPressed:(UIButton *)sender;
- (void)displayLoading;
- (void)displaySuccess;
- (void)addItem;

@end
