//
//  PAPCardView.m
//  Balloon
//
//  Created by Sean Wertheim on 6/2/14.
//
//

#import "PAPCardView.h"

@interface PAPCardView ()



@end

@implementation PAPCardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)acceptInvitation:(id)sender {
    [self.delegate dismissLeftPAPCardView:self];
}

- (IBAction)rejectInvitation:(id)sender {
    [self.delegate dismissRightPAPCardView:self];
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
