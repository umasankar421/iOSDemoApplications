//
//  MainContainerViewController.m
//  CoreTopicsLearning
//
//  Created by Vikas Mishra on 10/26/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "MainContainerViewController.h"

@interface MainContainerViewController (){
    BOOL isSideMenuOpened;
    UISwipeGestureRecognizer *leftSwipe;
    UISwipeGestureRecognizer *rightSwipe;
    UITapGestureRecognizer *tapGesture;
    
}

@end

@implementation MainContainerViewController
@synthesize sidecontainerView,mainContent;             



- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad : Side Container View Frame : %f",sidecontainerView.frame.size.width);
    
    leftSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwiped:)];
    [leftSwipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    rightSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwiped:)];
    [rightSwipe setDirection:UISwipeGestureRecognizerDirectionRight];
    tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tappedOnContent:)];
    ContentsTableViewController *contentTableView = [[ContentsTableViewController alloc]init];
    contentTableView.delegate = self;

    
    [self.view addGestureRecognizer:leftSwipe];
    [self.view addGestureRecognizer:rightSwipe];
    isSideMenuOpened = YES;
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"moreicon"] style:UIBarButtonItemStyleDone target:self action:@selector(openSideMenu:)];
    [self.navigationItem setLeftBarButtonItem:menuButton];
    // Do any additional setup after loading the view.
}


-(void)leftSwiped:(UISwipeGestureRecognizer *)leftSwipeView  {
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [sidecontainerView setFrame:CGRectMake(0, 0, 0, self.view.frame.size.height)];
        [mainContent setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        isSideMenuOpened = YES;
        self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"moreicon"];
        [self.view removeGestureRecognizer:tapGesture];
    }completion:nil];
}
-(void)rightSwiped:(UISwipeGestureRecognizer *)rightSwipeView{
    if ([rightSwipeView locationInView:rightSwipeView.view].x < self.view.frame.size.width*0.7) {
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [sidecontainerView setFrame:CGRectMake(0, 0, self.view.frame.size.width*0.7, self.view.frame.size.height)];
            [mainContent setFrame:CGRectMake(self.view.frame.size.width*0.7, 0, self.view.frame.size.width  , self.view.frame.size.height)];
            isSideMenuOpened = NO;
            
            self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"backWhite"];
            [self.view addGestureRecognizer:tapGesture];
        }completion:nil];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"Side Container View Frame : %f",sidecontainerView.frame.size.width);
    
}
-(void)sampleMethodRequired{
    NSLog(@"sampleMethodRequired is Called");
}
-(void)sampleMethodOptional{
    NSLog(@"sampleMethodOptional is Called");
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"mainContent"])  {
        //[sidecontainerView setFrame:CGRectMake(0, 0, self.view.frame.size.width*0.7, self.view.frame.size.height)];
    }
}

-(void)tappedOnContent:(UITapGestureRecognizer*)tappedView{
    if([tappedView locationInView:tappedView.view].x > self.view.frame.size.width*0.7){
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [sidecontainerView setFrame:CGRectMake(0, 0, 0, self.view.frame.size.height)];
            [mainContent setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            isSideMenuOpened = YES;
            self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"moreicon"];
            [self.view removeGestureRecognizer:tapGesture];
        }completion:nil];
    }
}

- (IBAction)openSideMenu:(id)sender {
    NSLog(@"Should Open Side menu");
    
    if(isSideMenuOpened){
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [sidecontainerView setFrame:CGRectMake(0, 0, self.view.frame.size.width*0.7, self.view.frame.size.height)];
            [mainContent setFrame:CGRectMake(self.view.frame.size.width*0.7, 0, self.view.frame.size.width  , self.view.frame.size.height)];
            isSideMenuOpened = NO;
            
            self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"backWhite"];
            [self.view addGestureRecognizer:tapGesture];
        }completion:nil];
        
    }else{
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [sidecontainerView setFrame:CGRectMake(0, 0, 0, self.view.frame.size.height)];
            [mainContent setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            isSideMenuOpened = YES;
            self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"moreicon"];
            [self.view removeGestureRecognizer:tapGesture];
        }completion:nil];
        
    }
    
}

@end
