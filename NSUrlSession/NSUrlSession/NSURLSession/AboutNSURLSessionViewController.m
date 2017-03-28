//
//  AboutNSURLSessionViewController.m
//  NSUrlSession
//
//  Created by Vikas Mishra on 12/5/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "AboutNSURLSessionViewController.h"

@interface AboutNSURLSessionViewController ()

@end

@implementation AboutNSURLSessionViewController
@synthesize webView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL *url;
    NSLog(@"Load URL : %@", _loadURL);
    if([_loadURL isEqualToString:@""]){
        url = [NSURL URLWithString:@"https://www.raywenderlich.com/67081/cookbook-using-nsurlsession"];
    }else{
        url = [NSURL URLWithString:_loadURL];
    }
    
    
    //NSURL *url = [NSURL URLWithString:@"http://www.google.com"]
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
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
