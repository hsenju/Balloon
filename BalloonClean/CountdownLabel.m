//
//  CountdownLabel.m
//  Balloon
//
//  Created by Sean Wertheim on 5/28/14.
//
//

#import "CountdownLabel.h"

@interface CountdownLabel ()

@property (nonatomic, strong) NSDate *eventDate;
@property (nonatomic, assign) NSInteger secondsLeft;

@end

@implementation CountdownLabel

- (id)initWithFrame:(CGRect)frame eventDate:(NSDate*)eventDate tolerance:(NSTimeInterval)toleranceInSeconds
{
    self = [super initWithFrame:frame];
    if (self) {
        NSTimeInterval secondsUntilEvent = [eventDate timeIntervalSinceNow];
        
        if(secondsUntilEvent < toleranceInSeconds){
            self.secondsLeft = (NSInteger)secondsUntilEvent;
            NSTimer *countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                                       target:self
                                                                     selector:@selector(refreshTimeLabel:)
                                                                     userInfo:Nil
                                                                      repeats:YES];
        } else {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"HH:mm a"];
            
            self.text = [formatter stringFromDate:eventDate];
        }
    }
    return self;
}

- (id)initWithEventDate:(NSDate*)eventDate tolerance:(NSTimeInterval)toleranceInSeconds
{
    self = [super init];
    if (self) {
        NSTimeInterval secondsUntilEvent = [eventDate timeIntervalSinceNow];
        
        if(secondsUntilEvent < toleranceInSeconds){
            self.secondsLeft = (NSInteger)secondsUntilEvent;
            NSTimer *countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                                       target:self
                                                                     selector:@selector(refreshTimeLabel:)
                                                                     userInfo:Nil
                                                                      repeats:YES];
        } else {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"HH:mm a"];
            
            self.text = [formatter stringFromDate:eventDate];
        }
    }
    return self;
}

-(void)refreshTimeLabel:(id)sender
{
    self.secondsLeft--;
    self.text = [self timeFormatted:self.secondsLeft];
}

- (NSString *)timeFormatted:(int)totalSeconds
{
    
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;
    
    return [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
