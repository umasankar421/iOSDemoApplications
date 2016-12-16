//
//  ExpandableViewController.m
//  ExpandableTableViewDemo
//
//  Created by Vikas Mishra on 12/16/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "ExpandableViewController.h"

@interface ExpandableViewController ()

@end

@implementation ExpandableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    expandableTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    expandableTableView.backgroundColor = [UIColor whiteColor];
    expandableTableView.delegate = self;
    expandableTableView.dataSource = self;
    expandableTableView.allowsSelection = YES;
    
    expandableTableView.scrollEnabled = YES;
    expandableTableView.alwaysBounceVertical = YES;
    [self.view addSubview:expandableTableView];
    expandableArray1 = @[@"Vegetarian", @"Non-Vegetarian", @"Biryani"];
    expandableArray2 = @[@"Vegetarian", @"Non-Vegetarian", @"Biryani"];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self.view setNeedsLayout];
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self updateViewDimensions];
}
- (void)updateViewDimensions
{
    expandableTableView.frame = CGRectMake(0, 40, 320, 550);
}


#pragma TableView Delegate Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0)
    {
        int cellCount = 2; // Default count - if not a single cell is expanded
        
        if (isSectionCellExpanded1)
        {
            cellCount += [expandableArray1 count];
        }
        
        return cellCount;
    }
    
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *strCellId = @"CellId";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0){
        if (indexPath.row == 0){
            cell.textLabel.text = @"Expandable Cell";
            UIImageView *accessoryImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
            
            if (isSectionCellExpanded1){
                accessoryImageView.image = [UIImage imageNamed:@"icon_arrow_down"];
                //cell.detailTextLabel.text = @"Status : Expanded";
            }
            else{
                accessoryImageView.image = [UIImage imageNamed:@"icon_arrow_right"];
                //cell.detailTextLabel.text = @"Status : Not Expanded";
            }
            cell.accessoryView = accessoryImageView;
        }
        else{
            if (isSectionCellExpanded1 && [expandableArray1 count] >= indexPath.row){
                cell.textLabel.text = [NSString stringWithFormat:@"%@", [expandableArray1 objectAtIndex:indexPath.row - 1]];
            }else if (isSectionCellExpanded2 && [expandableArray2 count] >= indexPath.row) // Check Expanded status and do the necessary changes
            {
                cell.textLabel.text = [NSString stringWithFormat:@"%@", [expandableArray2 objectAtIndex:indexPath.row - 1]];
            }
            else
            {
                cell.textLabel.text = @"Static Cell";
            }
        }
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0){
        // Change status of a cell reload table
        
        isSectionCellExpanded1 = !isSectionCellExpanded1;
        
        [expandableTableView reloadData];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
