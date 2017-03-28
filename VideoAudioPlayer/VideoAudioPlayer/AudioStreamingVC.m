//
//  AudioStreamingVC.m
//  VideoAudioPlayer
//
//  Created by Vikas Mishra on 1/10/17.
//  Copyright © 2017 dev. All rights reserved.
//

#import "AudioStreamingVC.h"

@interface AudioStreamingVC (){
    NSTimer *audioCollector;
    NSMutableData *audData;
}

@end

@implementation AudioStreamingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpAudioRecorder];
    audData = [[NSMutableData alloc]init];
    
    
    
    // Do any additional setup after loading the view.
}

-(void)collectTheAudioData{
    NSLog(@"collectTheAudioData");
    [self setmic];
}

-(void)setUpAudioRecorder{
    NSString *audioFileName = [NSString stringWithFormat:@"Audio%.f",[[NSDate date] timeIntervalSinceReferenceDate]];
    //[appDelegate.recordList addObject:audioFileName];
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
-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    NSLog(@"finished : %@",recorder.url.absoluteString);
}

- (IBAction)record_audio:(id)sender {
    
    if ([captureAudioSession isRunning]) {
        [captureAudioSession stopRunning];
        NSLog(@"Collected Data : %@",audData);
        [self.record_button setTitle:@"Record" forState:UIControlStateNormal];
    }else{
        //[audioRecorder record];
        [self setmic];
        //audioCollector = [NSTimer scheduledTimerWithTimeInterval:3.1 target:self selector:@selector(collectTheAudioData) userInfo:nil repeats:YES];
        [self.record_button setTitle:@"Stop" forState:UIControlStateNormal];
    }
}

-(void)setUpAudioPLayer{
    NSError *error;
    NSURL *audioURL = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"song" ofType:@"mp3"]];
    
    NSURL *url = audioRecorder.url;
    //audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"song" ofType:@"mp3"]] error:&error];
    
    //audioPlayer = [[AVAudioPlayer alloc] initWithData:audData error:nil];
    
    if (error) {
        NSLog(@"Error : %@", [error localizedDescription]);
    } else {
        [self.audioPlayer prepareToPlay];
        NSLog(@"URL : %@",audioURL.absoluteString);
    }
}

-(void)setmic{
    dispatch_queue_t captureQueue;
    captureQueue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_SERIAL);
    
    
    AVCaptureDevice* mic = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    AVCaptureDeviceInput* micinput = [AVCaptureDeviceInput deviceInputWithDevice:mic error:nil];
    AVCaptureAudioDataOutput* audioout = [[AVCaptureAudioDataOutput alloc] init];
    
    
    captureAudioSession = [[AVCaptureSession alloc]init];
    
    // [self.audsession setAutomaticallyConfiguresApplicationAudioSession:YES];
    
    [captureAudioSession addInput:micinput];
    
    if(audioout){
        [captureAudioSession addOutput:audioout];
        [audioout setSampleBufferDelegate:self queue:captureQueue];
    }
    
    // [audsession setSessionPreset:AVCap];
    dispatch_async(captureQueue, ^{
        [captureAudioSession startRunning];
    });
}


#pragma AVCaptureAudioDataOutputSampleBufferDelegate methods

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{
    
    AudioBufferList audioBufferList;
    CMBlockBufferRef blockBuffer;
    
    CMSampleBufferGetAudioBufferListWithRetainedBlockBuffer(sampleBuffer, NULL, &audioBufferList, sizeof(audioBufferList), NULL, NULL, 0,&blockBuffer);
    
    //CMSampleBufferCopyPCMDataIntoAudioBufferList(sampleBuffer,10,10,&audioBufferList);
    
    // NSLog(@"AudioDataOutputDelegate = %@", audioBufferList);
    
    NSMutableData *data = [[NSMutableData alloc] init];
    for( int y=0; y<audioBufferList.mNumberBuffers; y++ )
    {
        AudioBuffer audioBuffer = audioBufferList.mBuffers[y];
        Float32 *frame = (Float32*)audioBuffer.mData;
        [data appendBytes:frame length:audioBuffer.mDataByteSize];
        NSLog(@"buffer size--- %@",data.description);
    }
    //NSLog(@"AVCaptureAudioDataOutputSampleBufferDelegate : ");
     [audData appendData:data];
    CFRelease(blockBuffer);
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


- (IBAction)play_audio:(id)sender {
    
    NSError *error = nil;
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"song" ofType:@"mp3"]]];
    NSLog(@"Coverted Data : %@",data);
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"song" ofType:@"mp3"]] error:nil];
    
    
    
    NSLog(@"Player Data : %@ and %@",self.audioPlayer.data, self.audioPlayer.url);
    
    [self.audioPlayer play];
}
@end
