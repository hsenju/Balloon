//
//  GroupsTableViewController.m
//  BalloonClean
//
//  Created by Sean Wertheim on 6/4/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import "GroupsTableViewController.h"
#import "BCSelectMembersTableViewController.h"
#import "BCGroupCell.h"
#import "BCParseGroup.h"

@interface GroupsTableViewController ()

@property (strong, nonatomic) NSString *parseClassName;
@property (strong, nonatomic) BCParseGroup *selectedGroup;
@property (strong, nonatomic) NSArray *groupMembers;

@end

@implementation GroupsTableViewController

static const NSString *kCreateGroupsSegueIdentifier = @"createGroupSegue";

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
    static NSString *CellIdentifier = @"bcGroupsRID";
    
    BCGroupCell *cell = (BCGroupCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[BCGroupCell alloc] init];
    }
    
    // Configure the cell to show todo item with a priority at the bottom
    BCParseGroup *currentGroup = (BCParseGroup*)object;
    cell.groupNameLabel.text = currentGroup.groupName;
    cell.numberOfMembersLabel.text = [NSString stringWithFormat:@"%lu members available", (unsigned long)currentGroup.members.count];
    cell.groupPictureImageView.file = currentGroup.groupImageFile;
    [cell.groupPictureImageView loadInBackground];
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BCParseGroup *selectedGroup = (BCParseGroup*)[self.objects objectAtIndex:indexPath.row];
    self.selectedGroup = selectedGroup;
    self.groupMembers = [NSArray arrayWithArray:selectedGroup.members];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        for (PFObject *member in self.groupMembers) {
            [member fetchIfNeeded];
        }
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self performSegueWithIdentifier:@"groupToMembers" sender:self];
        });
    });
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
     BCSelectMembersTableViewController *dest = (BCSelectMembersTableViewController*)[segue destinationViewController];
    
    dest.members = [NSArray arrayWithArray:self.groupMembers];
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
