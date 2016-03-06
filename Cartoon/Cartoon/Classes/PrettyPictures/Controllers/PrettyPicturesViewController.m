//
//  PrettyPicturesViewController.m
//  Cartoon
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 郭亚茹. All rights reserved.
//

#import "PrettyPicturesViewController.h"
#import <AFNetworking/AFHTTPSessionManager.h>

@interface PrettyPicturesViewController ()

@end

@implementation PrettyPicturesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestModel];
}
-(void)requestModel{
    AFHTTPSessionManager *sessionManage = [AFHTTPSessionManager manager];
    sessionManage.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [sessionManage GET:kPrrttyPic parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //  GYRLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"33333333333%@",responseObject);
        
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"222222222222%@",error);
        
    }];
    
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
