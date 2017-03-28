//
//  GoogleMapsViewController.h
//  MapsIntegration
//
//  Created by Vikas Mishra on 10/24/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
@interface GoogleMapsViewController : UIViewController<GMSMapViewDelegate,CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet UIView *googleMapView;
@end
