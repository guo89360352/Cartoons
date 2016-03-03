//
//  MessageViewController.m
//  Cartoon
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 郭亚茹. All rights reserved.
//

#import "MessageViewController.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "MessageModel.h"
#import "HWDefine.h"


@interface MessageViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIView *tableViewHeaderView;


@property (strong, nonatomic) UIScrollView *srollV;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) NSTimer *timer;

@property (strong, nonatomic) NSMutableArray *topImageArray;


@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self requestModel];
    
}

#pragma mark ------ 首页轮播图

- (void)startTimer{

    if (self.timer != nil) {
        return;
    }
    self.timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(rollAnimation) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];


}
-(void)rollAnimation{

    if (self.topImageArray.count > 0) {
        NSInteger page = (self.pageControl.currentPage +1 ) % self.topImageArray.count;
        self.pageControl.currentPage = page;
        CGFloat offsetx = self.pageControl.currentPage * kScreenWidth;
        [self.srollV setContentOffset:CGPointMake(offsetx, 0) animated:YES];
        
        
    }

}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    [self.timer invalidate];
    self.timer = nil;

}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    [self startTimer];


}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat pageWidth = self.srollV.frame.size.width;
    CGPoint offset = self.srollV.contentOffset;
    NSInteger pageNumber = offset.x / pageWidth;
    
    self.pageControl.currentPage = pageNumber;
    
}
-(void)pageSelectAction:(UIPageControl *)pageC{
    
    CGFloat pageWidth = self.srollV.frame.size.width;
    NSInteger pageNumber = pageC.currentPage;
    self.srollV.contentOffset = CGPointMake(pageNumber * pageWidth, 0);
    
}


-(void)requestModel{
    AFHTTPSessionManager *sessionManage = [AFHTTPSessionManager manager];
    sessionManage.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [sessionManage GET:kMessage parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //  GYRLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
       
        NSInteger code = [responseObject[@"code"] integerValue];
        NSString *error =responseObject[@"error"];
        self.topImageArray = [NSMutableArray new];
        if (code == 0&&[error isEqualToString:@""]) {
            NSString *rType = responseObject[@"params"][@"r"];
           NSArray *array = responseObject[@"results"];
            for (NSDictionary *dic in array) {
                MessageModel *messModel = [[MessageModel alloc] initWithDictionary:dic rType:rType];
                
                [self.topImageArray addObject:messModel];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"222222222222%@",error);
        
    }];
    
    
    
    
    
}
#pragma mark ------ 懒加载




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
