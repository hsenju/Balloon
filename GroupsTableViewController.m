//
//  GroupsTableViewController.m
//  BalloonClean
//
//  Created by Sean Wertheim on 6/4/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import "GroupsTableViewController.h"
#import "BCSelectMembersTableViewController.h"
#import "BCParseUser.h"
#import "BCParseContactList.h"
#import "BCGroupCell.h"

@interface GroupsTableViewController ()

@property (strong, nonatomic) NSString *parseClassName;
@property (strong, nonatomic) BCParseContactList *selectedList;
@property (strong, nonatomic) NSArray *listMembers;

@end

@implementation GroupsTableViewController

static NSString * const kGroupsToMembersID = @"groupToMembers";

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewDidAppear:(BOOL)animated{
    [self loadObjects];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithCoder:(NSCoder *)aCoder {
    self = [super initWithCoder:aCoder];
    if (self) {
        // Customize the table
        
        // The className to query on
        self.parseClassName = [BCParseContactList parseClassName];
        
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
    BCParseUser *currentUser = [BCParseUser currentUser];
    
    PFQuery *creatorQuery = [BCParseContactList query];
    [creatorQuery whereKey:@"creator" equalTo:currentUser];
    
    PFQuery *memberAndVisibleQuery = [BCParseContactList query];
    [memberAndVisibleQuery whereKey:@"users" equalTo:currentUser];
    [memberAndVisibleQuery whereKey:@"visible" equalTo:[NSNumber numberWithBool:YES]];
    
    PFQuery *finalQuery = [PFQuery orQueryWithSubqueries:@[creatorQuery, memberAndVisibleQuery]];
    
    // If no objects are loaded in memory, we look to the cache
    // first to fill the table and then subsequently do a query
    // against the network.
    if ([self.objects count] == 0) {
        finalQuery.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    return finalQuery;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
                        object:(PFObject *)object {
    static NSString *CellIdentifier = @"bcGroupsRID";
    
    BCGroupCell *cell = (BCGroupCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[BCGroupCell alloc] init];
    }
    
    // Configure the cell to show todo item with a priority at the bottom
    BCParseContactList *currentList = (BCParseContactList*)object;
    cell.groupNameLabel.text = currentList.name;
    cell.numberOfMembersLabel.text = [NSString stringWithFormat:@"%lu members", (unsigned long)currentList.users.count];
    cell.groupPictureImageView.file = currentList.photo;
    [cell.groupPictureImageView loadInBackground];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BCParseContactList *selectedList = (BCParseContactList*)[self.objects objectAtIndex:indexPath.row];
    self.selectedList = selectedList;
    self.listMembers = [NSArray arrayWithArray:selectedList.users];
    
    [PFObject fetchAllInBackground:self.listMembers block:^(NSArray *objects, NSError *error) {
        [self performSegueWithIdentifier:@"groupToMembers" sender:self];
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString: kGroupsToMembersID]) {
        BCSelectMembersTableViewController *dest = (BCSelectMembersTableViewController*)[segue destinationViewController];
        
        dest.groupName = self.selectedList.name;
        dest.members = [NSArray arrayWithArray:self.listMembers];
    }
    
}

    

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
