//
//  ParseInviteManager.h
//  Balloon
//
//  Created by Sean Wertheim on 5/30/14.
//
//

#import <Foundation/Foundation.h>

@interface ParseInviteManager : NSObject

typedef void(^completion)(BOOL);

@property (nonatomic, strong) NSMutableArray *invites;

/**Query for current user's invites**/
-(void)queryForInvites:(completion) afterQuery;

@end
