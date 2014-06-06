//
//  BCCreateGroupViewController.m
//  BalloonClean
//
//  Created by Sean Wertheim on 6/5/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import "BCCreateGroupViewController.h"


@interface BCCreateGroupViewController () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *groupNameTextField;
@property (strong, nonatomic) BCParseGroup *groupToAdd;

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
    self.groupToAdd = [BCParseGroup object];
    self.groupNameTextField.delegate = self;
}

- (IBAction)addPhotoButtonPressed:(id)sender {
    //want to choose photo from photo roll
    UIImagePickerController* picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    [self.groupToAdd setGroupImageFileWithUIImage:chosenImage];
    
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)doneButtonPressed:(id)sender {
    if(self.groupNameTextField.text && self.groupNameTextField.text.length > 0){
        SMContactsSelector *controller = [[SMContactsSelector alloc] initWithNibName:@"SMContactsSelector" bundle:nil];
        controller.delegate = self;
        controller.requestData = DATA_CONTACT_TELEPHONE;
        controller.showModal = YES; //Mandatory: YES or NO
        controller.showCheckButton = YES; //Mandatory: YES or NO
        
        // Set your contact list setting record ids (optional)
        //controller.recordIDs = [NSArray arrayWithObjects:@"1", @"2", nil];
        
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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

// It is important for you to hide kwyboard

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([self.groupNameTextField isFirstResponder] && [touch view] != self.groupNameTextField) {
        [self.groupNameTextField resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

- (void)numberOfRowsSelected:(NSInteger)numberRows withData:(NSArray *)data andDataType:(DATA_CONTACT)type
{
    if (data && data.count >0) {
        self.groupToAdd.groupName = self.groupNameTextField.text;
        self.groupToAdd.membersByPhoneNumber = [NSMutableArray arrayWithArray: data];
        [self.groupToAdd saveInBackground];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
