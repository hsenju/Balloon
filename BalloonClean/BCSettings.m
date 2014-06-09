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
@property (strong, nonatomic) BCParseUser *parseUser;
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
    [self shouldStartPhotoLibraryPickerController];
}

#pragma mark - UIImagePickerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:NO completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    self.profilePicture.image = image;
}

- (BOOL)shouldStartPhotoLibraryPickerController {
    if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] == NO
         && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)) {
        return NO;
    }
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]
        && [[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary] containsObject:(NSString *)kUTTypeImage]) {
        
        cameraUI.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        cameraUI.mediaTypes = [NSArray arrayWithObject:(NSString *) kUTTypeImage];
        
    } else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]
               && [[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum] containsObject:(NSString *)kUTTypeImage]) {
        
        cameraUI.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        cameraUI.mediaTypes = [NSArray arrayWithObject:(NSString *) kUTTypeImage];
        
    } else {
        return NO;
    }
    
    cameraUI.allowsEditing = YES;
    cameraUI.delegate = self;
    
    [self presentViewController:cameraUI animated:YES completion:nil];
    
    return YES;
}
- (IBAction)linkFacebookTouched:(id)sender {
    // We will request the user's public profile and the user's birthday
    // These are the permissions we need:
    //NSArray *requestPermissions = @[@"public_profile"];
    
    // Open session with public_profile (required) and user_birthday read permissions
    [FBSession openActiveSessionWithReadPermissions:@[@"public_profile"]
                                       allowLoginUI:YES
                                  completionHandler:
     ^(FBSession *session, FBSessionState state, NSError *error) {
         __block NSString *alertText;
         __block NSString *alertTitle;
         if (!error){
             // If the session was opened successfully
             if (state == FBSessionStateOpen){
                 [self makeRequestForUserData];
                 
             } else {
                 // There was an error, handle it
                 if ([FBErrorUtility shouldNotifyUserForError:error] == YES){
                     // Error requires people using an app to make an action outside of the app to recover
                     // The SDK will provide an error message that we have to show the user
                     alertTitle = @"Something went wrong";
                     alertText = [FBErrorUtility userMessageForError:error];
                     [[[UIAlertView alloc] initWithTitle:alertTitle
                                                 message:alertText
                                                delegate:self
                                       cancelButtonTitle:@"OK!"
                                       otherButtonTitles:nil] show];
                     
                 } else {
                     // If the user cancelled login
                     if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
                         alertTitle = @"cancelled";
                         [[[UIAlertView alloc] initWithTitle:alertTitle
                                                     message:alertText
                                                    delegate:self
                                           cancelButtonTitle:@"OK!"
                                           otherButtonTitles:nil] show];
                         
                     } else {
                         // For simplicity, in this sample, for all other errors we show a generic message
                         // You can read more about how to handle other errors in our Handling errors guide
                         // https://developers.facebook.com/docs/ios/errors/
                         NSDictionary *errorInformation = [[[error.userInfo objectForKey:@"com.facebook.sdk:ParsedJSONResponseKey"]
                                                            objectForKey:@"body"]
                                                           objectForKey:@"error"];
                         alertTitle = @"Something went wrong";
                         alertText = [NSString stringWithFormat:@"Please retry. \n If the problem persists contact us and mention this error code: %@",
                                      [errorInformation objectForKey:@"message"]];
                         [[[UIAlertView alloc] initWithTitle:alertTitle
                                                     message:alertText
                                                    delegate:self
                                           cancelButtonTitle:@"OK!"
                                           otherButtonTitles:nil] show];
                     }
                 }
             }
             
         }
     }];
}

- (void)makeRequestForUserData {
    [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            // Success! Include your code to handle the results here
            NSDictionary *userData = (NSDictionary *)result;
            NSString *facebookID = userData[@"id"];
            NSString *name = userData[@"name"];
            _imagedata = [[NSMutableData alloc] init];
            NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1",facebookID]];
            NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:pictureURL
                                                                      cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                                  timeoutInterval:2.0f];
            [NSURLConnection connectionWithRequest:urlRequest delegate:self];
            self.username.text = name;
            
            
        } else {
            // An error occurred, we need to handle the error
            // See: https://developers.facebook.com/docs/ios/errors
        }
    }];
}

#pragma mark - NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // receive image data from facebook
    _imagedata = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // append the image data from facebook to our current version of the image data
    [_imagedata appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // once the facebook profile image has finished loading, save the image to parse.
    UIImage *image = [UIImage imageWithData:_imagedata];
    self.profilepicture.image = image;
    self.edited = true;
    [self textChanged:self.username];
}
- (IBAction)logOutTouched:(id)sender {
}

@end
