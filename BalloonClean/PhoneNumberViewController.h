//
//  PhoneNumberViewController.h
//  Balloon
//
//  Created by Hikari Senju on 5/23/14.
//
//

#import <UIKit/UIKit.h>

@interface PhoneNumberViewController : UIViewController <UITextFieldDelegate>
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end
