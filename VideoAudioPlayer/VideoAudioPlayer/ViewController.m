//
//  ViewController.m
//  VideoAudioPlayer
//
//  Created by Vikas Mishra on 12/21/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    UIButton *invisibleButton;
}
@end

@implementation ViewController
@synthesize playerViewController;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    NSURL *videoURL = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"pk" ofType:@"mp4"]];
    NSURL *url = [[NSURL alloc] initWithString:@"https://s3-eu-west-1.amazonaws.com/alf-proeysen/Bakvendtland-MASTER.mp4"];

    
    // create a player view controller
    AVPlayer *player = [AVPlayer playerWithURL:url];
    
    AVPlayerViewController *controller = [[AVPlayerViewController alloc] init];
    
    [self addChildViewController:controller];
    [self.view addSubview:controller.view];
    
    controller.view.frame = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-100);
    controller.player = player;
    controller.showsPlaybackControls = YES;
    player.closedCaptionDisplayEnabled = NO;
    [player pause];
    [player play];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}

-(void)playerViewController:(AVPlayerViewController *)playerViewController failedToStartPictureInPictureWithError:(NSError *)error{
    NSLog(@"failedToStartPictureInPictureWithError : %@",[error userInfo]);
}
-(BOOL)prefersStatusBarHidden{
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(videoPlayBackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.videoController];
    self.videoURL = info[UIImagePickerControllerMediaURL];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    self.videoController = [[MPMoviePlayerController alloc]init];
    
    [self.videoController setContentURL:self.videoURL];
    [self.videoController.view setFrame:CGRectMake(0, 0, 320, 460)];
    [self.view addSubview:self.videoController.view];
    [self.videoController play];
    
}

- (void)videoPlayBackDidFinish:(NSNotification *)notification {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    // Stop the video player and remove it from view
    [self.videoController stop];
    [self.videoController.view removeFromSuperview];
    self.videoController = nil;
    
    // Display a message
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Video Playback" message:@"Just finished the video playback. The video is now removed." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
    
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)recordVideo:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        picker.mediaTypes = [[NSArray alloc]initWithObjects:(NSString*)kUTTypeMovie, nil];
        [self presentViewController:picker animated:YES completion:NULL];
        
    }
}*/




@end
