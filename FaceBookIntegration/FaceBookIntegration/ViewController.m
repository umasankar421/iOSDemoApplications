//
//  ViewController.m
//  FaceBookIntegration
//
//  Created by Vikas Mishra on 10/20/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "ViewController.h"
#import "ShareKitViewController.h"

@interface ViewController (){
    FBSDKLoginManager *loginManager;
    UIImageView *profileImage;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    FBSDKLoginButton *fbLoginButton = [[FBSDKLoginButton alloc]init];
    fbLoginButton.center = self.view.center;
    fbLoginButton.delegate = self;
    fbLoginButton.readPermissions = @[@"email",@"public_profile",@"user_friends",@"user_about_me",@"user_location",@"user_photos"];
    
    
    //Manage whether user is already logged in or not
    if([FBSDKAccessToken currentAccessToken]){
        NSLog(@"Token is already available : User is already Logged in : %@",[[FBSDKAccessToken currentAccessToken]tokenString]);
        [self showProfileDetails];
        [self fetchProfile];
        
    }else{
        NSLog(@"Token is not available : Not Logged in");
    }
    
    //Check the permissios has been granted by the user or not
    if([[FBSDKAccessToken currentAccessToken] hasGranted:@"public_profile"]){
        //
    }else{
        [loginManager logInWithReadPermissions:@[@"public_profile"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error){
            NSLog(@"Declined Permissions are : %@",result.declinedPermissions);
        }];
    }
    
    
    
//    loginManager = [[FBSDKLoginManager alloc]init];
//    [loginManager logInWithReadPermissions:@[@"email",@"public_profile",@"user_friends"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error){
//        //Handle here..
//    }];
    [self.view addSubview: fbLoginButton];
}

-(void)showProfileDetails{
    profileImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"profilePic"]];
    profileImage.frame = CGRectMake(self.view.frame.size.width*0.3, self.view.frame.size.width*0.3, self.view.frame.size.width*0.4, self.view.frame.size.width*0.4);
    //NSLayoutConstraint *horizontalCenter = [NSLayoutConstraint constraintWithItem:profileImage attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    
    profileImage.layer.cornerRadius=profileImage.frame.size.width/2;
    profileImage.clipsToBounds=YES;
    [self.view addSubview:profileImage];
    //[self.view addConstraint:horizontalCenter];
}
-(void)fetchProfile{
    NSLog(@"Fetch Profile ");
    //NSDictionary *fetchingParameters = [NSDictionary alloc]ini;
    //NSDictionary *parameters = [[NSDictionary alloc]initWithObjects:@[@"email",@"first_name",@"last_name",@"picture.type(large)"] forKeys:@[ @"fields",@"fields",@"fields",@"fields"]];
    
    [[[FBSDKGraphRequest alloc]initWithGraphPath:@"me" parameters:@{ @"fields" : @"id,name,link,first_name, last_name, picture.width(200).height(200), email, birthday, location,hometown"}]startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,id result, NSError *error){
        if(error != nil){
            NSLog(@"Some Error Occured while fecthing the data : %@",[error description]);
            return ;
        }
        NSDictionary *picture = result[@"picture"];
        NSDictionary *pictureData = picture[@"data"];
        NSString *url = pictureData[@"url"];
        NSLog(@"Profile Pic : %@",url);
        
        NSLog(@"fetched user: %@  and Email : %@", result , result[@"email"]);
        
        
        [profileImage setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]]];
        
        
        
        
    }];
    
    FBSDKGraphRequest *friendsList = [[FBSDKGraphRequest alloc]initWithGraphPath:@"me/taggable_friends" parameters:@{@"fields": @"id,name,picture.type(large),limit"} HTTPMethod:@"GET"];
    
    [friendsList startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        if (error !=nil)
        {
            NSLog(@"Some Error Occured while fetching friends list : %@", [error description]);
            
        }
        NSLog(@"result : %@",result);
    }];
    
    
    ShareKitViewController *shareController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ShareKitViewController"];
    [self.navigationController pushViewController:shareController animated:YES];
    
}
-(void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error{
    NSLog(@"LoginResult : %@",result);
    if(result.isCancelled){
        NSLog(@"Login is Cancelled");
    }else{
        [self fetchProfile];
    }
    //[result initWithToken:result.token isCancelled:result.isCancelled grantedPermissions:result.grantedPermissions declinedPermissions:result.declinedPermissions];
    
    //FBSDKAccessToken *token = [FBSDKAccessToken alloc]initWithTokenString:<#(NSString *)#> permissions:<#(NSArray *)#> declinedPermissions:<#(NSArray *)#> appID:<#(NSString *)#> userID:<#(NSString *)#> expirationDate:<#(NSDate *)#> refreshDate:<#(NSDate *)#>]
    
    NSLog(@"Granted Permissions : %@", result.grantedPermissions);
    NSLog(@"Autorization token : %@ ",result.token.appID);
    NSLog(@"Declined Permissions : %@",result.declinedPermissions);
    
    
}
-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
    NSLog(@"Logout is done");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
