//
//  BCAppDelegate.m
//  BalloonClean
//
//  Created by Sean Wertheim on 6/4/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import "BCAppDelegate.h"

#import <Parse/Parse.h>
#import "BCParseUser.h"
#import "BCParseInvitation.h"
#import "BCParseInvitationResponse.h"
#import "BCParseInvitationComment.h"
#import "BCParseContactList.h"
#import "Foursquare2.h"

@implementation BCAppDelegate

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //register PFObject subclasses
    [BCParseUser registerSubclass];
    [BCParseInvitation registerSubclass];
    [BCParseInvitationResponse registerSubclass];
    [BCParseInvitationComment registerSubclass];
    [BCParseContactList registerSubclass];
    
    //setup parse client
    [Parse setApplicationId:@"F0cvLwmfI1R73szAAbXp5diFL2Q0GbQwPjhaafBI"
                  clientKey:@"gPZ4p1xWFznflPhvvZDDtyEOx1vt9lHXYnVyWpHJ"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    //register for parse push notifications
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|
     UIRemoteNotificationTypeAlert|
     UIRemoteNotificationTypeSound];
    
    //setup foursquare client
    [Foursquare2 setupFoursquareWithClientId:@"QIVN42TMR5KLGEA15W1VK0ISG4V3DOT0J4XAZVZ033HQK2MH"
                                      secret:@"YDYDI1JXQJPCVAWM1ZDMHRCCCAEJY5DT3TUTLUXU2JZ5G2AJ"
                                 callbackURL:@"fb527538684032224://foursquare"];
    return YES;
}

-(BOOL)application:(UIApplication*)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [Foursquare2 handleURL:url];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
