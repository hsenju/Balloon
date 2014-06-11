//
//  BCAddPlanViewController.m
//  BalloonClean
//
//  Created by Sean Wertheim on 6/11/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import "BCAddPlanViewController.h"
#import <Parse/Parse.h>
#import "BCParseUser.h"
#import "BCParseTempUser.h"

@interface BCAddPlanViewController () <UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextView *planTextField;

@end

@implementation BCAddPlanViewController

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
    
    self.planTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark == UITextFieldDelegate methods

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.placeholder = nil;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    textField.placeholder = @"What's the plan? \n\n (e.g. Let's go to the Shake Shack at 8PM)";
}

@end
