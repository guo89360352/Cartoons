//
//  TwoDetailViewController.m
//  Cartoon
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 郭亚茹. All rights reserved.
//

#import "TwoDetailViewController.h"
#import "CartoonModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <AFNetworking/AFHTTPSessionManager.h>

@interface TwoDetailViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollV;
@property (nonatomic, strong) NSMutableArray *listArray;

@end

@implementation TwoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.listArray = [NSMutableArray new];
    // Do any additional setup after loading the view.

    
    [self requestCartoons];
    
    
}
-(UIScrollView *)scrollV{
    if (_scrollV == nil) {
        
        self.scrollV = [[UIScrollView alloc] initWithFrame:self.view.frame];

        self.scrollV.scrollsToTop = YES;
    
        
        //contentSize大于scrollView的frame时候就可以滑动，如果只有宽度大于scrollView的宽度那么只能左右滑动，如果只有高度大于scrollView的高度那么只能上下滑动
        self.scrollV.contentSize = CGSizeMake(kScreenWidth, kScreenHeight*self.listArray.count);
        //是否以整屏滑动，默认是NO不整屏滑动
        self.scrollV.pagingEnabled = YES;
        //遇到边界是否可以弹回，默认是滑动到边界还可以继续滑动，但是松手的时候会自动弹回，如果NO滑动边界就停止，边界就无法滑动
        self.scrollV.bounces = NO;
        //是否可以滑动,默认为Yes,No 是不可以滑动
        self.scrollV.scrollEnabled = YES;
        //是否显示水平方向的滚动条
        self.scrollV.showsHorizontalScrollIndicator = NO;
        //是否显示垂直方向的滚动条
        self.scrollV.showsVerticalScrollIndicator = YES;
        //内容的大小如果小于等于scrollView的时候仍然可以左右滑动边界
        self.scrollV.alwaysBounceHorizontal = YES;
//        self.scrollV.alwaysBounceVertical = YES;
        //最小缩小比例
//        self.scrollV.minimumZoomScale = 0.5;
//        //最大放大比例
//        self.scrollV.maximumZoomScale = 2.0;
        //设置代理
        self.scrollV.delegate = self;
        
        [self loadDetailView];
}
    return _scrollV;
}

-(void)requestCartoons{
    AFHTTPSessionManager *sessionManage = [AFHTTPSessionManager manager];
    sessionManage.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [sessionManage GET:[NSString stringWithFormat:@"%@&chapterId=%@",kCapter,self.capterId] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //  GYRLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *dic = responseObject[@"results"];
        if (self.listArray.count > 0) {
            [self.listArray removeAllObjects];
        }
        for (NSDictionary *dict in dic) {
            CartoonModel *model = [[CartoonModel alloc] initWithDic:dict];
            [self.listArray addObject:model];
            
        }
        [self.view addSubview:self.scrollV];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"222222222222%@",error);
        
    }];
    
}


-(void)loadDetailView{
   
    for (int i = 0; i < self.listArray.count; i++) {
        CartoonModel *model = self.listArray[i];

        UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kScreenHeight*i, [model.imgWidth intValue], [model.imgHeight intValue])];
        scroll.minimumZoomScale = 0.5;
        scroll.maximumZoomScale = 2.0;
        //设置代理
        scroll.delegate = self;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:nil];
        imageView.tag = 110;
        [scroll addSubview:imageView];
        
        //滑动到顶部
        [self.scrollV addSubview:scroll];
    }

}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
//    //第一步获取scrollView页面的宽度
//    CGFloat pageWidth = self.scrollV.frame.size.width;
//    //获取scrollView停止时候的偏移量
//    CGPoint  offset = self.scrollV.contentOffset;
//    //第三步；通过偏移量和页面宽度计算出当前页面
//    NSInteger pageNum = offset.x / pageWidth;
//    //第四步：修改pageControl的当前页
    
    
    NSLog(@"1");
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
