//
//  PAPCardView.h
//  Balloon
//
//  Created by Sean Wertheim on 6/2/14.
//
//

#import <UIKit/UIKit.h>
#import "CountdownLabel.h"

@class PAPCardView;

@protocol PAPCardViewDelegate <NSObject>
- (void)dismissLeftPAPCardView:(PAPCardView*)cardView;
- (void)dismissRightPAPCardView:(PAPCardView*)cardView;
@end

@interface PAPCardView : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *recipientLabel;
@property (strong, nonatomic) IBOutlet CountdownLabel *expirationLabel;
@property (strong, nonatomic) IBOutlet UILabel *messageLabel;
@property (strong, nonatomic) IBOutlet UILabel *senderLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UIImageView *venueImageView;

@property (nonatomic, weak) id <PAPCardViewDelegate> delegate;

@end
