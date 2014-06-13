//
//  BCLandingPageViewController.h
//  BalloonClean
//
//  Created by Sean Wertheim on 6/13/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSVenue.h"

@interface BCLandingPageViewController : UIViewController

@property (strong, nonatomic) NSMutableSet *members;
@property (strong, nonatomic) NSString *plan;
@property (strong, nonatomic) FSVenue *location;
@property (strong, nonatomic) NSDate *expirationDate;
@property (strong, nonatomic) NSString *groupName;

@end
