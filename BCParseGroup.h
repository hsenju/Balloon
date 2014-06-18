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
-(void)setGroupImageFileWithUIImage:(UIImage *)profileImage;

@property (retain) PFUser *creator;
@property (retain) NSString *groupName;
@property (retain) NSMutableArray *members;
@property (retain) PFFile *groupImageFile;
@property BOOL visible;

@property NSUInteger totalMembers;
@property NSUInteger numberAvailableMembers;

@property NSUInteger numberInvitesSent; //for analytics

@end
