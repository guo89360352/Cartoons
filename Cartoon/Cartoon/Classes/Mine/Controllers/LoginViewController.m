//
//  LoginViewController.m
//  Cartoon
//
//  Created by scjy on 16/3/9.
//  Copyright © 2016年 郭亚茹. All rights reserved.
//

#import "LoginViewController.h"
#import "MineViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
- (IBAction)backBtn:(id)sender {
    
    MineViewController *mien = [[MineViewController alloc] init];
    [self dismissViewControllerAnimated:mien completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
