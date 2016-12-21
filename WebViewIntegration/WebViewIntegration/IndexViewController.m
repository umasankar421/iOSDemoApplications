//
//  IndexViewController.m
//  WebViewIntegration
//
//  Created by Vikas Mishra on 12/21/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "IndexViewController.h"
#import "ViewController.h"

@interface IndexViewController (){
    NSArray *indexArray;
    ViewController *webViewer;
}

@end

@implementation IndexViewController
@synthesize indexTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:@"WebView"];
    self.lbl_description.text = @"WebView in iOS can load the following types of data";
    
    indexArray = @[@"1. WebView Load with URL",@"2. WebView Load with HTML",@"3. WebView Load with Data"];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



# pragma TableView Delegate methods..

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [indexArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    // forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [indexArray objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    webViewer = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewController"];
    webViewer.selectedIndexPath = indexPath;
    
    [self.navigationController pushViewController:webViewer animated:YES];
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
