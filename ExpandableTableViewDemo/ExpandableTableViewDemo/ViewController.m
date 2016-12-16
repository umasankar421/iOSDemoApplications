//
//  ViewController.m
//  ExpandableTableView
//
//  Created by Vikas Mishra on 10/14/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize myTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadCellInfo];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)loadCellInfo{
    if([[NSFileManager defaultManager] fileExistsAtPath:[[NSBundle mainBundle]pathForResource:@"Categories" ofType:@"plist"]]){
        
        cellInfo = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"Categories" ofType:@"plist"]];
        
    }
    [self getVisibleRows];
    [self.myTableView reloadData];
}

-(void)getVisibleRows{
    visibleRows = [[NSMutableArray alloc]init];
    for (int i=0; i< cellInfo.count; i++) {
        NSLog(@"Cell Info At index %d and Object : %@",i,cellInfo[i]);
        if([[[cellInfo objectAtIndex:i] valueForKey:@"isVisible"] boolValue]){
            [visibleRows addObject:[NSNumber numberWithInt:i]];
        }
    }
    NSLog(@"visible cells : %@",visibleRows);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Tableview Delegate Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(visibleRows.count > 0){
        return visibleRows.count;
    }else{
        return 0;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *currentCellDictionary = [self getCurrentCellInfo:indexPath];
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TVCell"];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TVCell"];
    }
    NSLog(@"Text Label : %@",[currentCellDictionary valueForKey:@"cellTitle"]);
    cell.textLabel.text = [currentCellDictionary valueForKey:@"cellTitle"];
    
    //NSLog(@"current Dictionary : %@",currentCellDictionary);
    //NSLog(@"isParent : %d",[[currentCellDictionary valueForKey:@"isParent"] boolValue]);
    //cell.textLabel.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:18.0f];
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    if([[currentCellDictionary valueForKey:@"isParent"] boolValue]){
//        
//        
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TVCell"];
//        
//        if(cell == nil){
//            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TVCell"];
//        }
//        NSLog(@"Text Label : %@",[currentCellDictionary valueForKey:@"cellTitle"]);
//        cell.textLabel.text = [currentCellDictionary valueForKey:@"cellTitle"];
//        //cell.textLabel.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:18.0f];
//        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        return cell;
//    }else{
//        
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TVCell"];
//        
//        if(cell == nil){
//            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TVCell"];
//        }
//        NSLog(@"Text Label : %@",[currentCellDictionary valueForKey:@"cellTitle"]);
//        cell.textLabel.text = [currentCellDictionary valueForKey:@"cellTitle"];
//        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        
//        return cell;
//    }
    
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    BOOL shouldExpandAndShow;
    
    NSInteger tappedRow = [visibleRows[indexPath.row] intValue];
    
    if([[cellInfo[tappedRow] valueForKey:@"isExpandable"] boolValue]){
        shouldExpandAndShow = false;
        
        if (![[cellInfo[tappedRow] valueForKey:@"isExpanded"]boolValue]) {
            shouldExpandAndShow = true;
        }
    }
    [cellInfo[tappedRow] setValue:[NSNumber numberWithBool:shouldExpandAndShow] forKey:@"isExpanded"];
    
    
    for (int i = tappedRow + 1; i <= (tappedRow+[[cellInfo[tappedRow] valueForKey:@"additionalRows"] intValue]); i++) {
        
        [cellInfo[i] setValue:[NSNumber numberWithBool:shouldExpandAndShow] forKey:@"isVisible"];
    }
    [self getVisibleRows];
    [self.myTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    //[tableView reloadSections: withRowAnimation:UITableViewRowAnimationFade];
}
-(NSDictionary *)getCurrentCellInfo:(NSIndexPath *)indexPath{
    
    NSDictionary *cellDictionary = cellInfo[[visibleRows[indexPath.row] intValue]];
    return cellDictionary;
}
@end
