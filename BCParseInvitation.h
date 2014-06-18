//
//  BCParseInvitation.h
//  BalloonClean
//
//  Created by Sean Wertheim on 6/18/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import <Parse/Parse.h>
#import "BCParseUser.h"
#import "BCParseContactList.h"

@interface BCParseInvitation : PFObject<PFSubclassing>

@property (retain) BCParseUser *creator;
@property (retain) NSString *plan;
@property (retain) NSDictionary *venueInfo;
@property (retain) NSArray *venuePhotos;
@property (retain) BCParseContactList *targetList;
@property (retain) NSMutableArray *invitedUsers;
@property (retain) NSDate *deathDate;

+(NSString*)parseClassName;

@end
