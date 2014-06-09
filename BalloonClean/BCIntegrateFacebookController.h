//
//  BCIntegrateFacebookController.h
//  BalloonClean
//
//  Created by Hikari Senju on 6/8/14.
//  Copyright (c) 2014 Balloon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCIntegrateFacebookController : UIViewController  <UIImagePickerControllerDelegate>

- (void)facebookrequest: (UIImageView*)image textField:(UITextField*)textField;
- (void)makeRequestForUserData  (UIImageView*)image textField:(UITextField*)textField;
@end
