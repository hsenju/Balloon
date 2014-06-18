//
//  BCParseContactList.h
//  BalloonClean
//
//  Created by Sean Wertheim on 6/18/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import <Parse/Parse.h>

@interface BCParseContactList : PFObject<PFSubclassing>

@property (retain) NSString *name;
@property (retain) NSMutableArray *users;
@property BOOL visible;
@property (retain) PFFile *photo;
//@property numberAvailable possible in the future
//@property created/updatedAt inherited from PFObject

+(NSString*)parseClassName;
-(void)setListPhotoWithImage:(UIImage *)listImage;

@end
