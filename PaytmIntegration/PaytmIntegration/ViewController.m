//
//  ViewController.m
//  PaytmIntegration
//
//  Created by Vikas Mishra on 10/10/16.
//  Copyright © 2016 dev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"ViewDidLoad");
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)payNow:(id)sender {
    
    PGMerchantConfiguration *merchantConfiguration = [PGMerchantConfiguration defaultConfiguration];
    merchantConfiguration.checksumGenerationURL = @"https://pguat.paytm.com/paytmchecksum/paytmCheckSumGenerator.jsp";
    merchantConfiguration.checksumValidationURL = @"https://pguat.paytm.com/paytmchecksum/paytmCheckSumVerify.jsp";
    
    NSMutableDictionary *orderDictionary = [NSMutableDictionary new];
    
    orderDictionary[@"MID"] = @"WorldP64425807474247";
    orderDictionary[@"CHANNEL_ID"] = @"WAP";
    orderDictionary[@"INDUSTRY_TYPE_ID"] = @"Retail";
    orderDictionary[@"WEBSITE"] = @"worldpressplg";
    //Order configuration in the order object
    orderDictionary[@"TXN_AMOUNT"] = @"100";
    orderDictionary[@"ORDER_ID"] = [ViewController generateOrderIDWithPrefix:@"ORDER"];
    orderDictionary[@"REQUEST_TYPE"] = @"DEFAULT";
    orderDictionary[@"CUST_ID"] = @"1234567890";
    
    
    
    PGOrder *order = [PGOrder orderWithParams:orderDictionary];
    
    [PGServerEnvironment selectServerDialog:self.view completionHandler:^(ServerType type){
        PGTransactionViewController *transactionController = [[PGTransactionViewController alloc]initTransactionForOrder:order];
        if(type != eServerTypeNone){
            transactionController.serverType = type;
            transactionController.merchant = merchantConfiguration  ;
            transactionController.delegate = self;
            [self showController:transactionController];
        }
    }];
    
}

+(NSString*)generateOrderIDWithPrefix:(NSString *)prefix
{
    srand ( (unsigned)time(NULL) );
    int randomNo = rand(); //just randomizing the number
    NSString *orderID = [NSString stringWithFormat:@"%@%d", prefix, randomNo];
    NSLog(@"Order ID Generated is : %@",orderID);
    return orderID;
}


-(void)didSucceedTransaction:(PGTransactionViewController *)controller response:(NSDictionary *)response{
    DEBUGLOG(@"ViewController::didSucceedTransactionResponce = %@ ",response);
    NSString *title = [NSString stringWithFormat:@"Your order has been completed successfully : \n %@",response[@"ORDERID"]];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Order" message:title preferredStyle:UIAlertControllerStyleAlert]  ;
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void)didCancelTransaction:(PGTransactionViewController *)controller error:(NSError *)error response:(NSDictionary *)response{
    DEBUGLOG(@"ViewController::didCancelTransaction Responce = %@ and error = %@",response, error);
    
    NSString *msg = nil;
    if(!error){
        msg = [NSString stringWithFormat:@"Successful"];
    }else{
        msg = [NSString stringWithFormat:@"UnSuccessful"];
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Transaction Cancel" message:msg preferredStyle:UIAlertControllerStyleAlert]  ;
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:nil];
    
    [self removeController:controller];
}
-(void)didFailTransaction:(PGTransactionViewController *)controller error:(NSError *)error response:(NSDictionary *)response{
     DEBUGLOG(@"ViewController::didFailTransaction Responce = %@ and error = %@",response, error);
    if(response){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:error.localizedDescription message:[response description] preferredStyle:UIAlertControllerStyleAlert]  ;
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action1];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert]  ;
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action1];
        [self presentViewController:alert animated:YES completion:nil];
    }
    [self removeController:controller];
}

-(void)didFinishCASTransaction:(PGTransactionViewController *)controller response:(NSDictionary *)response{
    DEBUGLOG(@"ViewController::didFinishCASTransaction:response = %@", response);
}

-(void)showController:(PGTransactionViewController *)controller
{
    if (self.navigationController != nil)
        [self.navigationController pushViewController:controller animated:YES];
    else
        [self presentViewController:controller animated:YES
                         completion:^{
                             
                         }];
}

-(void)removeController:(PGTransactionViewController *)controller
{
    if (self.navigationController != nil)
        [self.navigationController popViewControllerAnimated:YES];
    else
        [controller dismissViewControllerAnimated:YES
                                       completion:^{
                                       }];
}
@end
