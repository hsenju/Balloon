//
//  BCParseGroup.h
//  BalloonClean
//
//  Created by Sean Wertheim on 6/5/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import <Parse/Parse.h>

@interface BCParseGroup : PFObject<PFSubclassing>
+(NSString*)parseClassName;
@property (retain) NSMutableArray *membersByPhoneNumber;
@property (retain) PFFile *profileImageFile;

@end
