//
//  ParseInviteManager.m
//  Balloon
//
//  Created by Sean Wertheim on 5/30/14.
//
//

#import "ParseInviteManager.h"
#import "Invite.h"
#import <Parse/Parse.h>

@interface ParseInviteManager ()

@property (nonatomic, strong) NSArray *userGroups;
@property (nonatomic, strong) NSArray *inviteMessages;
@property (nonatomic, strong) NSArray *inviteLocations;
@property (nonatomic, strong) NSArray *deathDates;
@property (nonatomic, strong) PFUser *currentUser;

@end



@implementation ParseInviteManager

-(id)init{
    self = [super init];
    if(self){
        self.invites = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)queryForInvites:(completion) afterQuery{
    
    //we want my username to be in array of members in institutions, get the hashtag from there, and
    //find all invitations with that hashtag that haven't expired
    
    self.currentUser = [PFUser currentUser];
    NSString *username = [self.currentUser objectForKey:@"displayName"];
    
    NSLog(@"The current user is: %@", username);
    
    PFQuery *userQuery = [PFQuery queryWithClassName:@"Institutions"];
//    [userQuery setCachePolicy:kPFCachePolicyCacheThenNetwork];
    [userQuery whereKey:@"members" equalTo:username];
    [userQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.userGroups = [objects valueForKey:@"searchname"];
            
            [self queryForInvitesAfterGroups:^(BOOL finished){
                if (finished){
                    afterQuery(YES);
                }
            }];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

#pragma mark - private methods

-(void)queryForInvitesAfterGroups: (completion) afterGroups{
    
    PFQuery *invQuery = [PFQuery queryWithClassName:@"Photo"];
//    [invQuery setCachePolicy:kPFCachePolicyCacheThenNetwork];
    [invQuery whereKey:@"hashtags" containedIn:self.userGroups];
    [invQuery whereKey:@"deathdate" greaterThan:[NSDate date]];
    
    [invQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d invites.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSString *inviteMessage = (NSString*)[object valueForKey:@"content"];
                NSString *sender = (NSString*)[object valueForKey:@"userName"];
                NSString *location = (NSString*)[object valueForKey:@"locationName"];
                NSDate *date = (NSDate*)[object valueForKey:@"deathdate"];
                Invite *currentInvite = [[Invite alloc] init];
                currentInvite.message = inviteMessage;
                currentInvite.sender = sender;
                currentInvite.location = location;
                currentInvite.repsondByDate = date;
                [self.invites addObject:currentInvite];
            }
            
            afterGroups(YES);
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}

@end
