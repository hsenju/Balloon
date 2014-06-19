//
//  BCParseInvitationResponse.m
//  BalloonClean
//
//  Created by Sean Wertheim on 6/18/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import "BCParseInvitationResponse.h"
#import <Parse/PFObject+Subclass.h>

@implementation BCParseInvitationResponse

@dynamic user;
@dynamic invitation;
@dynamic accepted;

+(NSString*)parseClassName{
    return @"InvitationResponse";
}

@end
