//
//  AudioStreamingVC.h
//  VideoAudioPlayer
//
//  Created by Vikas Mishra on 1/10/17.
//  Copyright © 2017 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface AudioStreamingVC : UIViewController<AVAudioRecorderDelegate,AVCaptureAudioDataOutputSampleBufferDelegate,AVAudioPlayerDelegate>{
    AVAudioRecorder *audioRecorder;
    AVCaptureSession *captureAudioSession;
    //AVAudioPlayer *audioPlayer;
}
- (IBAction)record_audio:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *record_button;
- (IBAction)play_audio:(id)sender;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@end
