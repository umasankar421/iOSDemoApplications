//
//  ExpandableViewController.h
//  ExpandableTableViewDemo
//
//  Created by Vikas Mishra on 12/16/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpandableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    UITableView *expandableTableView;
    NSArray *expandableArray1;
    NSArray *expandableArray2;
    BOOL isSectionCellExpanded1;
    BOOL isSectionCellExpanded2;
}

@end
