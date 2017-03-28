//
//  ContentsTableViewController.m
//  CoreTopicsLearning
//
//  Created by Vikas Mishra on 10/26/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "ContentsTableViewController.h"
#import "MainContainerViewController.h"
#import "FirstProtocolViewController.h"
@interface ContentsTableViewController ()

@end

@implementation ContentsTableViewController
@synthesize contentsArray;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    contentsArray = @[@"Container View",@"Protocols and Delegates",@"NSUrlSession",@"Blocks",@"Local Notifications",@"Remote Notifications", @"Properties",@"Categories",@"Extensions",@"Dynamics",@"Singleton Classes",@"MVC, KVC, KVO",@"NSNotification Center",@"Frameworks"];
    [self.navigationItem setTitle:@"Contents"];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
    [[self delegate]sampleMethodOptional];
    [[self delegate]sampleMethodRequired];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     //self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [contentsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contentsCell"];
    if(cell==nil){
       cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"contentsCell"];
    }
    
    // Configure the cell...
    cell.textLabel.text = [contentsArray objectAtIndex:indexPath.row];
    [cell.textLabel setTextColor:[UIColor brownColor]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        MainContainerViewController *containerView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"MainContainerViewController"];
       // [self.navigationController pushViewController:containerView animated:YES];
    }else if(indexPath.row == 1){
        FirstProtocolViewController *firstProtocol = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"FirstProtocolViewController"];
        [self.navigationController pushViewController:firstProtocol animated:YES];
    }
    else if(indexPath.row == 2){
        
    }
}

//-(UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath{
//    if(indexPath.row == 1){
//        return UITableViewCellAccessoryDisclosureIndicator;
//    }else if (indexPath.row == 2){
//        return UITableViewCellAccessoryDetailButton;
//    }else if(indexPath.row == 3){
//        return UITableViewCellAccessoryDetailDisclosureButton;
//    }
//    
//    return  UITableViewCellAccessoryCheckmark;
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
