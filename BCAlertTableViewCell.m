//
//  BCAlertTableViewCell.m
//  BalloonClean
//
//  Created by Hikari Senju on 6/9/14.
//  Copyright (c) 2014 Balloon. All rights reserved.
//

#import "BCAlertTableViewCell.h"
#import "AlertsTableViewController.h"
#import "TTTTimeIntervalFormatter.h"

static TTTTimeIntervalFormatter *timeFormatter;

@implementation BCAlertTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (!timeFormatter) {
        timeFormatter = [[TTTTimeIntervalFormatter alloc] init];
    }
    
    if (self) {
        // Initialization code
    }
    
    self.contentLabel = [[UILabel alloc] init];
    [self.contentLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [self.contentLabel setTextColor:[UIColor colorWithRed:73./255. green:55./255. blue:35./255. alpha:1.000]];
    [self.contentLabel setNumberOfLines:0];
    [self.contentLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.contentLabel setBackgroundColor:[UIColor clearColor]];
    [self.contentLabel setShadowColor:[UIColor colorWithWhite:1.0f alpha:0.70f]];
    [self.contentLabel setShadowOffset:CGSizeMake( 0.0f, 1.0f)];
    [self.mainView addSubview:self.contentLabel];
    
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - PAPActivityCell

- (void)setIsNew:(BOOL)isNew {
    if (isNew) {
        [self.mainView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"BackgroundNewActivity.png"]]];
    } else {
        [self.mainView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"BackgroundComments.png"]]];
    }
}


- (void)setActivity:(PFObject *)activity {
    // Set the activity property
    _activity = activity;
    
    NSString *activityString = [AlertsTableViewController stringForActivityType:(NSString*)[activity objectForKey:kBCAlertsTypeKey]];
    self.user = [activity objectForKey:kBCAlertsFromUserKey];
    
    // Set name button properties and avatar image
    [self.groupPictureImageView setFile:[self.user objectForKey:kBCUserProfilePicSmallKey]];
    
    NSString *nameString = NSLocalizedString(@"Someone", @"Text when the user's name is unknown");
    if (self.user && [self.user objectForKey:kBCUserDisplayNameKey] && [[self.user objectForKey:kBCUserDisplayNameKey] length] > 0) {
        nameString = [self.user objectForKey:kBCUserDisplayNameKey];
    }

    
    [self.numberOfMembersLabel setText:[timeFormatter stringForTimeIntervalFromDate:[NSDate date] toDate:[activity createdAt]]];
    
    [self setNeedsDisplay];
}

// Since we remove the compile-time check for the delegate conforming to the protocol
// in order to allow inheritance, we add run-time checks.
- (id<BCAlertTableViewCellDelegate>)delegate {
    return (id<BCAlertTableViewCellDelegate>)_delegate;
}

- (void)setDelegate:(id<BCAlertTableViewCellDelegate>)delegate {
//    if(_delegate != delegate) {
//        _delegate = delegate;
//    }
}

- (void)didTapActivityButton:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cell:didTapActivityButton:)]) {
        [self.delegate cell:self didTapActivityButton:self.activity];
    }
}



@end
