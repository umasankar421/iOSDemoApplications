//
//  MapKitViewController.h
//  MapsIntegration
//
//  Created by Vikas Mishra on 10/24/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface MapKitViewController : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end
