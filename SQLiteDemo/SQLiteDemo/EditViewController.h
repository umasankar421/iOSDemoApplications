//
//  EditViewController.h
//  SQLiteDemo
//
//  Created by Vikas Mishra on 3/3/17.
//  Copyright © 2017 dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditViewControllerDeledate

-(void)editingInfoWasFinished;
@end


@interface EditViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, strong) id<EditViewControllerDeledate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *txtFirstname;

@property (weak, nonatomic) IBOutlet UITextField *txtLastname;

@property (weak, nonatomic) IBOutlet UITextField *txtAge;

@property (nonatomic) int recordIDToEdit;
- (IBAction)saveInfo:(id)sender;
@end
