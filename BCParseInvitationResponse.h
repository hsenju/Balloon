//
//  BCParseInvitationResponse.h
//  BalloonClean
//
//  Created by Sean Wertheim on 6/18/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import <Parse/Parse.h>
#import "BCParseUser.h"
#import "BCParseInvitation.h"

@interface BCParseInvitationResponse : PFObject<PFSubclassing>

@property (retain) BCParseUser *user;
@property (retain) BCParseInvitation *invitation;
@property BOOL accepted;

+(NSString*)parseClassName;

@end
