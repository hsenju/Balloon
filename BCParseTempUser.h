//
//  BCParseTempUser.h
//  BalloonClean
//
//  Created by Sean Wertheim on 6/8/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import <Parse/Parse.h>

@interface BCParseTempUser : PFObject<PFSubclassing>

+(NSString*)parseClassName;

@property (retain) NSString *name;
@property (retain) NSString *phoneNumber;
@property (retain) NSMutableArray *userMemberGroups;
@property (retain) PFFile *defaultPhoto;

@end
