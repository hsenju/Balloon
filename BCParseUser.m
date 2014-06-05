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

@dynamic userMemberGroups;
@dynamic usernameFromPhoneNumber;
@dynamic userPhotoFile;
@dynamic available;
@dynamic blockedUsers;
@dynamic blockedGroups;
@dynamic currentLocation;
@dynamic lastLocation;
@dynamic facebookID;

+(NSString*)parseClassName{
    return @"User";
}

-(void)setUserPhotoFileWithUIImage:(UIImage *)userImage{
    NSData *imageData = UIImagePNGRepresentation(userImage);
    PFFile *imageFile = [PFFile fileWithName:@"userImage.png" data:imageData];
    self.userPhotoFile = imageFile;
}

@end
