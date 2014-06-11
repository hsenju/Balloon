//
//  BCSelectMembersViewController.h
//  BalloonClean
//
//  Created by Sean Wertheim on 6/10/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import <Parse/Parse.h>
#import "BCParseGroup.h"

@interface BCSelectMembersViewController : PFQueryTableViewController

@property (strong, nonatomic) BCParseGroup *selectedGroup;

@end
