//
//  BCParseGroup.m
//  BalloonClean
//
//  Created by Sean Wertheim on 6/5/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import "BCParseGroup.h"
#import <Parse/PFObject+Subclass.h>

@implementation BCParseGroup

@dynamic membersByPhoneNumber;
@dynamic profileImageFile;

+(NSString*)parseClassName{
    return @"Group";
}

-(void)setProfileImageFileWithUIImage:(UIImage *)profileImage{
    NSData *imageData = UIImagePNGRepresentation(profileImage);
    PFFile *imageFile = [PFFile fileWithName:@"profileImage.png" data:imageData];
    self.profileImageFile = imageFile;
}

@end
