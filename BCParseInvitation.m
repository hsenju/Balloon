//
//  BCParseInvitation.m
//  BalloonClean
//
//  Created by Sean Wertheim on 6/18/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import "BCParseInvitation.h"
#import <Parse/PFObject+Subclass.h>

@implementation BCParseInvitation

@dynamic creator;
@dynamic plan;
@dynamic venueInfo;
@dynamic venuePhotos;
@dynamic targetList;
@dynamic invitedUsers;
@dynamic deathDate;

+(NSString*)parseClassName{
    return @"Invitation";
}

@end
