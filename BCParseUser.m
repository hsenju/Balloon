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
@dynamic mobilePhone;
@dynamic userPhoto;
@dynamic available;
@dynamic facebookID;
@dynamic firstName;
@dynamic lastName;
@dynamic isPending;


-(void)setUserPhotoWithImage:(UIImage *)userImage{
    NSData *imageData = UIImagePNGRepresentation(userImage);
    PFFile *imageFile = [PFFile fileWithName:@"userImage.png" data:imageData];
    self.userPhoto = imageFile;
}

@end
