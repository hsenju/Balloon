//
//  BCNearbyVenuesViewController.m
//  BalloonClean
//
//  Created by Sean Wertheim on 6/12/14.
//  Copyright (c) 2014 Sean Wertheim. All rights reserved.
//

#import "BCNearbyVenuesViewController.h"
#import "BCSetDeadlineViewController.h"

@interface BCNearbyVenuesViewController ()
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIView *footer;

@property (strong, nonatomic) FSVenue *selected;
@property (strong, nonatomic) FSVenue *nVenue;
@property (strong, nonatomic) NSArray *nearbyVenues;

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) CLLocation *coordinate;

@end

@implementation BCNearbyVenuesViewController

@synthesize searchBar;

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [searchBar resignFirstResponder];
    if (![indexPath isEqual:[NSIndexPath indexPathForRow:0 inSection:0]]){
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        self.selected = self.nearbyVenues[indexPath.row-1]; //FSVenue that was selected
    }
    else {
        FSVenue *ann = [[FSVenue alloc]init]; //custom location with current coordinates of user
        ann.name = self.searchBar.text;
        ann.venueId = nil;
        
        ann.location.address = nil;
        ann.location.distance = nil;
        
        [ann.location setCoordinate:CLLocationCoordinate2DMake(self.coordinate.coordinate.latitude, self.coordinate.coordinate.longitude)];
        
        self.selected = ann;
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
    }
    
    [self performSegueWithIdentifier:@"locationToDeadline" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    BCSetDeadlineViewController *destination = (BCSetDeadlineViewController*)[segue destinationViewController];
    destination.members = self.members;
    destination.plan = self.plan;
    destination.location = self.selected;
    destination.groupName = self.groupName;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
