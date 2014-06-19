//
//  FacebookViewController.m
//  Balloon
//
//  Created by Hikari Senju on 5/23/14.
//
//

#import "FacebookViewController.h"
#import "BCParseUser.h"
#import <Parse/Parse.h>
#import <MobileCoreServices/UTCoreTypes.h>

@interface FacebookViewController (){
    NSMutableData *_imagedata;
}
@property (strong, nonatomic) IBOutlet UIImageView *profilepicture;
@property (strong, nonatomic) IBOutlet UIButton *editprofile;
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UIButton *facebook;
@property (strong, nonatomic) IBOutlet UIButton *done;
@property (nonatomic, retain) UIImagePickerController *picker;
@property (nonatomic, assign) bool edited;
@end

@implementation FacebookViewController

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
    self.done.enabled = false;
    self.username.placeholder = @"enter your full name";
    [self.username becomeFirstResponder];
    self.edited = false;
    self.navigationController.navigationBarHidden = YES;

    // Do any additional setup after loading the view from its nib.
}
- (IBAction)facebookButton:(id)sender {

    [super facebookrequest:self.profilepicture textField:self.username];
    
    self.edited = true;
    [self textChanged:self.username];

}

- (IBAction)editButton:(id)sender {
    [super shouldStartPhotoLibraryPickerController: self.profilepicture];
    self.edited = true;
    [self textChanged:self.username];
}

- (IBAction)textChanged:(id)sender {
    //NSRange whiteSpaceRange = [self.username.text rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *trimmedString = [self.username.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSRange whiteSpaceRange = [trimmedString rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
    self.done.enabled = [self.username.text length] > 0 && self.edited && whiteSpaceRange.location != NSNotFound ? YES : NO;
}

- (IBAction)doneButton:(id)sender {
    //get the user entries
	NSString *name = self.username.text;
    NSString *phoneNumber = self.phoneNumber;
    
    //initialize and save the user with the corresponding characterisitcs to parse
	BCParseUser *user = [BCParseUser object];
	user.username = phoneNumber;
    user.password = @"";
    user.name = name;
	[user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
		if (error) {
            //if error in saving, show error alert
			UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[[error userInfo] objectForKey:@"error"] message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
			[alertView show];
			return;
		}
        
        UIImage *profileImage = self.profilepicture.image;
        [user setUserPhotoWithImage:profileImage];
        [user saveInBackground];
        
        //if there is not error, proceed to main view
        //[(AppDelegate*)[[UIApplication sharedApplication] delegate] balloonLogin];
        [self presentMainAppView];
	}];

}

-(void)presentMainAppView{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *obj=[storyboard instantiateViewControllerWithIdentifier:@"tabAfterLogin"];
    self.navigationController.navigationBarHidden=YES;
    [self.navigationController pushViewController:obj animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
