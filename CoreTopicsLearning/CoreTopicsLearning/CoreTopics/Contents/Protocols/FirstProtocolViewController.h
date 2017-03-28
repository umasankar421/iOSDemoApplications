//
//  FirstProtocolViewController.h
//  CoreTopicsLearning
//
//  Created by Vikas Mishra on 11/18/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondProtocolViewController.h"
@interface FirstProtocolViewController : UIViewController <SecondViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UILabel *dataLabel;


@end
