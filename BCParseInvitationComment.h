//
//  BCParseInvitationComment.h
//  BalloonClean
//
//  Created by Sean Wertheim on 6/18/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import <Parse/Parse.h>
#import "BCParseUser.h"
#import "BCParseInvitation.h"

@interface BCParseInvitationComment : PFObject<PFSubclassing>

@property (retain) BCParseUser *user;
@property (retain) BCParseInvitation *invitation;
@property (retain) NSString *comment;

+(NSString*)parseClassName;

@end
