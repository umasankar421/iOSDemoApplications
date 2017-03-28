//
//  ViewController.h
//  ExpandableTableView
//
//  Created by Vikas Mishra on 10/14/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *visibleRows;
    NSMutableArray *cellInfo;
}

@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@end

