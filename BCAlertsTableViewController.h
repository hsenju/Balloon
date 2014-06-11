//
//  BCAlertsTableViewController.h
//  BalloonClean
//
//  Created by Hikari Senju on 6/11/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface BCAlertsTableViewController : PFQueryTableViewController
+ (NSString *)stringForActivityType:(NSString *)activityType;
@end
