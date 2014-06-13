//
//  BCSelectMembersTableViewController.m
//  BalloonClean
//
//  Created by Sean Wertheim on 6/11/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import "BCSelectMembersTableViewController.h"
#import "BCMemberCell.h"
#import "BCParseUser.h"
#import "BCParseTempUser.h"
#import "BCAddPlanViewController.h"

@interface BCSelectMembersTableViewController ()

@property (strong, nonatomic) NSMutableSet *invitedMembers;

@end

@implementation BCSelectMembersTableViewController

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
    
    self.invitedMembers = [NSMutableSet setWithArray:self.members];
    
    self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.members.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"bcMemberCellReuseID";
    BCMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    //select all cells by default
    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition: UITableViewScrollPositionNone];
    
    PFObject *member = (PFObject*)self.members[indexPath.row];
    
    if ([member isMemberOfClass:[BCParseUser class]]) {
        BCParseUser *userMember = (BCParseUser*)member;
        cell.memberNameLabel.text = userMember.name;
        cell.memberImageView.file = userMember.userPhotoFile;
        [cell.memberImageView loadInBackground];
    } else if ([member isMemberOfClass:[BCParseTempUser class]]) {
        BCParseTempUser *tempMember = (BCParseTempUser*)member;
        cell.memberNameLabel.text = tempMember.name;
        cell.memberImageView.image = [UIImage imageNamed:@"defaultProfile"];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BCMemberCell *cell = (BCMemberCell*)[tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    [self.invitedMembers addObject: self.members[indexPath.row]];
    NSLog(@"\nInvited members: %@", self.invitedMembers);
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    BCMemberCell *cell = (BCMemberCell*)[tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    [self.invitedMembers removeObject:self.members[indexPath.row]];
    NSLog(@"\nInvited members: %@", self.invitedMembers);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    BCAddPlanViewController *destination = (BCAddPlanViewController*)[segue destinationViewController];
    destination.selectedMembers = [NSMutableSet setWithSet:self.invitedMembers];
    destination.groupName = self.groupName;
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
