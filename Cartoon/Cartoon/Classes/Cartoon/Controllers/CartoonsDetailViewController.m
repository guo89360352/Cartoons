//
//  CartoonsDetailViewController.m
//  Cartoon
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 郭亚茹. All rights reserved.
//

#import "CartoonsDetailViewController.h"
#import "CartoonCollectionReusableView.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "TwoDetailViewController.h"
#import "CartoonModel.h"

@interface CartoonsDetailViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, strong) NSMutableDictionary *detailDic;

@end

@implementation CartoonsDetailViewController
-(void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBar.hidden = NO;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.listArray = [NSMutableArray new];
    self.detailDic = [NSMutableDictionary new];
    [self requestCartoons];
    [self requestCartoon];
}

-(UICollectionView *)collectionView{
    
    if (_collectionView == nil) {
        //创建一个layout布局类
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置布局方向为垂直流布局（默认垂直方向）
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //设置每个item的大小
        layout.itemSize = CGSizeMake(60, 30);
        //设置每一行间距
        layout.minimumLineSpacing = 5;
        //设置item的间距
        layout.minimumInteritemSpacing = 2;
        //设置section的间距
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        //设置设置区头区尾的大小
        layout.headerReferenceSize = CGSizeMake(kScreenWidth, kScreenHeight/3+30);
        layout.footerReferenceSize = CGSizeMake(kScreenWidth, 10);
        //通过一个layout布局创建collectionView
        self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
        //设置代理
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.backgroundColor = [UIColor clearColor];
        
        //注册item类型
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"item"];
        
        [self.collectionView registerNib:[UINib nibWithNibName:@"CartoonCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        
        
        [self.view addSubview:self.collectionView];

     
        
    }
    
    
    return _collectionView;
    
}


#pragma mark -------  UICollectionViewDataSource
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
   
        CartoonCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    headerView.titleLabel.text = self.model.name;
    headerView.timeLabel.text = self.model.updateValue;
    headerView.gengxinLabel.text = [NSString stringWithFormat:@"最近更新时间:%@",self.model.creatTime];
    [headerView.caverImage sd_setImageWithURL:[NSURL URLWithString:self.model.imageUrl] placeholderImage:nil];
    headerView.author.text = [NSString stringWithFormat:@"作者:%@",self.model.author];
    headerView.introductionLabel.text = self.model.introduction;
    
    return headerView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.listArray.count > 0) {
        return self.listArray.count;

    }
    return self.listArray.count;
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1 ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    if (cell) {
//        cell.frame = CGRectMake(0, kScreenWidth+10, 60, 30);
        UILabel *label = [[UILabel alloc] init];
//label.frame = cell.frame;
        if (self.listArray.count > 0) {
            label.text = [NSString stringWithFormat:@"%ld话",(long)indexPath.row];
            
        }
        cell.backgroundColor = [UIColor lightGrayColor];
        
        [cell addSubview:label];
    }
  
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    
    TwoDetailViewController *two = [[TwoDetailViewController alloc] init];
    CartoonModel *model= self.listArray[indexPath.row];
    two.capterId = model.cartoonsId;
    [self.navigationController pushViewController:two animated:NO];
    


}

#pragma mark ----- 加载数据
-(void)requestCartoons{
    AFHTTPSessionManager *sessionManage = [AFHTTPSessionManager manager];
    sessionManage.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [sessionManage GET:[NSString stringWithFormat:@"%@&id=%@",kCartoons,self.cartoonsId] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //  GYRLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
        
        NSDictionary *dic = responseObject;
        NSDictionary *dict = dic[@"results"];
      self.model = [[CartoonModel alloc] initWithDic:dict];
        
//        for (NSDictionary *dicm in self.model.cartoonChapterList) {
//            if (self.listArray.count > 0) {
//                [self.listArray removeAllObjects];
//            }
//                
//            CartoonModel *model = [[CartoonModel alloc] initWithDic:dicm];
//            [self.listArray addObject:model];
//       
//        }
        
        [self.collectionView reloadData];
        
   
       // [self requestCartoon];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"222222222222%@",error);
        
    }];
    
}

-(void)requestCartoon{
    AFHTTPSessionManager *sessionManage = [AFHTTPSessionManager manager];
    sessionManage.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    // NSString *r = @"recommend/getUserRecommendList";
    [sessionManage GET:[NSString stringWithFormat:@"%@&id=%@",kCartoons,self.cartoonsId] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //  GYRLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject;
        NSDictionary *dict = dic[@"results"];
        NSArray *array = dict[@"cartoonChapterList"];
        if (self.listArray.count > 0) {
            [self.listArray removeAllObjects];
        }

        for (NSDictionary *dicm in array) {
            
            CartoonModel *model = [[CartoonModel alloc] initWithDic:dicm];
            [self.listArray addObject:model];
            
        }
        
        [self.collectionView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"222222222222%@",error);
        
    }];
    
}




////http://api.playsm.com/index.php?id=350&r=cartoonSet%2Fdetail&
//-(void)loadDetailView:(NSString *)url{
//    NSString *urlStr = url;
//    NSString *httpUrl = @"http://api.playsm.com/index.php?&r=cartoonSet%2Fdetail&";
//    if (![url hasPrefix:@"http://"]) {
//        urlStr = [NSString stringWithFormat:@"%@id=%@",httpUrl,url];
//        NSLog(@"%@",urlStr);
//        
//    }
//    NSURL *urlStr1 = [NSURL URLWithString:urlStr];
//    NSURLRequest *request = [NSURLRequest requestWithURL:urlStr1];
//    [self.webView loadRequest:request];
//
//    
//}
//-(UIWebView *)webView{
//    
//    if (_webView == nil) {
//        self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
//        self.webView.backgroundColor = [UIColor clearColor];
//        self.webView.opaque = NO;
//        self.webView.dataDetectorTypes = UIDataDetectorTypeAll;
//        [self.view addSubview:self.webView];
//    }
//    return _webView;
//    
//}

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
