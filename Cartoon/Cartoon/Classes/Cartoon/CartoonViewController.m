
//
//  CartoonViewController.m
//  Cartoon
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 郭亚茹. All rights reserved.
//

#import "CartoonViewController.h"
#import "VOSegmentedControl.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CartoonCollectionReusableView.h"
#import "PullingRefreshTableView.h"
#import "CartoonModel.h"
#import "MJRefresh.h"
#import "CartoonsDetailViewController.h"
#import "CartoonsTwoViewController.h"
#import "CartoonCollectionViewCell.h"
#import "CartoonsCollectionViewCell.h"

#import <AFNetworking/AFHTTPSessionManager.h>

@interface CartoonViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *allArray;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, strong) NSMutableArray *bangArray;

@property (nonatomic, strong) NSMutableArray *listArray1;
@property (nonatomic, strong) NSMutableArray *listArray2;
@property (nonatomic, strong) NSMutableArray *listArray3;
@property (nonatomic, strong) NSMutableArray *listArray4;

@property (nonatomic, strong) NSMutableArray *bangArray1;
@property (nonatomic, strong) NSMutableArray *bangArray2;
@property (nonatomic, strong) NSMutableArray *bangArray3;
@property (nonatomic, strong) NSMutableArray *bangArray4;
@property (nonatomic, strong) NSMutableArray *bangArray5;

@property (nonatomic, strong) NSMutableArray *leibieArray;

@property (nonatomic, strong) UIView *HeaderView;
@property (nonatomic, strong) UICollectionView *collectionV;
@property (nonatomic, strong)  UICollectionViewFlowLayout *layout;

@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, strong) VOSegmentedControl *segmentC;

@property (strong, nonatomic) UIScrollView *srollV;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) NSTimer *timer;

@property (assign, nonatomic) NSInteger cartoons;

@property (assign, nonatomic) BOOL refreshing;

@property (strong, nonatomic) UIView *recommintView;
@property (strong, nonatomic) UIView *listView;
@property (strong, nonatomic) UIView *LeibieView;

@property (strong, nonatomic) UIImageView *imageV;
@property (strong, nonatomic) UILabel *textLabel;


@end

@implementation CartoonViewController
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/3-10, kScreenWidth/2-30)];
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kScreenWidth/2-30, kScreenWidth/2, 30)];
    
    
    [self.view addSubview:self.segmentC];
    //    [self requestCartoon];
    
    //    [self requestModel];
    self.allArray = [NSMutableArray new];
    self.listArray = [NSMutableArray new];
    
    self.listArray1 = [NSMutableArray new];
    self.listArray2 = [NSMutableArray new];
    self.listArray3 = [NSMutableArray new];
    self.listArray4 = [NSMutableArray new];
    self.imageArray = [NSMutableArray new];
    // [self requestCartoon];
    
    self.bangArray = [NSMutableArray new];
    self.bangArray1 = [NSMutableArray new];
    self.bangArray2 = [NSMutableArray new];
    self.bangArray3 = [NSMutableArray new];
    self.bangArray4 = [NSMutableArray new];
    self.bangArray5 = [NSMutableArray new];
    
    self.leibieArray = [NSMutableArray new];
    [self RefreshingCustum];
    
    
}
-(void)RefreshingCustum{
    
    self.collectionV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.collectionV.mj_header beginRefreshing];
        [self.collectionV.mj_header endRefreshing];
    }];
    self.collectionV.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [self.collectionV.mj_footer beginRefreshing];
        [self.collectionV.mj_footer endRefreshing];
    }];
    
    
    
}

#pragma mark ------ 懒加载
-(UIView *)LeibieView{
    
    if (_LeibieView == nil) {
        self.LeibieView = [[UIView alloc] initWithFrame:self.view.frame];
        self.LeibieView.tag = 3;
        
    }
    return _LeibieView;
}
-(UIView *)recommintView{
    
    if (_recommintView) {
        self.recommintView = [[UIView alloc] initWithFrame:self.view.frame];
        self.recommintView.tag = 1;
    }
    return  _recommintView;
}
-(UIView *)listView{
    
    
    if (_listView) {
        self.listView = [[UIView alloc] initWithFrame:self.view.frame];
        self.listView.tag = 3;
    }
    return  _listView;
    
}
-(UICollectionView *)collectionV{
    if (_collectionV == nil) {
        //创建一个layout布局类
        self.layout = [[UICollectionViewFlowLayout alloc] init];
        //设置布局方向为垂直流布局（默认垂直方向）
        self.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //设置每个item的大小
//        if (self.cartoons == CartoonsTypeList) {
            self.layout.itemSize = CGSizeMake(120, 191);
//        }else{
//            self.layout.itemSize = CGSizeMake(kScreenWidth/3-10, kScreenWidth/2);
//        }
        //设置每一行间距
        self.layout.minimumLineSpacing = 5;
        //设置item的间距
        self.layout.minimumInteritemSpacing = 2;
        //设置section的间距
        self.layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        //设置设置区头区尾的大小
        self.layout.headerReferenceSize = CGSizeMake(kScreenWidth, 30);
        
        
        //通过一个layout布局创建collectionView
        self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight-70) collectionViewLayout:self.layout];
        
        
        
        //设置代理
        self.collectionV.delegate = self;
        self.collectionV.dataSource = self;
        self.collectionV.backgroundColor = [UIColor clearColor];
        self.collectionV.translatesAutoresizingMaskIntoConstraints = NO;
        self.collectionV.alwaysBounceVertical = YES;
        //注册item类型
        [self.collectionV registerClass:[CartoonsCollectionViewCell class] forCellWithReuseIdentifier:@"miss"];
        
        //        [self.collectionV registerNib:[UINib nibWithNibName:@"CartoonCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        //
        //
        //
        //        [self.collectionV registerClass:[CartoonCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
        
        
    }
    
    
    return _collectionV;
    
    
    
}
//#pragma mark ------- UICollectionView
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    CartoonCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
////    UILabel *textLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, headerView.frame.size.width, 60)];
////
//
////    if (indexPath.section == 0) {
////         textLable.text = @"最近最新";
////    }else if (indexPath.section == 1){
////
////        textLable.text = @"小编推荐";
////    } else if (indexPath.section == 2){
////
////        textLable.text = @"每周收藏";
////    }else if (indexPath.section == 3){
////
////        textLable.text = @"最新上架";
////    }
////    [headerView addSubview:textLable];
//
//    [self configTableViewHeaderView];
//    [headerView addSubview:self.HeaderView];
//
//    return headerView;
//}


- (void)selectItemAtIndexPath:(nullable NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(UICollectionViewScrollPosition)scrollPosition{
    
    scrollPosition = UICollectionViewScrollPositionTop;
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    NSMutableArray *array = [NSMutableArray new];
    if (self.cartoons == CartoonsTypeList) {
        if (self.listArray.count> 0) {
            return self.listArray.count;
            
        }
        return self.listArray.count;
        
        
    } else if (self.cartoons == CartoonsTypeCategory){
        if (self.leibieArray.count > 0) {
            return self.leibieArray.count;
            
        }
    }else{
        switch (section) {
            case 0:
            {
                if (self.allArray[section] > 0) {
                    array  = self.allArray[section];
                    
                }
            }
                break;
            case 1:
            {
                if (self.allArray[section] > 0) {
                    array  = self.allArray[section];
                    
                }
                
            }
                break;
            case 2:
            {
                if (self.allArray[section] > 0) {
                    array  = self.allArray[section];
                    
                }
                
            }
                break;
            case 3:
            {
                if (self.allArray[section] > 0) {
                    array  = self.allArray[section];
                    
                }
                
            }
                break;
                
            default:
                break;
        }
        
        
    }
    return array.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (self.cartoons == CartoonsTypeList) {
        return 1;
    } else if (self.cartoons == CartoonsTypeCategory){
        return 1;
        
    }else{
        if (self.allArray.count> 0) {
            return self.allArray.count;
            
        }
        NSLog(@"%ld",self.allArray.count);
        return self.allArray.count;
        
    }
    
    
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
//    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, 10)];
//
//    if (indexPath.section == 0) {
//        titlelabel.text = @"最近最新";
//    }else
//    if (indexPath.section == 1) {
//        titlelabel.text = @"小编推荐";
//    }else
//    if (indexPath.section == 2) {
//        titlelabel.text = @"每周收藏";
//    }else
//    if (indexPath.section == 3) {
//        titlelabel.text = @"最新上架";
//    }
//
//    [headView addSubview:titlelabel];
//    return headView;
//
//}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    CartoonsCollectionViewCell *cell = (CartoonsCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"miss" forIndexPath:indexPath];
    if (cell) {
        if (self.cartoons == CartoonsTypeList) {
            CartoonModel *model = self.listArray[indexPath.row];
            [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:nil];
//            cell.imageV.frame = CGRectMake(0, 0, 123, self.layout.itemSize.height-30);
            cell.textLabel.text = model.name;
//              cell.imageV.frame = CGRectMake(0, self.layout.itemSize.height-30, 123,30);
        }else if (self.cartoons == CartoonsTypeCategory){
            if (self.leibieArray.count > 0) {
                CartoonModel *model = self.leibieArray[indexPath.row];
                cell.imageV.layer.masksToBounds = YES;
                cell.imageV.layer.cornerRadius = 40.0;
                [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:nil];
                cell.textLabel.text = model.name;
                
            }
            
        }else{
            if (self.allArray.count > 0) {
                
                CartoonModel *model = self.allArray[indexPath.section][indexPath.row];
                [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:nil];
                
                cell.textLabel.text = model.name;
                
            }
        }
        
    }
    return cell;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    CartoonsDetailViewController *cartoon=[sb instantiateViewControllerWithIdentifier:@"zhang"];
    
    if (self.cartoons == CartoonsTypeList||self.cartoons == CartoonsTypeCategory) {
        CartoonsTwoViewController *twoCar = [[CartoonsTwoViewController alloc] init];
        if(self.cartoons == CartoonsTypeList){
            if (self.listArray .count > 0) {
                CartoonModel *model = self.listArray[indexPath.row];
                twoCar.cartoonsId = model.cartoonsId;
                twoCar.cartoonsType = self.cartoons;
            }
            
        }else{
            if (self.leibieArray.count > 0) {
                
                CartoonModel *model = self.leibieArray[indexPath.row];
                twoCar.cartoonsId = model.cartoonsId;
                twoCar.cartoonsType = self.cartoons;
            }
        }
        [self.navigationController pushViewController:twoCar animated:NO];
    }else{
        
        if (self.allArray.count > 0) {
            CartoonModel *model = self.allArray[indexPath.section][indexPath.row];
            NSString *str = model.cartoonsId;
            cartoon.cartoonsId = str;
        }
        
        
        
        
        [self.navigationController pushViewController:cartoon animated:NO];
        
    }
    
    
    
}


#pragma mark   -------   首页轮播图
-(void)configTableViewHeaderView{
    self.HeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth, 200)];
    
    self.srollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 186)];
    
    self.srollV.contentSize = CGSizeMake(self.imageArray.count * kScreenWidth, 186);
    self.srollV.pagingEnabled = YES;
    self.srollV.showsHorizontalScrollIndicator = NO;
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 82, kScreenWidth, 186)];
    self.pageControl.numberOfPages = self.imageArray.count;
    self.pageControl.currentPageIndicatorTintColor = [UIColor cyanColor];
    [self.pageControl addTarget:self action:@selector(pageSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.listArray > 0 && self.imageArray > 0 ) {
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
    [self.HeaderView addSubview:self.srollV];
    [self.HeaderView addSubview:self.pageControl];
    
}
-(void)touchAdvertisement:(UIButton *)btn{
    
    
    
}

-(VOSegmentedControl *)segmentC{
    
    if (_segmentC == nil) {
        self.segmentC = [[VOSegmentedControl alloc] initWithSegments:@[@{VOSegmentText:@"推荐"},@{VOSegmentText:@"榜单"},@{VOSegmentText:@"类别"}]];
        self.segmentC.tag = 4;
        self.segmentC.contentStyle = VOContentStyleTextAlone;
        self.segmentC.indicatorStyle = VOSegCtrlIndicatorStyleBottomLine;
        self.segmentC.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.segmentC.selectedBackgroundColor =   self.segmentC.backgroundColor;
        self.segmentC.allowNoSelection = NO;
        self.segmentC.frame = CGRectMake(0, 10, kScreenWidth, 40);
        self.segmentC.indicatorThickness = 4;
        self.segmentC.selectedSegmentIndex = 0;
        [self.view addSubview:self.segmentC];
        
        [  self.segmentC setIndexChangeBlock:^(NSInteger index) {
            
        }];
        
        [  self.segmentC addTarget:self action:@selector(segmentCtrlValuechange:) forControlEvents:UIControlEventValueChanged];
        
    }
    [self requestCartoon];
    
    return _segmentC;
    
    
}
- (IBAction)segmentCtrlValuechange: (VOSegmentedControl *)segmentCtrl{
    
    if (segmentCtrl.selectedSegmentIndex == CartoonsTypeRecommend) {
        
        self.cartoons = segmentCtrl.selectedSegmentIndex;
        [self requestCartoon];
    }
    if (segmentCtrl.selectedSegmentIndex == CartoonsTypeCategory) {
        self.cartoons = segmentCtrl.selectedSegmentIndex;
        
        [self requestLeiBie];
        
    }
    if (segmentCtrl.selectedSegmentIndex == CartoonsTypeList) {
        self.cartoons = segmentCtrl.selectedSegmentIndex;
        
        [self requestBangDan];
        
        
    }
    
}
-(void)removeView{
    
}

#pragma mark ---- 加载数据
-(void)loadData{
    
    
    
    if (self.allArray > 0) {
        [self.allArray removeAllObjects];
    }
    [self.allArray addObject:self.listArray1];
    [self.allArray addObject:self.listArray2];
    [self.allArray addObject:self.listArray3];
    [self.allArray addObject:self.listArray4];
    
    
    //    [self.recommintView addSubview:self.collectionV];
    [self.view addSubview:self.collectionV];
    
}
-(void)requestBangDan{
    AFHTTPSessionManager *sessionManage = [AFHTTPSessionManager manager];
    sessionManage.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *r = @"cartoonBillBoard%2Flist";
    
    [sessionManage GET:[NSString stringWithFormat:@"%@&r=%@&size=%@",kCartoon,r,@(10)] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //  GYRLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject;
        NSArray *array = dic[@"results"];
        NSInteger code = [dic[@"code"] integerValue];
        if (code == 0) {
            if (self.listArray.count > 0) {
                [self.listArray removeAllObjects];
            }
            for (NSDictionary *dict in array) {
                CartoonModel *model = [[CartoonModel alloc] initWithDic:dict];
                [self.listArray addObject:model];
            }
        }
        [self.collectionV reloadData];
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"222222222222%@",error);
        
    }];
    
}


-(void)requestLeiBie{
    AFHTTPSessionManager *sessionManage = [AFHTTPSessionManager manager];
    sessionManage.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *r = @"cartoonCategory%2Flist";
    
    [sessionManage GET:[NSString stringWithFormat:@"%@&r=%@&size=%@",kCartoon,r,@(999)] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //  GYRLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject;
        NSArray *array = dic[@"results"];
        NSInteger code = [dic[@"code"] integerValue];
        if (code == 0) {
            if (self.leibieArray.count > 0) {
                [self.leibieArray removeAllObjects];
            }
            for (NSDictionary *dict in array) {
                CartoonModel *model = [[CartoonModel alloc] initWithDic:dict];
                [self.leibieArray addObject:model];
            }
        }
        
        [self.collectionV reloadData];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"222222222222%@",error);
        
    }];
    
}


#pragma mark ----- 广告
-(void)requestModel{
    AFHTTPSessionManager *sessionManage = [AFHTTPSessionManager manager];
    sessionManage.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    // NSString *r = @"recommend/getUserRecommendList";
    [sessionManage GET:kAd parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //  GYRLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = responseObject;
        NSArray *array = dic[@"results"];
        NSInteger code = [dic[@"code"] integerValue];
        if (code == 0) {
            for (NSDictionary *dict in array) {
                CartoonModel *model = [[CartoonModel alloc] initWithDic:dict];
                [self.listArray addObject:model];
                [self.imageArray addObject:model.imageUrl];
            }
        }
        
        [self.collectionV reloadData];
        [self loadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"222222222222%@",error);
        
    }];
    
}

#pragma mark ----- 推荐

-(void)requestCartoon{
    AFHTTPSessionManager *sessionManage = [AFHTTPSessionManager manager];
    sessionManage.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    // NSString *r = @"recommend/getUserRecommendList";
    [sessionManage GET:kZuijin parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //  GYRLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject;
        NSArray *array = dic[@"results"];
        NSInteger code = [dic[@"code"] integerValue];
        if (code == 0) {
            if (self.listArray1 > 0) {
                [self.listArray1 removeAllObjects];
            }
            
            for (NSDictionary *dict in array) {
                CartoonModel *model = [[CartoonModel alloc] initWithDic:dict];
                [self.listArray1 addObject:model];
                
                
            }
        }
        [self.collectionV reloadData];
        [self requestCartoon2];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"222222222222%@",error);
        
    }];
    
}
-(void)requestCartoon2{
    AFHTTPSessionManager *sessionManage = [AFHTTPSessionManager manager];
    sessionManage.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    // NSString *r = @"recommend/getUserRecommendList";
    [sessionManage GET:kXiaobian parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //  GYRLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject;
        NSArray *array = dic[@"results"];
        NSInteger code = [dic[@"code"] integerValue];
        if (code == 0) {
            if (self.listArray2 > 0) {
                [self.listArray2 removeAllObjects];
            }
            
            for (NSDictionary *dict in array) {
                CartoonModel *model = [[CartoonModel alloc] initWithDic:dict];
                [self.listArray2 addObject:model];
                
            }
        }
        
        [self.collectionV reloadData];
        [self requestCartoon3];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"222222222222%@",error);
        
    }];
    
}
-(void)requestCartoon3{
    AFHTTPSessionManager *sessionManage = [AFHTTPSessionManager manager];
    sessionManage.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    // NSString *r = @"recommend/getUserRecommendList";
    [sessionManage GET:kMeizhou parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //  GYRLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject;
        NSArray *array = dic[@"results"];
        NSInteger code = [dic[@"code"] integerValue];
        if (code == 0) {
            if (self.listArray3 > 0) {
                [self.listArray3 removeAllObjects];
            }
            
            for (NSDictionary *dict in array) {
                CartoonModel *model = [[CartoonModel alloc] initWithDic:dict];
                [self.listArray3 addObject:model];
                
            }
        }
        
        [self.collectionV reloadData];
        [self requestCartoon4];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"222222222222%@",error);
        
    }];
    
}
-(void)requestCartoon4{
    AFHTTPSessionManager *sessionManage = [AFHTTPSessionManager manager];
    sessionManage.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    // NSString *r = @"recommend/getUserRecommendList";
    [sessionManage GET:kShangjia parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //  GYRLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject;
        NSArray *array = dic[@"results"];
        NSInteger code = [dic[@"code"] integerValue];
        if (code == 0) {
            if (self.listArray4 > 0) {
                [self.listArray4 removeAllObjects];
            }
            for (NSDictionary *dict in array) {
                CartoonModel *model = [[CartoonModel alloc] initWithDic:dict];
                [self.listArray4 addObject:model];
                
            }
        }
        
        
        [self.collectionV reloadData];
        [self loadData];
        
        
        
        
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
