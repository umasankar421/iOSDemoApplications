//
//  ViewController.h
//  PaytmIntegration
//
//  Created by Vikas Mishra on 10/10/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentsSDK.h"

@interface ViewController : UIViewController<PGTransactionDelegate>
- (IBAction)payNow:(id)sender;


@end

