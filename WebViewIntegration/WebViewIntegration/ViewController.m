//
//  ViewController.m
//  WebViewIntegration
//
//  Created by Vikas Mishra on 12/20/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    NSString *_webURL;
    BOOL theBool;
    UIProgressView* myProgressView;
    NSTimer *myTimer;
    
    UIActivityIndicatorView *indicatorView;
}

@end

@implementation ViewController
@synthesize wkWebViewer,webViewer,selectedIndexPath;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
   // NSURLRequest *webViewRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.gmail.com"]];
    
    myProgressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    [self.view addSubview:myProgressView];
    webViewer.delegate = self;
    
    
    indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicatorView.center = self.view.center;
    [self.view addSubview:indicatorView];
    
    switch (selectedIndexPath.row) {
        case 0:{
            [self.navigationItem setTitle:@"WebView Load With URL"];
            [self addAlertController];
            break;
        }
        case 1:{
            [self.navigationItem setTitle:@"WebView Load With HTML"];
            [self loadWithHTML];
            break;
        }
        case 2:{
            [self.navigationItem setTitle:@"WebView Load With Data"];
            [self loadWithNSData];
            break;
        }


        default:
            break;
    }
    
   
    
}
-(void)addAlertController{
    UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"Web View" message:@"Enter the URL which you want to load" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Enter url here";
    }];
    UIAlertAction *go = [UIAlertAction actionWithTitle:@"Go" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *enteredString = [alertController.textFields objectAtIndex:0].text;
        NSArray *array = [enteredString componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        for(int arrayIndex=0; arrayIndex < [array count]; arrayIndex++) {
            NSString *arrayString = [array objectAtIndex:arrayIndex];
            if (arrayIndex == 0) {
                _webURL = [NSString stringWithFormat:@"%@",arrayString];
            }else{
                _webURL = [NSString stringWithFormat:@"%@+%@",_webURL,arrayString];
            }
        }
        NSString *searchInitial = @"https://www.google.co.in/search?q=";
        _webURL = [NSString  stringWithFormat:@"%@%@",searchInitial,_webURL];
        if ([enteredString isEqualToString:@""]) {
            _webURL = @"http://www.google.com";
        }
        NSLog(@"webURL : %@",_webURL);
        NSURLRequest *webViewRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:_webURL]];
        [webViewer loadRequest:webViewRequest];
    }];
    [alertController addAction:go];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)loadWithHTML{
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];

    [webViewer loadHTMLString:htmlString baseURL: [[NSBundle mainBundle] bundleURL]];
    
}
-(void)loadWithNSData{
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"jpg"];
    NSData *data = [NSData dataWithContentsOfFile:htmlFile];
    [webViewer loadData:data MIMEType:@"image/jpg" textEncodingName:@"UTF-8" baseURL:nil];
    
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"webViewDidStartLoad : %@",webViewer.request.URL.absoluteString);
    
    myProgressView.progress = 0;
    theBool = false;
    //0.01667 is roughly 1/60, so it will update at 60 FPS
    myTimer = [NSTimer scheduledTimerWithTimeInterval:0.01667 target:self selector:@selector(timerCallback) userInfo:nil repeats:YES];
    
    [indicatorView startAnimating];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"webViewDidFinishLoad");
    theBool = true;
    
    [indicatorView stopAnimating];
}

-(void)timerCallback {
    if (theBool) {
        if (myProgressView.progress >= 1) {
            myProgressView.hidden = true;
            [myTimer invalidate];
        }
        else {
            myProgressView.progress += 0.1;
        }
    }
    else {
        myProgressView.progress += 0.05;
        if (myProgressView.progress >= 0.95) {
            myProgressView.progress = 0.95;
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
