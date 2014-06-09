//
//  BCGroupCell.h
//  BalloonClean
//
//  Created by Sean Wertheim on 6/4/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface BCGroupCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *groupNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *numberOfMembersLabel;
@property (strong, nonatomic) IBOutlet PFImageView *groupPictureImageView;

@end
