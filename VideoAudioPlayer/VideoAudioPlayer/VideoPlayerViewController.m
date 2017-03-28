//
//  VideoPlayerViewController.m
//  VideoAudioPlayer
//
//  Created by Vikas Mishra on 12/23/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "VideoPlayerViewController.h"

@interface VideoPlayerViewController ()

@end

@implementation VideoPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     NSURL *videoURL = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"pk" ofType:@"mp4"]];
    AVPlayer *player = [AVPlayer playerWithURL:videoURL];
    self.player = player;
    
    [self.player play];
    //NSLog(@"")
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
