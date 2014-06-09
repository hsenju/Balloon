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

@dynamic creator;
@dynamic members;
@dynamic groupImageFile;
@dynamic groupName;
@dynamic totalMembers;
@dynamic numberAvailableMembers;
@dynamic visible;
@dynamic numberInvitesSent;

+(NSString*)parseClassName{
    return @"Group";
}

-(void)setGroupImageFileWithUIImage:(UIImage *)profileImage{
    NSData *imageData = UIImagePNGRepresentation(profileImage);
    PFFile *imageFile = [PFFile fileWithName:@"profileImage.png" data:imageData];
    self.groupImageFile = imageFile;
}

@end
