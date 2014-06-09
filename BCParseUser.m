//
//  BCParseUser.m
//  BalloonClean
//
//  Created by Sean Wertheim on 6/5/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import "BCParseUser.h"
#import <Parse/PFObject+Subclass.h>

@implementation BCParseUser

@dynamic name;
@dynamic phoneNumber;
@dynamic userPhotoFile;
@dynamic available;
@dynamic userMemberGroups;
@dynamic blockedUsers;
@dynamic blockedGroups;
@dynamic currentLocation;
@dynamic lastLocation;
@dynamic facebookID;


-(void)setUserPhotoFileWithUIImage:(UIImage *)userImage{
    NSData *imageData = UIImagePNGRepresentation(userImage);
    PFFile *imageFile = [PFFile fileWithName:@"userImage.png" data:imageData];
    self.userPhotoFile = imageFile;
}

@end
