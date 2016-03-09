//
//  CartoonsTwoViewController.m
//  Cartoon
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 郭亚茹. All rights reserved.
//

#import "CartoonsTwoViewController.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "VOSegmentedControl.h"
#import "MJRefresh.h"
#import "CartoonCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CartoonCollectionReusableView.h"
#import "PullingRefreshTableView.h"
#import "CartoonsDetailViewController.h"


@interface CartoonsTwoViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

{

    NSInteger _pageCount;

}

@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, strong) UICollectionView *collectionV;

@property (nonatomic, assign) BOOL refreshing;
@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, strong) VOSegmentedControl *segmentC;

@property (strong, nonatomic) UIScrollView *srollV;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) NSTimer *timer;

@property (strong,nonatomic) UIButton *leftBtn;

@end

@implementation CartoonsTwoViewController
-(void)viewDidAppear:(BOOL)animated{

    self.navigationController.navigationBar.hidden = NO;
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
       self.listArray = [NSMutableArray new];
    _pageCount = 1;
    if (self.cartoonsType == CartoonsTypeList) {
        [self requestCartoonsList];

    }else {
    
        [self requestCartoonsBangdan];
    }
    
    self.collectionV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.refreshing = YES;
        [self.collectionV.mj_header beginRefreshing];
        [self.collectionV.mj_header endRefreshing];
    }];
    self.collectionV.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        
        [self.collectionV.mj_footer beginRefreshing];
        _pageCount +=1;
        self.refreshing = NO;
        [self.collectionV.mj_footer endRefreshing];
        if (self.cartoonsType == CartoonsTypeList) {
            [self requestCartoonsList];
            
        }else {
            
            [self requestCartoonsBangdan];
        }
    }];

}


#pragma mark ------ 懒加载
-(UICollectionView *)collectionV{
    if (_collectionV == nil) {
        //创建一个layout布局类
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置布局方向为垂直流布局（默认垂直方向）
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //设置每个item的大小
//        if (self.cartoons == CartoonsTypeCategory) {
//            layout.itemSize = CGSizeMake(kScreenWidth/3-10, kScreenWidth/3-10);
//        }else{
            layout.itemSize = CGSizeMake(kScreenWidth/3-10, kScreenWidth/2-10);
    //}
        //设置每一行间距
        layout.minimumLineSpacing = 10;
        //设置item的间距
        layout.minimumInteritemSpacing = 5;
        //设置section的间距
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        //设置设置区头区尾的大小
        layout.headerReferenceSize = CGSizeMake(kScreenWidth, 50);
        
        
        //通过一个layout布局创建collectionView
        self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight-70) collectionViewLayout:layout];
        
        
        
        //设置代理
        self.collectionV.delegate = self;
        self.collectionV.dataSource = self;
        self.collectionV.backgroundColor = [UIColor clearColor];
        
        //注册item类型
        [self.collectionV registerClass:[CartoonCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        
        
    }
    
    
    return _collectionV;
    
    
    
}
#pragma mark ------- UICollectionView


- (void)selectItemAtIndexPath:(nullable NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(UICollectionViewScrollPosition)scrollPosition{
    
    scrollPosition = UICollectionViewScrollPositionTop;
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.listArray.count > 0) {
        return self.listArray.count;

    }
    return self.listArray.count;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CartoonCollectionViewCell *cell = (CartoonCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (cell) {
        
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height-20)];
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, cell.frame.size.height-20, cell.frame.size.width, 20)];
    if (self.listArray.count > 0) {
        
    
                CartoonModel *model = self.listArray[indexPath.row];
        [imageV sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:nil];
        textLabel.text = model.title;
        
    }
    
       [cell addSubview:textLabel];
        [cell addSubview:imageV];
    }
    
    
    return cell;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    CartoonsDetailViewController *cartoon=[sb instantiateViewControllerWithIdentifier:@"zhang"];
    
//    CartoonsDetailViewController *detailView = [[CartoonsDetailViewController alloc] init];
    CartoonModel *moel = self.listArray[indexPath.row];
    cartoon.cartoonsId = moel.cartoonsId;
    [self.navigationController pushViewController:cartoon animated:NO];
    
    
}
#pragma mark ----- 加载数据
-(void)requestCartoonsBangdan{
    AFHTTPSessionManager *sessionManage = [AFHTTPSessionManager manager];
    sessionManage.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [sessionManage GET:[NSString stringWithFormat:@"%@&id=%@&page=%ld",kLieiBie,self.cartoonsId,_pageCount] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //  GYRLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject;
        
        NSArray *array = dic[@"results"];
        NSInteger code = [dic[@"code"] integerValue];
        if (code == 0) {
            if (self.refreshing) {
                if (self.listArray > 0) {
                    [self.listArray removeAllObjects];
                }
                
            }
            
            for (NSDictionary *dict in array) {
                CartoonModel *model = [[CartoonModel alloc] initWithDic:dict];
                [self.listArray addObject:model];
            }
        }
        
        [self.collectionV reloadData];
        [self.view addSubview:self.collectionV];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"222222222222%@",error);
        
    }];
    
}



-(void)requestCartoonsList{
    AFHTTPSessionManager *sessionManage = [AFHTTPSessionManager manager];
    sessionManage.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
           [sessionManage GET:[NSString stringWithFormat:@"%@&id=%@&page=%ld",kRenqi,self.cartoonsId,_pageCount] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
               
        //  GYRLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject;
        
        NSArray *array = dic[@"results"];
        NSInteger code = [dic[@"code"] integerValue];
        if (code == 0) {
           
            if (self.refreshing) {
                if (self.listArray > 0) {
                    [self.listArray removeAllObjects];
                }

            }
            for (NSDictionary *dict in array) {
                CartoonModel *model = [[CartoonModel alloc] initWithDic:dict];
                [self.listArray addObject:model];
            }
        }
        
        [self.collectionV reloadData];
        [self.view addSubview:self.collectionV];
        
        
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
