//
//  BCParseUser.h
//  BalloonClean
//
//  Created by Sean Wertheim on 6/5/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import <Parse/Parse.h>
#import "BCParseGroup.h"

@interface BCParseUser : PFObject<PFSubclassing>
+(NSString*)parseClassName;
-(void)setUserPhotoFileWithUIImage:(UIImage *)userImage;
@property (retain) NSMutableArray *userMemberGroups;
@property (retain) NSString *usernameFromPhoneNumber;
@property (retain) PFFile *userPhotoFile;
@property BOOL available;
@property (retain) NSMutableArray *blockedUsers;
@property (retain) NSMutableArray *blockedGroups;
@property (retain) PFGeoPoint *currentLocation;
@property (retain) PFGeoPoint *lastLocation;
@property (retain) NSString *facebookID;

@end
