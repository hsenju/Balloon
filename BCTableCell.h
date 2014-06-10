//
//  BCGroupCell.h
//  BalloonClean
//
//  Created by Sean Wertheim on 6/4/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "BCProfileImageView.h"
#import "Common.h"


@interface BCTableCell : PFTableViewCell

@property (strong, nonatomic) IBOutlet UILabel *groupNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *numberOfMembersLabel;
@property (strong, nonatomic) IBOutlet BCProfileImageView *groupPictureImageView;
@property (strong, nonatomic) IBOutlet UIView *mainView;

@property (nonatomic, strong) PFUser *user;

+ (CGFloat)heightForCellWithName:(NSString *)name contentString:(NSString *)content;

@end


@protocol BCTableCellDelegate <NSObject>
@optional

- (void)cell:(BCTableCell *)cellView didTapUserButton:(PFUser *)aUser;

@end