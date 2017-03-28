//
//  SecondProtocolViewController.h
//  CoreTopicsLearning
//
//  Created by Vikas Mishra on 11/18/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SecondViewControllerDelegate <NSObject>
@required
-(void)getSomeData:(NSString *)data;
@end
@interface SecondProtocolViewController : UIViewController
@property (nonatomic,retain) NSString *data;
@property (nonatomic,weak) id <SecondViewControllerDelegate> delegate;
@end
