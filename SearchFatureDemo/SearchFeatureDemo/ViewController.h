//
//  ViewController.h
//  SearchFeatureDemo
//
//  Created by Vikas Mishra on 12/14/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchResultsUpdating>

@property (strong, nonatomic) IBOutlet UITableView *searchTableView;
@property (strong,nonatomic) IBOutlet UISearchController *searchController;
@end

