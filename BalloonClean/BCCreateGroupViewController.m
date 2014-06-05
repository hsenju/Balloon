//
//  BCCreateGroupViewController.m
//  BalloonClean
//
//  Created by Sean Wertheim on 6/5/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import "BCCreateGroupViewController.h"


@interface BCCreateGroupViewController ()

@property (strong, nonatomic) IBOutlet UITextField *groupNameTextField;
@property (strong, nonatomic) IBOutlet UIImageView *groupPhotoImageView;

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
}

- (IBAction)doneButtonPressed:(id)sender {
    SMContactsSelector *controller = [[SMContactsSelector alloc] initWithNibName:@"SMContactsSelector" bundle:nil];
    controller.delegate = self;
    controller.requestData = DATA_CONTACT_TELEPHONE;
    controller.showModal = YES; //Mandatory: YES or NO
    controller.showCheckButton = YES; //Mandatory: YES or NO
    
    // Set your contact list setting record ids (optional)
    //controller.recordIDs = [NSArray arrayWithObjects:@"1", @"2", nil];
    
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)numberOfRowsSelected:(NSInteger)numberRows withData:(NSArray *)data andDataType:(DATA_CONTACT)type
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
