//
//  NearbyVenuesViewController.h
//  Balloon
//
//  Created by Hikari Senju 2014.
//  Copyright (c) 2014 Hikari Senju. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FSVenue.h"

@protocol NearbyVenuesViewControllerDelegate;

@interface NearbyVenuesViewController :UITableViewController <UISearchBarDelegate>

@property (nonatomic,weak) id <NearbyVenuesViewControllerDelegate> delegate;

@end

@protocol NearbyVenuesViewControllerDelegate <NSObject>
@optional
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath location:(FSVenue *)location;
@end