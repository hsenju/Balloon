//
//  CountdownLabel.h
//  Balloon
//
//  Created by Sean Wertheim on 5/28/14.
//
//

#import <UIKit/UIKit.h>

@interface CountdownLabel : UILabel

- (id)initWithFrame:(CGRect)frame eventDate:(NSDate*)eventDate tolerance:(NSTimeInterval)toleranceInSeconds;
- (id)initWithEventDate:(NSDate*)eventDate tolerance:(NSTimeInterval)toleranceInSeconds;

@end
