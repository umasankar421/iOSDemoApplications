//
//  ShareKitViewController.m
//  FaceBookIntegration
//
//  Created by Vikas Mishra on 10/21/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "ShareKitViewController.h"

@interface ShareKitViewController (){
    UIView *mainView;
    
}

@end

@implementation ShareKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //mainView = [UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreen., <#CGFloat height#>)
    FBSDKShareButton *shareButton = [[FBSDKShareButton alloc]initWithFrame:CGRectMake(75,100, 200, 50)];
    FBSDKLikeControl *likeButton = [[FBSDKLikeControl alloc]initWithFrame:CGRectMake(100, 200, 200, 30)];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(75,100, 200, 50)];
    button.titleLabel.text = @"Share";
    //shareButton = button;
    
    
    likeButton.objectID = @"https://www.facebook.com/time2know/";
    //shareButton.center = self.view.center;
    
    FBSDKShareLinkContent *linkContent = [[FBSDKShareLinkContent alloc]init];
    [linkContent setContentURL:[NSURL URLWithString:@"http://www.facebook.com/dearumasankar"]];
    shareButton.shareContent = linkContent;
    [self.view addSubview:likeButton];
    [self.view addSubview:shareButton];

}





#pragma sharing Delegate methods .............

-(void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results{
    NSLog(@"Sharing is successfully done : %@",results);
}
-(void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error{
    NSLog(@"Sharing failed with error : %@",[error description]);
}
-(void)sharerDidCancel:(id<FBSDKSharing>)sharer{
    NSLog(@"Sharing is cancelled ");
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
