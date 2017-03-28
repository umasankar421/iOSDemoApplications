//
//  FirstProtocolViewController.m
//  CoreTopicsLearning
//
//  Created by Vikas Mishra on 11/18/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "FirstProtocolViewController.h"

@interface FirstProtocolViewController (){
    SecondProtocolViewController *secondScreen;
}

@end

@implementation FirstProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)getSomeData:(NSString *)data{
    self.dataLabel.text = data;
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
