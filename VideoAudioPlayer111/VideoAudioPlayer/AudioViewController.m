//
//  AudioViewController.m
//  VideoAudioPlayer
//
//  Created by Vikas Mishra on 12/22/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "AudioViewController.h"

@interface AudioViewController ()

@end

@implementation AudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSError *error;
    NSURL *audioURL = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"song" ofType:@"mp3"]];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"song" ofType:@"mp3"]] error:&error];
    if (error) {
        NSLog(@"Error : %@", [error localizedDescription]);
    } else {
        [audioPlayer prepareToPlay];
        NSLog(@"URL : %@",audioURL.absoluteString);
    }
    
    
    [self callApi];
    
}

-(void)callApi{
    
    NSURL *url = [NSURL URLWithString:@"http://www.omdbapi.com/?s=batman"];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"JSONData : %@", jsonDict);
            
            NSMutableArray *jsonArray = [jsonDict mutableArrayValueForKey:@"Search"];
            NSLog(@"JSON Array : %@", jsonArray);
        }else{
            NSLog(@"error on parsing : %@",[error userInfo]);
        }
        
    }];
    
    [dataTask resume];
    
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

- (IBAction)playAudio:(id)sender {
    [audioPlayer play];
}
- (IBAction)stopAudio:(id)sender {
    if (audioPlayer) {
        [audioPlayer stop];
    }
}
@end
