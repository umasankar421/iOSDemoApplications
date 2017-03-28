//
//  ViewController.h
//  VideoAudioPlayer
//
//  Created by Vikas Mishra on 12/21/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#include <MediaPlayer/MediaPlayer.h>
#include <MobileCoreServices/MobileCoreServices.h>
#include <AVKit/AVKit.h>
@interface ViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,AVPlayerViewControllerDelegate>{
   
}
@property (strong, nonatomic) NSURL *videoURL;
//@property (strong, nonatomic) MPMoviePlayerController *videoController;
@property (strong, nonatomic) AVPlayerViewController *playerViewController;

//- (IBAction)recordVideo:(id)sender;
@end

