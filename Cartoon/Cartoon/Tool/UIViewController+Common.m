//
//  UIViewController+Common.m
//  Pandas
//
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 苹果IOS. All rights reserved.
//

#import "UIViewController+Common.h"

@implementation UIViewController (Common)
-(void)showCancelButton{


}
-(void)showRightBtnWithTitle:(NSString *)title{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 60, 44);
    [rightBtn setTitle:title forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(registerActivityAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarBtn;

}
-(void)registerActivityAction:(UIButton *)btn{



}
-(void)showBackBtnWithImage:(NSString *)imageName{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 30);
    [backBtn addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    
   


}
-(void)backButtonAction:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:NO];
}
@end
