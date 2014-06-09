//
//  BCSettings.m
//  BalloonClean
//
//  Created by Hikari Senju on 6/6/14.
//  Copyright (c) 2014 Balloon. All rights reserved.
//

#import "BCSettings.h"
#import "BCParseUser.h"
#import <Parse/Parse.h>
#import <MobileCoreServices/UTCoreTypes.h>

@interface BCSettings ()
@property (strong, nonatomic) IBOutlet UITextField *fullName;
@property (strong, nonatomic) IBOutlet PFImageView *profilePicture;
@property (strong, nonatomic) IBOutlet UIButton *linkFacebook;
@property (strong, nonatomic) IBOutlet UIButton *logOut;
@property (strong, nonatomic) IBOutlet UIButton *profPictureButton;
@end

@implementation BCSettings

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

-(void)viewDidLoad{
    self.fullName.text = [[PFUser currentUser] objectForKey:@"name"];

    
    PFFile *imageFile = [[PFUser currentUser]  objectForKey:@"userPhotoFile"];

    if (imageFile) {
        [_profilePicture setFile:imageFile];
        [_profilePicture loadInBackground];
    }
    

}

- (IBAction)profPictureTouched:(id)sender {
    [self resignFirstResponder];
    [self shouldStartPhotoLibraryPickerController: self.profilePicture];
}

#pragma mark - UIImagePickerDelegate

- (IBAction)linkFacebookTouched:(id)sender {
    [super facebookrequest:self.profilePicture textField:self.fullName];

}

- (IBAction)logOut:(id)sender {
    [PFUser logOut]; // Log out
    
    // Return to login page
    [self performSegueWithIdentifier:@"logOutSegue" sender:self];
    
}

@end
