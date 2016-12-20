//
//  ViewController.h
//  PulltoRefresh
//
//  Created by Vikas Mishra on 12/20/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *refreshTableView;
@property (strong, nonatomic) IBOutlet UIButton *btn_scrollUp;

- (IBAction)scrolltoUp:(id)sender;

@end

