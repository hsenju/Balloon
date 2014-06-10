//
//  BCAlertTableViewCell.h
//  BalloonClean
//
//  Created by Hikari Senju on 6/9/14.
//  Copyright (c) 2014 Balloon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCTableCell.h"

@interface BCAlertTableViewCell : BCTableCell

/*!Setter for the activity associated with this cell */
@property (nonatomic, strong) PFObject *activity;

/*!Set the new state. This changes the background of the cell. */
@property (nonatomic, strong) UILabel *contentLabel;

- (void)setIsNew:(BOOL)isNew;

@end

/*!
 The protocol defines methods a delegate of a PAPBaseTextCell should implement.
 */
@protocol BCAlertTableViewCellDelegate <BCTableCellDelegate>
@optional

/*!
 Sent to the delegate when the activity button is tapped
 @param activity the PFObject of the activity that was tapped
 */
- (void)cell:(BCAlertTableViewCell *)cellView didTapActivityButton:(PFObject *)activity;

@end