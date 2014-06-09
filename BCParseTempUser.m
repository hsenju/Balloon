//
//  BCParseTempUser.m
//  BalloonClean
//
//  Created by Sean Wertheim on 6/8/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import "BCParseTempUser.h"
#import <Parse/PFObject+Subclass.h>

@implementation BCParseTempUser

+(NSString*)parseClassName{
    return @"tempUser";
}

@dynamic name;
@dynamic phoneNumber;
@dynamic userMemberGroups;
@dynamic defaultPhoto;

-(void)setUserPhotoFileWithUIImage:(UIImage *)userImage{
    NSData *imageData = UIImagePNGRepresentation(userImage);
    PFFile *imageFile = [PFFile fileWithName:@"defaultUserImage.png" data:imageData];
    self.defaultPhoto = imageFile;
}

@end
