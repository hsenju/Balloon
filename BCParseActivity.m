//
//  BCParseActivity.m
//  BalloonClean
//
//  Created by Sean Wertheim on 6/5/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import "BCParseActivity.h"
#import <Parse/PFObject+Subclass.h>

@implementation BCParseActivity

@dynamic fromUser;
@dynamic toUser;
@dynamic content;
@dynamic comments;
@dynamic coming;
@dynamic notComing;
@dynamic activityPhotoFile;
@dynamic expirationDate;
@dynamic responded;

+(NSString*)parseClassName{
    return @"Activity";
}

-(void)setActivityPhotoFileWithUIImage:(UIImage *)activityImage{
    NSData *imageData = UIImagePNGRepresentation(activityImage);
    PFFile *imageFile = [PFFile fileWithName:@"activityImage.png" data:imageData];
    self.activityPhotoFile = imageFile;
}

@end
