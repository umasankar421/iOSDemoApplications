//
//  AudioPlayListTableViewController.h
//  VideoAudioPlayer
//
//  Created by Vikas Mishra on 1/9/17.
//  Copyright © 2017 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface AudioPlayListTableViewController : UITableViewController<AVAudioPlayerDelegate>{
    AVAudioPlayer *audioPlayer;
    AVAudioRecorder *recorder;
}

@end
