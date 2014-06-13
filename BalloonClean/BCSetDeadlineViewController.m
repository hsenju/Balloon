//
//  BCSetDeadlineViewController.m
//  BalloonClean
//
//  Created by Sean Wertheim on 6/12/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import "BCSetDeadlineViewController.h"
#import "BCLandingPageViewController.h"

@interface BCSetDeadlineViewController ()

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UILabel *deadlineLabel;

@end

@implementation BCSetDeadlineViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    BCLandingPageViewController *landingPage = (BCLandingPageViewController*)[segue destinationViewController];
    
    landingPage.members = self.members;
    landingPage.plan = self.plan;
    landingPage.location = self.location;
    landingPage.expirationDate = [self.datePicker date];
    landingPage.groupName = self.groupName;
}

-(void)setDeadlineLabelAfterDatePicked{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // you can use one of the builtin localizated formats
    [formatter setDateStyle:NSDateFormatterNoStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    self.deadlineLabel.text = [formatter stringFromDate:self.datePicker.date];
}

- (void) dateChanged:(id)sender{
    [self setDeadlineLabelAfterDatePicked];
}

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
    [self.datePicker addTarget:self action:@selector(setDeadlineLabelAfterDatePicked) forControlEvents:UIControlEventValueChanged];
    [self setDeadlineLabelAfterDatePicked];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
