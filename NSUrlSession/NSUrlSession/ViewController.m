//
//  ViewController.m
//  NSUrlSession
//
//  Created by Vikas Mishra on 12/5/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    UIActivityIndicatorView *activityIndicator;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.center = self.view.center;
    [self.view addSubview:activityIndicator];
    
    [self.navigationItem setTitle:@"NSURL Session"];
    
    
    // defining and creating a back ground thread
    
}


-(void)callDownLoadTaskWithUrl:(NSURL *)url{
    
    [activityIndicator startAnimating];
    NSURLSessionDownloadTask *downLoadTask = [[NSURLSession sharedSession]downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //
        NSLog(@"Url is : %@", location);
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 200)];
            imageView.image = image;
            [self.view addSubview:imageView];
        });
        
        [self stopActivityIndicator];
    }];
    
    [downLoadTask resume];
}

-(void)callDataTaskWithUrl:(NSURL *)url{
    [activityIndicator startAnimating];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"Data is : %@", json);
        NSLog(@"Responce is : %@", [response description]);
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
        UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 400, self.view.frame.size.width, 150)];
        
            [textView setText:[json description]];
        [self.view addSubview:textView];
        
        });
        
        
        [self stopActivityIndicator];
    }];
    [dataTask resume];
}

-(void)stopActivityIndicator{
    [activityIndicator stopAnimating];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)downLoadImage:(id)sender {

    //if (!activityIndicator.isAnimating) {
        NSURL *urlDownLoad = [NSURL URLWithString:@"http://upload.wikimedia.org/wikipedia/commons/7/7f/Williams_River-27527.jpg"];
        //NSURL *urlDownLoad = [NSURL URLWithString:@"http://aoldev.apponlease.com/gallery/product/RfYNn1.jpeg"];
        
        [self callDownLoadTaskWithUrl:urlDownLoad];
    //}
}

- (IBAction)getData:(id)sender {
    NSURL *urlData = [NSURL URLWithString:@"https://www.raywenderlich.com/demos/weather_sample/weather.php?format=json"];
    [self callDataTaskWithUrl:urlData];
}
@end
