//
//  Invite.h
//  Balloon
//
//  Created by Sean Wertheim on 5/30/14.
//
//

#import <Foundation/Foundation.h>

@interface Invite : NSObject

@property (strong, nonatomic) NSString *sender;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSDate *repsondByDate;

@end
