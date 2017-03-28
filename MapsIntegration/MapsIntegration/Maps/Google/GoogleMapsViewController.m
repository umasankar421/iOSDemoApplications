//
//  GoogleMapsViewController.m
//  MapsIntegration
//
//  Created by Vikas Mishra on 10/24/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "GoogleMapsViewController.h"
#import <GoogleMaps/GoogleMaps.h>
@import GoogleMaps;
#import <CoreLocation/CoreLocation.h>

@interface GoogleMapsViewController (){
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    UIActivityIndicatorView *activityIndicator;
}

@end

@implementation GoogleMapsViewController
@synthesize googleMapView;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    
    activityIndicator = [[UIActivityIndicatorView alloc]init];
    activityIndicator.center = self.view.center;
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;

    [self getUserLocation];
    
    //[self panoramaView];
    // Do any additional setup after loading the view.
}
-(void)getUserLocation{
    locationManager = [CLLocationManager new];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    [activityIndicator startAnimating];
    NSLog(@"Locations : %@",locations);
    currentLocation = [locations objectAtIndex:0];
    NSLog(@"Current Location is : %@",currentLocation);
    [locationManager stopUpdatingLocation];
    [self loadGoogleMapView];
   
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return  UIStatusBarStyleLightContent;
}

-(void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate{
    NSLog(@"tapped location is : %f and %f",coordinate.latitude,coordinate.longitude);
}
-(void)panoramaView{
    
    CLLocationCoordinate2D panoramaNear = {28.610354,77.354373};
    
    GMSPanoramaView *panoramaView =
    [GMSPanoramaView panoramaWithFrame:CGRectZero
                        nearCoordinate:panoramaNear];
    
    self.view = panoramaView;
}
//28.61021435,+77.35398475
//77.354373,28.610354
- (void)loadGoogleMapView {
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:currentLocation.coordinate.latitude longitude:currentLocation.coordinate.longitude zoom:12];
    //CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height*0.7);
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = YES;
    
    
    
    // Available map types: kGMSTypeNormal, kGMSTypeSatellite, kGMSTypeHybrid,
    // kGMSTypeTerrain, kGMSTypeNone
    // Set the mapType to Satellite

    mapView.mapType = kGMSTypeNormal;
    mapView.delegate = self;
    mapView.settings.compassButton = YES;
    mapView.settings.myLocationButton = YES;
    mapView.accessibilityElementsHidden = NO;
    mapView.myLocationEnabled = YES;
    self.view=mapView;
    //[self.view addSubview:googleMapView];
    //[googleMapView addSubview: mapView];
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.title = @"Noida";
    marker.snippet = @"India";
    marker.icon = [GMSMarker markerImageWithColor:[UIColor blueColor]];
    marker.map = mapView;
    marker.flat = YES;
    marker.tracksInfoWindowChanges = YES;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
    view.backgroundColor = [UIColor whiteColor];
    [mapView bringSubviewToFront:view];
    
    GMSGeocoder *geoCoder = [GMSGeocoder new];
    [geoCoder reverseGeocodeCoordinate:currentLocation.coordinate completionHandler:^(GMSReverseGeocodeResponse * responce, NSError * error) {
        if(error!=nil){
            NSLog(@"Error occurred while Reverse Geocoding : %@", [error localizedDescription]);
            return ;
        }
        NSLog(@"Responce is : %@", responce.firstResult);
    }];
    [activityIndicator stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
