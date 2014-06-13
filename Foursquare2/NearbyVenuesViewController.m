//
//  NearbyVenuesViewController.m
//  Balloon
//
//  Created by Hikari Senju 2014.
//  Copyright (c) 2014 Hikari Senju. All rights reserved.
//

#import "NearbyVenuesViewController.h"
#import "Foursquare2.h"

#import "FSConverter.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface NearbyVenuesViewController () <CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIView *footer;

@property (strong, nonatomic) FSVenue *selected;
@property (strong, nonatomic) FSVenue *nVenue;
@property (strong, nonatomic) NSArray *nearbyVenues;

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) CLLocation *coordinate;
@end

@implementation NearbyVenuesViewController

@synthesize delegate;
@synthesize searchBar;

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //[TestFlight passCheckpoint:@"searchBarTextDidBeginEditing"];
    [self.searchBar setPlaceholder:@"Find or create a location"];
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    //[TestFlight passCheckpoint:@"searchBarTextDidEndEditing"];
    [self.searchBar setPlaceholder:nil];
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchedBar
{
    
    //[TestFlight passCheckpoint:@"Searchbar Clicked"];
    [searchBar resignFirstResponder];
    
    if (self.searchBar.text.length)
    {
        //[self loadObjects];
        if (self.coordinate){
            [self searchVenuesForLocation:self.coordinate name:self.searchBar.text];}
    }
    else if (self.searchBar.text == nil){
        [self getVenuesForLocation:self.coordinate];
    }
    
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self searchVenuesForLocation:self.coordinate name:searchText];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.searchBar resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Nearby";
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LogoNavigationBar.png"]];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake( 0.0f, 0.0f, 52.0f, 32.0f)];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    [[backButton titleLabel] setFont:[UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]]];
    [backButton setTitleEdgeInsets:UIEdgeInsetsMake( 0.0f, 5.0f, 0.0f, 0.0f)];
    [backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setBackgroundImage:[UIImage imageNamed:@"ButtonBack.png"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"ButtonBackSelected.png"] forState:UIControlStateHighlighted];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    self.tableView.tableHeaderView = self.mapView;
    self.tableView.tableFooterView = self.footer;
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
    
    self.searchBar =  [[UISearchBar alloc] initWithFrame:CGRectMake(0,70,320,44)];
    self.navigationItem.titleView = self.searchBar;
    //[self.searchBar becomeFirstResponder];
    searchBar.delegate = self;
}

- (void)updateRightBarButtonStatus {
    self.navigationItem.rightBarButtonItem.enabled = [Foursquare2 isAuthorized];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateRightBarButtonStatus];
}

- (void)removeAllAnnotationExceptOfCurrentUser {
    NSMutableArray *annForRemove = [[NSMutableArray alloc] initWithArray:self.mapView.annotations];
    if ([self.mapView.annotations.lastObject isKindOfClass:[MKUserLocation class]]) {
        [annForRemove removeObject:self.mapView.annotations.lastObject];
    } else {
        for (id <MKAnnotation> annot_ in self.mapView.annotations) {
            if ([annot_ isKindOfClass:[MKUserLocation class]] ) {
                [annForRemove removeObject:annot_];
                break;
            }
        }
    }
    
    [self.mapView removeAnnotations:annForRemove];
}

- (void)proccessAnnotations {
    [self removeAllAnnotationExceptOfCurrentUser];
    [self.mapView addAnnotations:self.nearbyVenues];
}


- (void)getVenuesForLocation:(CLLocation *)location {
    
    [Foursquare2 venueSearchNearByLatitude:@(location.coordinate.latitude)
                                 longitude:@(location.coordinate.longitude)
                                     query:nil
                                     limit:nil
                                    intent:intentCheckin
                                    radius:@(500)
                                categoryId:nil
                                  callback:^(BOOL success, id result){
                                      if (success) {
                                          NSDictionary *dic = result;
                                          NSArray *venues = [dic valueForKeyPath:@"response.venues"];
                                          FSConverter *converter = [[FSConverter alloc]init];
                                          self.nearbyVenues = [converter convertToObjects:venues];
                                          [self.tableView reloadData];
                                          [self proccessAnnotations];
                                          
                                      }
                                  }];
}

- (void)searchVenuesForLocation:(CLLocation *)location name:(NSString *)lname{

    [Foursquare2 venueSearchNearByLatitude:@(location.coordinate.latitude)
                                 longitude:@(location.coordinate.longitude)
                                     query:lname
                                     limit:nil
                                    intent:intentCheckin
                                    radius:nil
                                categoryId:nil
                                  callback:^(BOOL success, id result){
                                      if (success) {
                                          NSDictionary *dic = result;
                                          NSArray *venues = [dic valueForKeyPath:@"response.venues"];
                                          FSConverter *converter = [[FSConverter alloc]init];
                                          self.nearbyVenues = [converter convertToObjects:venues];
                                          [self.tableView reloadData];
                                          [self proccessAnnotations];
                                          
                                      }
                                  }];
}

- (void)addVenueForLocation:(CLLocation *)location name:(NSString *)locname{
    
             [Foursquare2 venueAddWithName:locname
                                   address:nil
                               crossStreet:nil
                                      city:nil
                                     state:nil
                                       zip:nil
                                     phone:nil
                                   twitter:nil
                               description:nil
                                  latitude:@(location.coordinate.latitude)
                                 longitude:@(location.coordinate.longitude)
                         primaryCategoryId:nil
                                  callback:^(BOOL success, id result){
                                      if (success) {
                                          [self.navigationController popViewControllerAnimated:YES];
                                          NSDictionary *dic = result;
                                          if (delegate && [delegate respondsToSelector:@selector(tableView: didSelectRowAtIndexPath: location:)]) {
                                              [delegate tableView:nil didSelectRowAtIndexPath:NULL location:[dic valueForKeyPath:@"response.venue"]];
                                          }
                                      }
                                  }];
}

- (void)setupMapForLocatoion:(CLLocation *)newLocation {
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.003;
    span.longitudeDelta = 0.003;
    CLLocationCoordinate2D location;
    location.latitude = newLocation.coordinate.latitude;
    location.longitude = newLocation.coordinate.longitude;
    region.span = span;
    region.center = location;
    [self.mapView setRegion:region animated:YES];
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    self.coordinate = newLocation;
    
    [self.locationManager stopUpdatingLocation];
    [self getVenuesForLocation:newLocation];
    [self setupMapForLocatoion:newLocation];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.nearbyVenues.count+1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:12];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.row>0){
        cell.textLabel.text = [self.nearbyVenues[indexPath.row-1] name];
        FSVenue *venue = self.nearbyVenues[indexPath.row-1];
        if (venue.location.address) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@m, %@",
                                         venue.location.distance,
                                         venue.location.address];
        } else {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@m",
                                         venue.location.distance];
        }
    }
    else{
        if (self.searchBar.text.length){
            cell.textLabel.text = [NSString stringWithFormat:@"Create \"%@\"",self.searchBar.text];
            cell.detailTextLabel.text = @"Create a custom location";
        }
        else {
            cell.textLabel.text = @"Create a custom location";
            cell.detailTextLabel.text = @"";
        }
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [searchBar resignFirstResponder];
    if (indexPath != [NSIndexPath indexPathForRow:0 inSection:0]){
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        self.selected = self.nearbyVenues[indexPath.row-1];
    
        [self.navigationController popViewControllerAnimated:YES];
    
        if (delegate && [delegate respondsToSelector:@selector(tableView: didSelectRowAtIndexPath: location:)]) {
            [delegate tableView:tableView didSelectRowAtIndexPath:indexPath location:self.selected];
        }
    }
    else {
        FSVenue *ann = [[FSVenue alloc]init];
        ann.name = self.searchBar.text;
        ann.venueId = nil;
        
        ann.location.address = nil;
        ann.location.distance = nil;
        
        [ann.location setCoordinate:CLLocationCoordinate2DMake(self.coordinate.coordinate.latitude, self.coordinate.coordinate.longitude)];

        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        [self.navigationController popViewControllerAnimated:YES];
        
        if (delegate && [delegate respondsToSelector:@selector(tableView: didSelectRowAtIndexPath: location:)]) {
            [delegate tableView:tableView didSelectRowAtIndexPath:indexPath location:ann];
        }
    }
}

#pragma mark - ()

- (void)backButtonAction:(id)sender {
    [searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
