//
//  BCGroup.h
//  BalloonClean
//
//  Created by Sean Wertheim on 6/4/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCGroup : NSObject

@property (strong, nonatomic) NSString *groupName;
@property (assign, nonatomic) NSUInteger numberOfMembers;
@property (strong, nonatomic) UIImage *groupImage;

@end
