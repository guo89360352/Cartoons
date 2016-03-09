//
//  RegisterViewController.m
//  Cartoon
//
//  Created by scjy on 16/3/9.
//  Copyright © 2016年 郭亚茹. All rights reserved.
//

#import "RegisterViewController.h"
#import <BmobSDK/Bmob.h>
#import "ProgressHUD.h"

@interface RegisterViewController ()<UITextFieldDelegate>

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.passwordLabel.secureTextEntry = YES;
    self.aginPassLabel.secureTextEntry = YES;
    
    
}
#pragma mark -----  textfeild delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
    
}
//点击页面空白处回收键盘
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //第一中方式
    //    [self.userNameTF resignFirstResponder];
    //    [self.passwordTF resignFirstResponder];
    //    [self.confirmPassTF resignFirstResponder];
    //    [self.meilTF resignFirstResponder];
    
    //第二种方式
    [self.view endEditing:YES];
    
    
}

- (IBAction)registerBtn:(id)sender {
    if (![self checkout]) {
        
        return;
    }
    
    [ProgressHUD show:@"正在为你注册"];
    
    BmobUser *bUser = [[BmobUser alloc] init];
    [bUser setUsername:self.userNameLabel.text];
    [bUser setPassword:self.passwordLabel.text];
    [bUser signUpInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            [ProgressHUD showSuccess:@"注册成功"];
            NSLog(@"注册成功");
            
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"恭喜你" message:@"注册成功" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alertAc = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"确定");
                
            }];
            UIAlertAction *cancelAc = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"取消");
                
            }];
            
            
            [alertC addAction:alertAc];
            [alertC addAction:cancelAc];
            [self presentViewController:alertC animated:NO completion:^{
                
            }];
            
            
            
            
        }else {
            [ProgressHUD showError:@"注册失败"];
            NSLog(@"注册失败");
            
        }
    }];
    

}
//注册前的判断
-(BOOL)checkout{
    //用户名不能为空且不能为空格
    //stringByReplacingOccurrencesOfString:@"" withString:@""]去掉空格的方法，遍历字符串，发现空格就替换
    if (self.userNameLabel.text.length <= 0 ||[self.userNameLabel.text stringByReplacingOccurrencesOfString:@" " withString:@""].length <= 0) {
        return NO;
    }
    //两次输入的密码不能为空
    if (self.passwordLabel.text.length <= 0 || [self.passwordLabel.text stringByReplacingOccurrencesOfString:@" " withString:@""].length <= 0) {
        //alert提示框
        return NO;
    }
    //两次输入密码一致
    if (![self.passwordLabel.text isEqualToString:self.aginPassLabel.text]) {
        //alert提示框
        return NO;
    }
    //正则表达式
    //判断输入是否是手机号
    //判断输入邮箱是否正确
    return YES;
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
