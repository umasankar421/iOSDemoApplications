//
//  MapKitViewController.m
//  MapsIntegration
//
//  Created by Vikas Mishra on 10/24/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "MapKitViewController.h"

@interface MapKitViewController (){
    CLLocationManager *locationManager;
}

@end

@implementation MapKitViewController
@synthesize mapView;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
    [self getCurrentLocation];
    self.mapView.showsUserLocation = YES;
    //self.mapView sho
    // Do any additional setup after loading the view.
}

-(void)getCurrentLocation{
    locationManager = [CLLocationManager new];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region]animated:YES];
    //Add an annotation
    MKPointAnnotation *point = [[MKPointAnnotation alloc]init];
    point.coordinate = userLocation.coordinate;
    point.title = @"Noida";
    point.subtitle = @"India";
    [self.mapView addAnnotation:point];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    //[activityIndicator startAnimating];
    NSLog(@"Locations : %@",locations);
    //currentLocation = [locations objectAtIndex:0];
    //NSLog(@"Current Location is : %@",currentLocation);
    [locationManager stopUpdatingLocation];
    //[self loadGoogleMapView];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
