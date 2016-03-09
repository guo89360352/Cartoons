//
//  PictureDetailViewController.m
//  Cartoon
//
//  Created by scjy on 16/3/9.
//  Copyright © 2016年 郭亚茹. All rights reserved.
//

#import "PictureDetailViewController.h"
#import "MyLayout.h"
#import "MJRefresh.h"
#import "AoiroSoraLayout.h"
#import "CartoonModel.h"
#import "BLImageSize.h"
#import "PictureCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <AFNetworking/AFHTTPSessionManager.h>
@interface PictureDetailViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,AoiroSoraLayoutDelegate>
{

    NSInteger _pageCount;

}
@property (nonatomic, strong) UICollectionView *collectView;
@property (nonatomic, strong) NSMutableArray *listArray;

@property (nonatomic, strong) NSMutableArray *heightArr;

@property (nonatomic, assign) BOOL refreshing;

@end

@implementation PictureDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 10, kScreenWidth/4-10, 40);
    [btn setTitle:@"back" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backToLastVC) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    
    self.listArray = [NSMutableArray new];
    self.heightArr = [NSMutableArray new];
    _pageCount = 1;
    [self requestModel];
    [self refreshingAction];
}
-(void)backToLastVC{

    [self dismissViewControllerAnimated:NO completion:nil];

}
-(void)refreshingAction{

    self.collectView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.refreshing = YES;
        [self.collectView.mj_header beginRefreshing];
        [self.collectView.mj_header endRefreshing];
    }];
    self.collectView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        
        [self.collectView.mj_footer beginRefreshing];
        _pageCount +=1;
        self.refreshing = NO;
        [self requestModel];

        [self.collectView.mj_footer endRefreshing];
           }];

}
-(void)getImageWithURL:(NSString *)url{
   
 CGSize  size = [BLImageSize dowmLoadImageSizeWithURL:url];
        NSInteger itemHeight = size.height * (((self.view.frame.size.width - 20) / 2 / size.width));
        
        NSNumber * number = [NSNumber numberWithInteger:itemHeight];
        
        [self.heightArr addObject:number];

   
    

}
-(UICollectionView *)collectView{
    if (_collectView == nil) {
        AoiroSoraLayout *layout = [[AoiroSoraLayout alloc] init];
        layout.interSpace = 5; // 每个item 的间隔
        layout.edgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        layout.colNum = 2; // 列数;
        layout.delegate = self;
        self.collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
        
        self.collectView.delegate = self;
        self.collectView.dataSource = self;
        self.collectView.backgroundColor = [UIColor clearColor];
        [self.collectView registerClass:[PictureCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [self.view addSubview:self.collectView];

        
    }
    
    
    
    
    return  _collectView;
}
#pragma mark -- 返回每个item的高度
- (CGFloat)itemHeightLayOut:(AoiroSoraLayout *)layOut indexPath:(NSIndexPath *)indexPath
{
    
    if ([self.heightArr[indexPath.row] integerValue] < 0 || !self.heightArr[indexPath.row]) {
        
        return 150;
    }
    else
    {
        NSInteger intger = [self.heightArr[indexPath.row] integerValue];
        return intger;
    }
    
}

#pragma mark -- collectionView 的分组个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark -- item 的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.listArray.count;
}

#pragma mark -- cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PictureCollectionViewCell * cell = (PictureCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.model = self.listArray[indexPath.row];
    
    
    
    // jiazai shibai chongxin jiazai
    CartoonModel * model = self.listArray[indexPath.row];
        [cell.MyImage sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:nil];
    
    //[_hud hide:YES];
    
    return cell;
}

-(void)requestModel{
     NSString *str2 = [self.labelId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *sessionManage = [AFHTTPSessionManager manager];
    sessionManage.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [sessionManage GET:[NSString stringWithFormat:@"%@searchLabel=%@&page=%ld",kPic,str2,_pageCount] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //  GYRLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = responseObject;
        NSArray *array = dic[@"results"];
        if (self.refreshing) {
            if (self.listArray > 0) {
                [self.listArray removeAllObjects];
            }
            
        }
        for (NSDictionary *dict in array) {
            CartoonModel *model = [[CartoonModel alloc] initWithDic:dict];
            [self.listArray addObject:model];
            [self getImageWithURL:model.imageUrl];
        }
        

        [self.collectView reloadData];
        [self.view addSubview:self.collectView];
        
        
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
