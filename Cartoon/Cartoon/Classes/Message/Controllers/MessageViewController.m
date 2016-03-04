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
#import "PullingRefreshTableView.h"
#import "MessageTableViewCell.h"
#import "HWTool.h"
#import "MessageDetailViewController.h"
#import "MessageModel.h"
#import "HWDefine.h"


@interface MessageViewController ()<UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate>
{
    NSInteger _pageCount;
    

}
@property (strong, nonatomic) UIButton *leftBtn;

@property (strong, nonatomic) PullingRefreshTableView *tableView;
@property (strong, nonatomic) UIView *tableViewHeaderView;


@property (strong, nonatomic) UIScrollView *srollV;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) NSTimer *timer;

@property (strong, nonatomic) NSMutableArray *topImageArray;
@property (strong, nonatomic) NSMutableArray *listArray;
@property (strong, nonatomic) NSMutableArray *imageArray;
@property (strong, nonatomic) NSMutableArray *shareUrlArray;
@property (strong, nonatomic) NSMutableArray *idsArray;

@property (strong, nonatomic) NSMutableArray *htmlArray;


@property (assign, nonatomic) BOOL refreshing;


@end

@implementation MessageViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"MessageTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];

    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(0, 0, 30, 30);
    [self.leftBtn setImage:[UIImage imageNamed:@"search_article"] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftbtn=[[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    self.navigationItem.leftBarButtonItem=leftbtn;
  //  [leftbtn setImage:[UIImage imageNamed:@"search_article"]];
    //导航栏上navigationItem
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(evaluationAction)];
    rightBarButton.tintColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.topImageArray = [NSMutableArray new];
    self.listArray = [NSMutableArray new];
    self.imageArray = [NSMutableArray new];
    self.shareUrlArray = [NSMutableArray new];
    self.idsArray = [NSMutableArray new];
    self.htmlArray = [NSMutableArray new];

    [self requestListData];
    [self requestModel];
    [self startTimer];
    [self.tableView launchRefreshing];

    
}
-(void)viewWillAppear:(BOOL)animated{

    self.tabBarController.tabBar.hidden = NO;


}
-(void)searchAction{
    NSLog(@"ddd");

}
//右键评价方法
-(void)evaluationAction{



}
#pragma mark----------PullingRefreshTableViewDelegate
//tableView上拉开始刷新的时候调用
-(void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    self.refreshing = YES;
    _pageCount = 1;
    [self performSelector:@selector(requestListData) withObject:nil afterDelay:1.0];
    
}
//下拉
- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    self.refreshing = NO;
    _pageCount += 1;
    [self performSelector:@selector(requestListData) withObject:nil afterDelay:1.0];
}



//刷新完成时间
- (NSDate *)pullingTableViewRefreshingFinishedDate{
    return [HWTool getsystemNewDate];
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

    if (self.imageArray.count > 0) {
        NSInteger page = (self.pageControl.currentPage +1 ) % self.imageArray.count;
        self.pageControl.currentPage = page;
        CGFloat offsetx = self.pageControl.currentPage * kScreenWidth;
        [self.srollV setContentOffset:CGPointMake(offsetx, 0) animated:YES];
        
        
    }

}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    [self.timer invalidate];
    self.timer = nil;

}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tableView tableViewDidScroll:scrollView];
}
//手指结束拖动
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [self.tableView tableViewDidEndDragging:scrollView];
    
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
#pragma mark ------- UITableViewDataSource和delegate的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.listArray.count > 0) {
        
        return self.listArray.count;

           }
    return self.listArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MessageTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
 ;
    if (indexPath.row < self.listArray.count) {
        cell.messageModel = self.listArray[indexPath.row];
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageModel *messageModel = self.listArray[indexPath.row];

    MessageDetailViewController *messageDetailVC = [[MessageDetailViewController alloc] init];
    messageDetailVC.judg = NO;
    
    messageDetailVC.messageId = messageModel.shareUrl;
    
    [self.navigationController pushViewController:messageDetailVC animated:NO];


}

#pragma mark --------设置tableview的区头为scrollView和设置按钮
-(void)configTableViewHeaderView{
    self.tableViewHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth, 200)];
    
    self.srollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 186)];
    
    self.srollV.contentSize = CGSizeMake(self.imageArray.count * kScreenWidth, 186);
    self.srollV.pagingEnabled = YES;
    self.srollV.showsHorizontalScrollIndicator = NO;
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 82, kScreenWidth, 186)];
    self.pageControl.numberOfPages = self.imageArray.count;
    self.pageControl.currentPageIndicatorTintColor = [UIColor cyanColor];
    [self.pageControl addTarget:self action:@selector(pageSelectAction:) forControlEvents:UIControlEventTouchUpInside];
  
    if (self.topImageArray > 0 && self.imageArray > 0 ) {
        for (int i = 0; i < self.imageArray.count; i++) {
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth * i, 0, kScreenWidth, 186)];
            [imageV sd_setImageWithURL:[NSURL URLWithString:self.imageArray[i]] placeholderImage:nil];
            [self.srollV addSubview:imageV];
            
            UIButton *touchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            touchBtn.frame = imageV.frame;
            touchBtn.tag = 100+i;
            [touchBtn addTarget:self action:@selector(touchAdvertisement:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.srollV addSubview:touchBtn];
            
            
        }

    }else {
    
        NSLog(@"ddd");
    
    }
        [self.tableViewHeaderView addSubview:self.srollV];
    [self.tableViewHeaderView addSubview:self.pageControl];
    self.tableView.tableHeaderView = self.tableViewHeaderView;


}
-(void)touchAdvertisement:(UIButton *)btn{

    MessageDetailViewController *messageDetailVC = [[MessageDetailViewController alloc] init];
    messageDetailVC.judg = YES;
    messageDetailVC.messageId = self.htmlArray[btn.tag-100];
    [self.navigationController pushViewController:messageDetailVC animated:NO];
   
    
    
}

#pragma mark ------ 网络请求
-(void)requestModel{
    AFHTTPSessionManager *sessionManage = [AFHTTPSessionManager manager];
    sessionManage.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [sessionManage GET:kMessage parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //  GYRLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSInteger code = [responseObject[@"code"] integerValue];
        NSString *error =responseObject[@"error"];
        if (code == 0&&[error isEqualToString:@""]) {
            NSString *rType = responseObject[@"params"][@"r"];
           NSArray *array = responseObject[@"results"];
          
            for (NSDictionary *dic in array) {
                MessageModel *messModel = [[MessageModel alloc] initWithDictionary:dic rType:rType];
                if (messModel.images != nil) {
                     [self.imageArray addObject:messModel.images];
                }
                if (![messModel.pcId isEqualToString:@""]) {
                    [self.idsArray addObject:messModel.pcId];
                }
                if (messModel.content != nil) {
                    [self.htmlArray addObject:messModel.content];
                }

                [self.topImageArray addObject:messModel];
            }
        }
       [self.tableView reloadData];
        [self configTableViewHeaderView];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"222222222222%@",error);
        
    }];
    
}
-(void)requestListData{

    AFHTTPSessionManager *sessionManage = [AFHTTPSessionManager manager];
    sessionManage.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [sessionManage GET:[NSString stringWithFormat:@"%@page=%ld",kM,_pageCount] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //  GYRLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSInteger code = [responseObject[@"code"] integerValue];
        NSString *error =responseObject[@"error"];
        if (code == 0&&[error isEqualToString:@""]) {
            NSString *rType = responseObject[@"params"][@"r"];
            NSArray *array = responseObject[@"results"];
            if (self.refreshing) {
                if (self.listArray.count>0) {
                    [self.listArray removeAllObjects];
                }
            }
            for (NSDictionary *dic in array) {
                MessageModel *messModel = [[MessageModel alloc] initWithDictionary:dic rType:rType];
                
                [self.listArray addObject:messModel];
                [self.shareUrlArray addObject:messModel.shareUrl];
            }
            [self.tableView tableViewDidFinishedLoading];
            self.tableView.reachedTheEnd = NO;

            [self.tableView reloadData];
            //[self configTableViewHeaderView];
            
        }else {
        
        
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"3333333%@",error);
        
    }];


}
#pragma mark ------ 懒加载

-(PullingRefreshTableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight-70)];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.rowHeight = 110;
        self.tableView.pullingDelegate = self;
        self.tableView.separatorColor = [UIColor lightGrayColor];
        
        [self.view addSubview:self.tableView];
    }
    
    return _tableView;



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
