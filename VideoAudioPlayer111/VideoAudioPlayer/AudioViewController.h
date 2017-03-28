//
//  AudioViewController.h
//  VideoAudioPlayer
//
//  Created by Vikas Mishra on 12/22/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface AudioViewController : UIViewController{
    AVAudioPlayer *audioPlayer;
}
- (IBAction)playAudio:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *stopAudio;
- (IBAction)stopAudio:(id)sender;

@end
