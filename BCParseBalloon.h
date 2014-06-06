//
//  BCParseBalloon.h
//  BalloonClean
//
//  Created by Sean Wertheim on 6/5/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import <Parse/Parse.h>

@interface BCParseBalloon : PFObject<PFSubclassing>
+(NSString*)parseClassName;
-(void)setEventPhotoFileWithUIImage:(UIImage *)eventImage;
@property (retain) NSMutableArray *comments;
@property (retain) NSMutableArray *invitedMembers;
@property (retain) NSMutableArray *membersRespondedYes;
@property (retain) NSMutableArray *membersRespondedNo;
@property (retain) NSDate *expirationDate;
@property (retain) NSDate *createdDate;
@property (retain) NSString *eventLocation;
@property (retain) NSString *eventName;

//if photo provided, display that
//else if foursquare photo exists, display that
//else if map photo, display map ohoto
//else photo of balloon
@property (retain) PFFile *eventPhotoFile;

@end
