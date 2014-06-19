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
#import "BCNearbyVenuesViewController.h"

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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    BCNearbyVenuesViewController *destination = (BCNearbyVenuesViewController*)[segue destinationViewController];
    destination.plan = self.planTextField.text;
    destination.members = [NSMutableSet setWithSet:self.selectedMembers];
    destination.groupName = self.groupName;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapRecognized:)];
    singleTap.numberOfTapsRequired = 1;
    [self.planTextField addGestureRecognizer:singleTap];
    
    self.planTextField.delegate = self;
    self.planTextField.text = @"What's the plan? \n\n (e.g. Let's go to the Shake Shack at 8PM)";
}

- (void)singleTapRecognized:(UIGestureRecognizer *)gestureRecognizer {
    UITextView *tappedView = (UITextView*)gestureRecognizer.view;
    
    if ([tappedView.text isEqualToString:@"What's the plan? \n\n (e.g. Let's go to the Shake Shack at 8PM)"]) {
        tappedView.text = @"";
        tappedView.textColor = [UIColor blackColor]; //optional
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [self.planTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark == UITextFieldDelegate methods

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"What's the plan? \n\n (e.g. Let's go to the Shake Shack at 8PM)";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}

@end
