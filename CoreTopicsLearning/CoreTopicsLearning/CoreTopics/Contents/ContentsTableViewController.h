//
//  ContentsTableViewController.h
//  CoreTopicsLearning
//
//  Created by Vikas Mishra on 10/26/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SampleProtocol;

@interface ContentsTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSArray *contentsArray;
@property(weak,nonatomic)id <SampleProtocol> delegate;
@end
@protocol SampleProtocol <NSObject>

-(void)sampleMethodRequired;
-(void)sampleMethodOptional;
@end
