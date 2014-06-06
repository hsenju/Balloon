//
//  BCParseActivity.h
//  BalloonClean
//
//  Created by Sean Wertheim on 6/5/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface BCParseActivity : PFObject<PFSubclassing>
+(NSString*)parseClassName;
-(void)setActivityPhotoFileWithUIImage:(UIImage *)activityImage;
@property (retain) NSString *fromUser;
@property (retain) NSString *toUser;
@property (retain) NSString *content;
//@property (retain) PFObject *balloon;
@property (retain) NSMutableArray *comments;
@property (retain) NSMutableArray *coming;
@property (retain) NSMutableArray *notComing;
@property (retain) PFFile *activityPhotoFile;
@property (retain) NSDate *expirationDate;

@end
