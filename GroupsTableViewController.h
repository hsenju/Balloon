//
//  GroupsTableViewController.h
//  BalloonClean
//
//  Created by Sean Wertheim on 6/4/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface GroupsTableViewController : PFQueryTableViewController

@property NSMutableArray *userGroupsArray;

@end
