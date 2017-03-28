//
//  GooglePlacesViewController.m
//  MapsIntegration
//
//  Created by Vikas Mishra on 10/25/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "GooglePlacesViewController.h"
@import GooglePlaces;
@import GooglePlacePicker;
@interface GooglePlacesViewController (){
    GMSPlacePicker *_placePicker;
    GMSPlacesClient *_placesClient;
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
}

@end

@implementation GooglePlacesViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _placesClient = [GMSPlacesClient sharedClient];
    [self getCurrentLocation];
}
-(void)getCurrentLocation{
    locationManager = [CLLocationManager new];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    currentLocation = [locations objectAtIndex:[locations count]-1];
    
    
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

- (IBAction)pickPlace:(id)sender {
    //Google Place Picker.............................
    CLLocationCoordinate2D center = currentLocation.coordinate;
    CLLocationCoordinate2D northEast = CLLocationCoordinate2DMake(center.latitude + 0.001,
                                                                  center.longitude + 0.001);
    CLLocationCoordinate2D southWest = CLLocationCoordinate2DMake(center.latitude - 0.001,
                                                                  center.longitude - 0.001);
    GMSCoordinateBounds *viewport = [[GMSCoordinateBounds alloc] initWithCoordinate:northEast
                                                                         coordinate:southWest];
    GMSPlacePickerConfig *config = [[GMSPlacePickerConfig alloc] initWithViewport:viewport];
    _placePicker = [[GMSPlacePicker alloc] initWithConfig:config];
    
    [_placePicker pickPlaceWithCallback:^(GMSPlace *place, NSError *error) {
        if (error != nil) {
            NSLog(@"Pick Place error %@", [error localizedDescription]);
            return;
        }
        
        if (place != nil) {
            self.nameLabel.text = place.name;
            self.addressLabel.text = place.formattedAddress;
            //[[place.formattedAddress componentsSeparatedByString:@", "] componentsJoinedByString:@"\n"];
        } else {
            self.nameLabel.text = @"No place selected";
            self.addressLabel.text = @"";
        }
    }];
    
   
}

- (IBAction)autoCompletionPlaces:(id)sender {

    //Google Places ................................................................
    
//    [_placesClient currentPlaceWithCallback:^(GMSPlaceLikelihoodList *placeLikelihoodList, NSError *error){
//        if (error != nil) {
//            NSLog(@"Pick Place error %@", [error localizedDescription]);
//            return;
//        }
//        
//        self.nameLabel.text = @"No current place";
//        self.addressLabel.text = @"";
//        
//        if (placeLikelihoodList != nil) {
//            GMSPlace *place = [[[placeLikelihoodList likelihoods] firstObject] place];
//            if (place != nil) {
//                self.nameLabel.text = place.name;
//                self.addressLabel.text = [[place.formattedAddress componentsSeparatedByString:@", "]
//                                          componentsJoinedByString:@"\n"];
//            }
//        }
//    }];
    
    
    
    //Auto Completion .........................................................
    GMSAutocompleteViewController *autoCompleter = [[GMSAutocompleteViewController alloc]init];
    autoCompleter.delegate = self;
    [self presentViewController:autoCompleter animated:YES completion:nil];
}



#pragma auto Completion places Delegate Methods..
-(void)viewController:(GMSAutocompleteViewController *)viewController didAutocompleteWithPlace:(GMSPlace *)place{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    self.nameLabel.text = place.name;
    self.addressLabel.text = place.formattedAddress;
    NSLog(@"Place attributions %@", place.attributions.string);
}

-(void)viewController:(GMSAutocompleteViewController *)viewController didFailAutocompleteWithError:(NSError *)error{

    
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"Auto Complete Places if failed with error : %@",[error localizedDescription]);
}
-(void)wasCancelled:(GMSAutocompleteViewController *)viewController{
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"User Cancelled auto Completion of places");
}
-(void)didUpdateAutocompletePredictions:(GMSAutocompleteViewController *)viewController{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
-(void)didRequestAutocompletePredictions:(GMSAutocompleteViewController *)viewController{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}




- (IBAction)addPlace:(id)sender {
    //Google Place Adding....................................
    
        GMSUserAddedPlace *userAddedPlace = [[GMSUserAddedPlace alloc] init];
        userAddedPlace.name = @"Uma Sankar";
        userAddedPlace.address = @"main road,sector 58, Noida, India";
        CLLocationCoordinate2D addLocation = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude+0.0001, currentLocation.coordinate.longitude+0.00001);
        userAddedPlace.coordinate = addLocation;
        userAddedPlace.phoneNumber = @"123456789";
        userAddedPlace.website = @"http://www.sankar.com.au/";
        userAddedPlace.types = @[@"Office"];
    
        [_placesClient addPlace:userAddedPlace callback:^(GMSPlace *place, NSError *error) {
            if (error != nil) {
                NSLog(@"User Added Place error %@", [error localizedDescription]);
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error on Adding Place" message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
                
                return;
            }
    
            NSLog(@"Added place with placeID %@", place.placeID);
            NSLog(@"Added Place name %@", place.name);
            NSLog(@"Added Place address %@", place.formattedAddress);
        }];
}
@end
