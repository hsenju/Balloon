//
//  BCParseInvitationComment.m
//  BalloonClean
//
//  Created by Sean Wertheim on 6/18/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import "BCParseInvitationComment.h"
#import <Parse/PFObject+Subclass.h>

@implementation BCParseInvitationComment

@dynamic user;
@dynamic invitation;
@dynamic comment;

+(NSString*)parseClassName{
    return @"InvitationComment";
}

@end
