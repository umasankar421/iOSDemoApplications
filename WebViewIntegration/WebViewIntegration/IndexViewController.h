//
//  IndexViewController.h
//  WebViewIntegration
//
//  Created by Vikas Mishra on 12/21/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndexViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UILabel *lbl_description;
@property (strong, nonatomic) IBOutlet UITableView *indexTableView;

@end
