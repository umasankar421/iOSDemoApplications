//
//  ViewController.h
//  SQLiteDemo
//
//  Created by Vikas Mishra on 3/3/17.
//  Copyright © 2017 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditViewController.h"
@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,EditViewControllerDeledate>
@property (strong, nonatomic) IBOutlet UITableView *tblPeople;
- (IBAction)addNewRecord:(id)sender;



@end

