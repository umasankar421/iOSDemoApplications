//
//  GooglePlacesViewController.h
//  MapsIntegration
//
//  Created by Vikas Mishra on 10/25/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <GooglePlaces/GooglePlaces.h>
@interface GooglePlacesViewController : UIViewController < CLLocationManagerDelegate,GMSAutocompleteViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
- (IBAction)pickPlace:(id)sender;
- (IBAction)autoCompletionPlaces:(id)sender;
- (IBAction)addPlace:(id)sender;


@end
