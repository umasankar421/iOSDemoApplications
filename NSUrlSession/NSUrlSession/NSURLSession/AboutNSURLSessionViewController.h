//
//  AboutNSURLSessionViewController.h
//  NSUrlSession
//
//  Created by Vikas Mishra on 12/5/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutNSURLSessionViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong,nonatomic) NSString *loadURL;
@end
