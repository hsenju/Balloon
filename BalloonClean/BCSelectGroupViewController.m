//
//  BCSelectGroupViewController.m
//  BalloonClean
//
//  Created by Sean Wertheim on 6/7/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import "BCSelectGroupViewController.h"
#import "BCParseGroup.h"
#import "BCGroupCell.h"

@interface BCSelectGroupViewController ()

@end

@implementation BCSelectGroupViewController

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

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // This table displays items in the Todo class
        self.parseClassName = [BCParseGroup parseClassName];
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = NO;
        self.objectsPerPage = 25;
    }
    return self;
}

- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    // If no objects are loaded in memory, we look to the cache
    // first to fill the table and then subsequently do a query
    // against the network.
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByDescending:@"createdAt"];
    
    return query;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
                        object:(PFObject *)object {
    static NSString *CellIdentifier = @"bcGroupReuseID";
    
    BCGroupCell *cell = (BCGroupCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[BCGroupCell alloc] init];
    }
    
    // Configure the cell to show todo item with a priority at the bottom
    BCParseGroup *currentGroup = (BCParseGroup*)object;
    cell.groupNameLabel.text = currentGroup.groupName;
    cell.numberOfMembersLabel.text = [NSString stringWithFormat:@"%d members available", currentGroup.members.count];
    cell.groupPictureImageView.file = currentGroup.groupImageFile;
    [cell.groupPictureImageView loadInBackground];
    
    
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
