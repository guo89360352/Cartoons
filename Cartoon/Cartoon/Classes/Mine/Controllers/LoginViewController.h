//
//  LoginViewController.h
//  Cartoon
//
//  Created by scjy on 16/3/9.
//  Copyright © 2016年 郭亚茹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextLabel;

@property (weak, nonatomic) IBOutlet UITextField *passwordLabel;
@property (weak, nonatomic) IBOutlet UIButton *loginLabel;

@property (weak, nonatomic) IBOutlet UIButton *regiester;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@end
