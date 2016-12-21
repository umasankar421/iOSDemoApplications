//
//  ViewController.h
//  WebViewIntegration
//
//  Created by Vikas Mishra on 12/20/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@interface ViewController : UIViewController<UIWebViewDelegate>{
    
}

@property (strong, nonatomic) IBOutlet WKWebView *wkWebViewer;
@property (strong, nonatomic) IBOutlet UIWebView *webViewer;
@property (strong, nonatomic)  NSIndexPath *selectedIndexPath;

@end

