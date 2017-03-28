//
//  MainContainerViewController.h
//  CoreTopicsLearning
//
//  Created by Vikas Mishra on 10/26/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentsTableViewController.h"

@interface MainContainerViewController : UIViewController <SampleProtocol>
@property (strong, nonatomic) IBOutlet UIView *sidecontainerView;
- (IBAction)openSideMenu:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *mainContent;


@end


