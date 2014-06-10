//
//  BCProfileImageView.h
//  BalloonClean
//
//  Created by Hikari Senju on 6/10/14.
//  Copyright (c) 2014 Balloon. All rights reserved.
//

#import <Parse/Parse.h>
@class PFImageView;
@interface BCProfileImageView : UIView

@property (nonatomic, strong) UIButton *profileButton;
@property (nonatomic, strong) PFImageView *profileImageView;

- (void)setFile:(PFFile *)file;

@end
