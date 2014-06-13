//
//  BCParseBalloon.m
//  BalloonClean
//
//  Created by Sean Wertheim on 6/5/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import "BCParseBalloon.h"
#import <Parse/PFObject+Subclass.h>

@implementation BCParseBalloon

@dynamic comments;
@dynamic invitedMembers;
@dynamic membersRespondedYes;
@dynamic membersRespondedNo;
@dynamic expirationDate;
@dynamic createdDate;
@dynamic eventLocation;
@dynamic eventPlan;
@dynamic eventPhotoFile;

+(NSString*)parseClassName{
    return @"Balloon";
}

-(void)setEventPhotoFileWithUIImage:(UIImage *)eventImage{
    NSData *imageData = UIImagePNGRepresentation(eventImage);
    PFFile *imageFile = [PFFile fileWithName:@"eventImage.png" data:imageData];
    self.eventPhotoFile = imageFile;
}

@end
