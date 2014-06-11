//
//  BCSelectMembersViewController.m
//  BalloonClean
//
//  Created by Sean Wertheim on 6/10/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import "BCSelectMembersViewController.h"
#import "BCParseUser.h"
#include "BCParseTempUser.h"
#import "BCMemberCell.h"

@interface BCSelectMembersViewController ()

@end

@implementation BCSelectMembersViewController

- (id)initWithCoder:(NSCoder *)aCoder {
    self = [super initWithCoder:aCoder];
    if (self) {
        // Customize the table
        
        // The className to query on
        self.parseClassName = [BCParseGroup parseClassName];
        
        //        self.imageKey = @"groupImageFile";
        //
        //        self.textKey = @"groupName";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 25;
    }
    return self;
}

- (PFQuery *)queryForTable {
    NSArray *receivedGroup = [NSArray arrayWithArray:self.selectedGroup.members];
    
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    [query whereKey:@"objectId" equalTo:self.selectedGroup.objectId];
    [query includeKey:@"members"];
    [query selectKeys:@[@"members"]];
    
    
    // If no objects are loaded in memory, we look to the cache
    // first to fill the table and then subsequently do a query
    // against the network.
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    //    [query orderByDescending:@"createdAt"];
    
    return query;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
                        object:(PFObject *)object {
    static NSString *CellIdentifier = @"bcMemberCellReuseID";
    
    BCMemberCell *cell = (BCMemberCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[BCMemberCell alloc] init];
    }
    
    // Configure the cell to show todo item with a priority at the bottom
    BCParseTempUser *currentUser = [object valueForKey:@"members"];
    cell.memberNameLabel.text = currentUser.name;
    cell.memberImageView.file = nil;
//    [cell.memberImageView loadInBackground];

    return cell;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
