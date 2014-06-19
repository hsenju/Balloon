//
//  BCLandingPageViewController.m
//  BalloonClean
//
//  Created by Sean Wertheim on 6/13/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import "BCLandingPageViewController.h"
#import "BCParseInvitation.h"
#import <QuartzCore/QuartzCore.h>

@interface BCLandingPageViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIView *toOutlineView;
@property (strong, nonatomic) IBOutlet UIView *planOutlineView;
@property (strong, nonatomic) IBOutlet UIView *locationOutlineView;
@property (strong, nonatomic) IBOutlet UIView *popsAtOutlineView;
@property (strong, nonatomic) IBOutlet UIView *photoOutlineView;

@property (strong, nonatomic) IBOutlet UILabel *toLabel;
@property (strong, nonatomic) IBOutlet UILabel *planLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *expirationLabel;
@property (strong, nonatomic) IBOutlet UILabel *photoLabel;

@property (strong, nonatomic) UIImage *balloonImage;

@end

@implementation BCLandingPageViewController

- (IBAction)sendButtonClicked:(id)sender {
    BCParseInvitation *newInvitation = [BCParseInvitation object];
    newInvitation.invitedUsers = [NSMutableArray arrayWithArray:[self.members allObjects]];
    newInvitation.plan = self.plan;
    
    NSMutableDictionary *venueInfo = [[NSMutableDictionary alloc] init];
    venueInfo[@"venueName"] = self.location.name;
    venueInfo[@"foursquareID"] = self.location.venueId;
    
    newInvitation.venueInfo = venueInfo;
    newInvitation.deathDate = self.expirationDate;
    
    [newInvitation saveInBackground];
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
    
    [self setupViewBorders];
    [self setupLabelText];
    
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPhoto)];
    [tap setNumberOfTapsRequired:1];
    [self.photoOutlineView addGestureRecognizer:tap];
}

#pragma mark -- UIImagePickerControllerDelegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    //set uiimageview's image to selected photo and blank out text
    self.balloonImage = chosenImage;
    self.photoLabel.text = @"23475892034587.png";
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

-(void)tapPhoto{
    UIImagePickerController* picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

-(void)setupLabelText{
    self.toLabel.text = self.groupName;
    self.planLabel.text = self.plan;
    self.locationLabel.text = self.location.name;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // you can use one of the builtin localizated formats
    [formatter setDateStyle:NSDateFormatterNoStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    self.expirationLabel.text = [formatter stringFromDate:self.expirationDate];
}

-(void)setupViewBorders{
    UIColor *lightGray = [UIColor lightGrayColor];
    CGFloat borderWidth = 0.50f;
    CGFloat cornerRadius = 3.0f;
    
    self.toOutlineView.layer.borderColor = lightGray.CGColor;
    self.toOutlineView.layer.borderWidth = borderWidth;
    self.toOutlineView.layer.cornerRadius = cornerRadius;
    
    self.planOutlineView.layer.borderColor = lightGray.CGColor;
    self.planOutlineView.layer.borderWidth = borderWidth;
    self.planOutlineView.layer.cornerRadius = cornerRadius;
    
    self.locationOutlineView.layer.borderColor = lightGray.CGColor;
    self.locationOutlineView.layer.borderWidth = borderWidth;
    self.locationOutlineView.layer.cornerRadius = cornerRadius;
    
    self.popsAtOutlineView.layer.borderColor = lightGray.CGColor;
    self.popsAtOutlineView.layer.borderWidth = borderWidth;
    self.popsAtOutlineView.layer.cornerRadius = cornerRadius;
    
    self.photoOutlineView.layer.borderColor = lightGray.CGColor;
    self.photoOutlineView.layer.borderWidth = borderWidth;
    self.photoOutlineView.layer.cornerRadius = cornerRadius;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
