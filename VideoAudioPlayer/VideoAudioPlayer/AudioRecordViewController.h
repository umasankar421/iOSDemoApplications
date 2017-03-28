//
//  AudioRecordViewController.h
//  VideoAudioPlayer
//
//  Created by Amresh Singh on 1/6/17.
//  Copyright © 2017 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"
@interface AudioRecordViewController : UIViewController<AVAudioRecorderDelegate,AVCaptureAudioDataOutputSampleBufferDelegate>{
    AVAudioRecorder *audioRecorder;
    AVAudioPlayer *audioPlayer;
}
- (IBAction)recordAudio:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *recordAudioButton;

@property (strong, nonatomic) IBOutlet UIButton *playAudioButton;
- (IBAction)playAudio:(id)sender;

@end
