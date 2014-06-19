//
//  BCCreateGroupViewController.m
//  BalloonClean
//
//  Created by Sean Wertheim on 6/5/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import "BCCreateGroupViewController.h"


@interface BCCreateGroupViewController () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *listNameTextField;
@property (strong, nonatomic) BCParseContactList *listToAdd;
@property (strong, nonatomic) IBOutlet UISwitch *shareListWithMembersSwitch;
@property (strong, nonatomic) IBOutlet UIImageView *addPhotoImageView;
@property (strong, nonatomic) IBOutlet UILabel *addPhotoLabel;
@property (strong, nonatomic) IBOutlet UILabel *defaultIfEmptyLabel;

@end

@implementation BCCreateGroupViewController

static const NSString *kToContactsSelectorSegueIdentifier = @"createGroupToContactsSelector";

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
    self.listToAdd = [BCParseContactList object];
    self.listNameTextField.delegate = self;
    
    //setup for clickable uiimageview to add photo
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPhotoTapDetected)];
    singleTap.numberOfTapsRequired = 1;
    [self.addPhotoImageView addGestureRecognizer:singleTap];
}

#pragma mark -- UIImagePickerControllerDelegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    //set uiimageview's image to selected photo and blank out text
    [self.addPhotoImageView setImage:chosenImage];
    [self.addPhotoLabel setHidden:YES];
    [self.defaultIfEmptyLabel setHidden:YES];
//    [self.listToAdd setGroupImageFileWithUIImage:chosenImage];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark -- IBActions and Gesture Recognizer Selectors

- (IBAction)addContactsButtonPressed:(id)sender {
    if(self.listNameTextField.text && self.listNameTextField.text.length > 0){
        
        SMContactsSelector *controller = [[SMContactsSelector alloc] initWithNibName:@"SMContactsSelector" bundle:nil];
        controller.delegate = self;
        controller.requestData = DATA_CONTACT_TELEPHONE;
        controller.showModal = YES; //Mandatory: YES or NO
        controller.showCheckButton = YES; //Mandatory: YES or NO
        [self presentViewController:controller animated:YES completion:nil];
    
    } else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Empty Group Name"
                                                        message:@"Please enter a group name."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)addPhotoTapDetected{
    //want to choose photo from photo roll
    UIImagePickerController* picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)cancelPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:Nil];
}

#pragma mark -- TextField delegate methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([self.listNameTextField isFirstResponder] && [touch view] != self.listNameTextField) {
        [self.listNameTextField resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

#pragma mark -- SMContactsSelectorDelegate Methods

-(void)contactsSelectorDidDismissItself{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)numberOfRowsSelected:(NSInteger)numberRows withData:(NSArray *)data andDataType:(DATA_CONTACT)type
{
    if (data && data.count >0) {
        
        NSDictionary *paramsDictionary = [NSDictionary dictionaryWithObject:data forKey:@"addedContacts"];
        
        [PFCloud callFunctionInBackground:@"conditionalUserCreate"
                           withParameters:paramsDictionary
                                    block:^(NSNumber *ratings, NSError *error) {
                                        if (!error) {
                                            NSLog(@"there was no error");
                                        }
                                    }];
        
//        //User Already Exists
//        NSMutableSet *phoneNumbers = [NSMutableSet set];
//        
//        for (NSDictionary *dict in data) {
//            NSString *phoneString = [NSString stringWithFormat:@"%@", dict[@"number"]];
//            [phoneNumbers addObject:phoneString];
//        }
//        
//        PFQuery *existingUsers = [BCParseUser query];
//        [existingUsers whereKey:@"mobilePhone" containedIn:[NSArray arrayWithObjects:[phoneNumbers allObjects], nil]];
//        
//        [existingUsers findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//            if (!error) {
//                // The find succeeded.
//                NSLog(@"Successfully retrieved %d scores.", objects.count);
//                // Do something with the found objects
//                for (PFObject *object in objects) {
//                    NSLog(@"%@", object.objectId);
//                }
//            } else {
//                // Log details of the failure
//                NSLog(@"Error: %@ %@", error, [error userInfo]);
//            }
//        }];
//        
//        
//        self.listToAdd.name = self.listNameTextField.text;
//        NSMutableArray *membersArray = [NSMutableArray array];
//        for (NSDictionary *dict in data) {
//            
//            NSString *phoneString = [NSString stringWithFormat:@"%@", dict[@"number"]];
//            
//            BCParseUser *addedUser = [BCParseUser object];
//            addedUser.mobilePhone = phoneString;
//            addedUser.name = (NSString*)dict[@"name"];
//            [addedUser saveInBackground];
//            
//            [membersArray addObject:addedUser];
//        }
//        
//        self.listToAdd.users = membersArray;
//        self.listToAdd.visible = self.shareListWithMembersSwitch.on;
//        [self.listToAdd saveInBackground];
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
