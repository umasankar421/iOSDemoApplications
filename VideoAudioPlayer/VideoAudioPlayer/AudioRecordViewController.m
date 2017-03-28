//
//  AudioRecordViewController.m
//  VideoAudioPlayer
//
//  Created by Amresh Singh on 1/6/17.
//  Copyright © 2017 dev. All rights reserved.
//

#import "AudioRecordViewController.h"


@interface AudioRecordViewController (){
    AppDelegate *appDelegate;
}

@end

@implementation AudioRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    [self setUpAudioPLayer];
    NSArray *filePath = [self applicationDocumentsDirectory];
    NSLog(@"Stored file : %@",filePath);
    [self.navigationItem setTitle:@"Audio Recorder"];
    
}
-(NSArray*)applicationDocumentsDirectory{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return paths;
}
    
-(void)setUpAudioRecorder{
    NSString *audioFileName = [NSString stringWithFormat:@"Audio%.f",[[NSDate date] timeIntervalSinceReferenceDate]];
    [appDelegate.recordList addObject:audioFileName];
    NSArray *pathComponents = [NSArray arrayWithObjects:
                               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
                               audioFileName,
                               nil];
    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
    // Setup audio session
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    // Define the recorder setting
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
    
    // Initiate and prepare the recorder
    audioRecorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:recordSetting error:NULL];
    audioRecorder.delegate = self;
    audioRecorder.meteringEnabled = YES;
    [audioRecorder prepareToRecord];
}

-(void)setUpAudioPLayer{
    NSError *error;
    NSURL *audioURL = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"song" ofType:@"mp3"]];
    
    NSURL *url = audioRecorder.url;
    //audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"song" ofType:@"mp3"]] error:&error];
    
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    if (error) {
        NSLog(@"Error : %@", [error localizedDescription]);
    } else {
        [audioPlayer prepareToPlay];
        NSLog(@"URL : %@",audioURL.absoluteString);
    }
}
#pragma AVAudioRecorderDelegate methods

-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    
    [appDelegate.recordListURL addObject:recorder.url];
    NSLog(@"Recorded Successfully : %@",appDelegate.recordList);
    NSLog(@"Recording List : %@",appDelegate.recordListURL);
    
}
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{
    
    NSLog(@"Buffer");
}
- (IBAction)recordAudio:(id)sender {
    if (audioRecorder.isRecording ) {
        [audioRecorder stop];
        [self.recordAudioButton setTitle:@"Record Audio" forState:UIControlStateNormal];
    }else{
        [self setUpAudioRecorder];
        [audioRecorder record];
        [self.recordAudioButton setTitle:@"Stop Record" forState:UIControlStateNormal];
    }
}
- (IBAction)playAudio:(id)sender {
    /*if (audioPlayer.isPlaying) {
        [audioPlayer stop];
        [self.playAudioButton setTitle:@"Play Audio" forState:UIControlStateNormal];
    }else{
        if (!audioRecorder.isRecording) {
            audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioRecorder.url error:nil];
        }
        [audioPlayer play];
        [self.playAudioButton setTitle:@"Stop Playing" forState:UIControlStateNormal];
    }*/
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
