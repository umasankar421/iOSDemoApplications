//
//  ViewController.m
//  PulltoRefresh
//
//  Created by Vikas Mishra on 12/20/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    NSArray *tableData;
}

@end

@implementation ViewController
@synthesize btn_scrollUp;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"Click to Down" style:UIBarButtonItemStyleDone target:self action:@selector(scrolltoDown:)];
    [self.navigationItem setRightBarButtonItem:rightButton];
    btn_scrollUp.hidden = YES;
    
    tableData = [[NSArray alloc]init];
    tableData = @[@"Aakriti",@"Aamukta",@"Aanandita",@"Aarti",@"Abhaya",@"Bhaageerathi",@"Bhaargavi",@"Bhanu",@"Chandini",@"Chaaya",@"Damayanti",@"Deepika",@"Deepti",@"Divya",@"Ektaa",@"Esha",@"Fulki",@"Ganga",@"Gauri",@"Gautami",@"Geeta ",@"Hrishita",@"Indira",@"Indraja",@"Janaki",@"Jyotsana",@"Kalpana",@"Kamala",@"Kanchan Verma",@"Lakshmi",@"Lalitha",@"Madhavi",@"Madhu",@"Madhuri",@"Manju",@"Nandini",@"Nilima",@"Nirmala",@"Oormila",@"Padma",@"Parvati",@"Pooja",@"Priya",@"Radha",@"Raksha",@"Rishita",@"Sandhya",@"Saraswati",@"Savitri",@"Sharmila",@"Shobhana",@"Uma Shankar",@"Upasana",@"Vaishali",@"Yamuna",@"Women",@"Xanshai",@"Zampa",@"Zameera",@"Zain",@"Trisha",@"Queen",@"Vani",@"Vanaja"];
    
}


- (IBAction)scrolltoDown:(id)sender {
    
    if ([self.navigationItem.rightBarButtonItem.title isEqualToString:@"Scroll to Down"]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self scrollToTheBottom:YES];
            [self.navigationItem.rightBarButtonItem setTitle:@"Scroll to Up"];
            
            //btn_scrolltoDown.hidden = YES;
            //btn_scrolltoUp.hidden = NO;
            
        });
    }else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self scrollToTheTop:YES];
            [self.navigationItem.rightBarButtonItem setTitle:@"Scroll to Down"];
            
            //btn_scrolltoDown.hidden = YES;
            //btn_scrolltoUp.hidden = NO;
            
        });
    }
}
- (void)scrollToTheBottom:(BOOL)animated{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[tableData count]-1 inSection:0];
    [self.refreshTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:animated];
    btn_scrollUp.hidden = NO;
}

- (IBAction)scrolltoUp:(id)sender {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self scrollToTheTop:YES];
        [self.navigationItem.rightBarButtonItem setTitle:@"Scroll to Down"];
        //btn_scrolltoUp.hidden = NO;
    });
}
- (void)scrollToTheTop:(BOOL)animated{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.refreshTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:animated];
    btn_scrollUp.hidden = YES;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSArray *visibleRows = [self.refreshTableView visibleCells];
//    UITableViewCell *lastVisibleCell = [visibleRows lastObject];
//    NSIndexPath *path = [self.refreshTableView indexPathForCell:lastVisibleCell];
//    
//    if(path.row == [tableData count]-1)
//    {
//        btn_scrollUp.hidden = NO;
//    }
    
    if (scrollView.contentOffset.y == 0) {
        btn_scrollUp.hidden = YES;
        [self.navigationItem.rightBarButtonItem setTitle:@"Scroll to Down"];
    }
}

-(void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    btn_scrollUp.hidden = YES;
    [self.navigationItem.rightBarButtonItem setTitle:@"Scroll to Down"];
}

# pragma TableView Delegate methods.

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 1;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row + 1 == tableData.count) {
        btn_scrollUp.hidden = NO;
        [self.navigationItem.rightBarButtonItem setTitle:@"Scroll to Up"];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [tableData count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
