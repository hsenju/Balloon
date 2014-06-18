//
//  BCParseUser.h
//  BalloonClean
//
//  Created by Sean Wertheim on 6/5/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import <Parse/Parse.h>
#import "BCParseGroup.h"

@interface BCParseUser : PFUser<PFSubclassing>

@property (retain) NSString *name;
@property (retain) NSString *mobilePhone;
@property (retain) PFFile *userPhoto;
@property BOOL available;
//@property password inherited from PFUser
@property (retain) NSString *facebookID;
//@property email inherited from PFUser
@property (retain) NSString *firstName;
@property (retain) NSString *lastName;
@property BOOL isPending;

-(void)setUserPhotoFileWithUIImage:(UIImage *)userImage;

@end
