//
//  BCMemberCell.h
//  BalloonClean
//
//  Created by Sean Wertheim on 6/10/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface BCMemberCell : UITableViewCell


@property (strong, nonatomic) IBOutlet PFImageView *memberImageView;
@property (strong, nonatomic) IBOutlet UILabel * memberNameLabel;


@end
