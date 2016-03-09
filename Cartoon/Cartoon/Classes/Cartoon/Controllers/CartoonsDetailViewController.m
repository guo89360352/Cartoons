//
//  CartoonsDetailViewController.m
//  Cartoon
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 郭亚茹. All rights reserved.
//

#import "CartoonsDetailViewController.h"
#import "DetailCollectionViewCell.h"
#import "CartoonCollectionReusableView.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "TwoDetailViewController.h"

#import "CartoonModel.h"

@interface CartoonsDetailViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, strong) NSMutableArray *commentArray;
@property (nonatomic, strong) NSMutableArray *chapterArray;
@property (nonatomic, strong) NSMutableDictionary *detailDic;
@property (nonatomic, strong) UIView *btnV;
@property (assign, nonatomic) BOOL boolValue;
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
    self.commentArray = [NSMutableArray new];
    self.chapterArray = [NSMutableArray new];
    self.boolValue = 0;
    [self requestCartoons];
    [self.luBtn addTarget:self action:@selector(muluAction) forControlEvents:UIControlEventTouchUpInside];
    [self.pinglunBtn addTarget:self action:@selector(pinglunAction) forControlEvents:UIControlEventTouchUpInside];
    

    
}
-(UICollectionView *)collectionView{
    
    if (_collectionView == nil) {
        //创建一个layout布局类
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置布局方向为垂直流布局（默认垂直方向）
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //设置每个item的大小
        layout.itemSize = CGSizeMake(kScreenWidth,100);
        //设置每一行间距
        layout.minimumLineSpacing = 5;
        //设置item的间距
        layout.minimumInteritemSpacing = 2;
        //设置section的间距
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        //设置设置区头区尾的大小
      //  layout.headerReferenceSize = CGSizeMake(kScreenWidth, 10);
//        layout.footerReferenceSize = CGSizeMake(kScreenWidth, 10);
        //通过一个layout布局创建collectionView
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kScreenHeight/2+50, kScreenWidth, kScreenHeight/2+50) collectionViewLayout:layout];
        //设置代理
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.backgroundColor = [UIColor clearColor];
        
        //注册item类型
        [self.collectionView registerClass:[DetailCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        

     
        
    }
    
    
    return _collectionView;
    
}
-(void)muluAction{
        self.btnV = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight/2+50, kScreenWidth, kScreenHeight/2-50)];
    [self.collectionView removeFromSuperview];
    
    for (int i = 1,j = 1; i <= [self.model.totalChapterCount intValue]&&j <= [self.model.totalChapterCount intValue]; i ++,j++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(15*j+60*(j-1), 10*i+30*(i-1), 60, 30);
        btn.tag = i;
            [btn setTitle:[NSString stringWithFormat:@"%d话",j] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.btnV addSubview:btn];
            btn.backgroundColor = [UIColor redColor];
        }
        
   
    [self.view addSubview:self.btnV];
    self.btnV.backgroundColor = [UIColor yellowColor];

}
-(void)pinglunAction{
    [self.btnV removeFromSuperview];
    [self requestCartoon];
    

}
-(void)selectBtnAction:(UIButton *)btn{
    TwoDetailViewController *two = [[TwoDetailViewController alloc] init];
    NSLog(@"%@",self.chapterArray);
    if (self.chapterArray.count > 0) {
        CartoonModel *model = self.chapterArray[btn.tag-1];
        two.capterId = model.cartoonsId;

    }
       [self.navigationController pushViewController:two animated:NO];

}
#pragma mark -------  UICollectionViewDataSource


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
    
    DetailCollectionViewCell *cell = (DetailCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    
    
            CartoonModel *model = self.commentArray[indexPath.row];
            
            CartoonModel *carModel = self.listArray[indexPath.row];
            [cell.touImageV sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:nil];
//            cell.authorLabel.text = @"shdhasdja";
//    cell.authorLabel.textColor=[UIColor blackColor];
//    cell.authorLabel.backgroundColor=[UIColor redColor];
//
            cell.contentLabel.text = carModel.content;
            cell.timeLabel.textColor=[UIColor whiteColor];
           cell.timeLabel.text = carModel.creatTime;
//            NSLog(@"%@",model);
//            NSLog(@"%@",carModel);


            
    


  
    return cell;
}
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    
//    TwoDetailViewController *two = [[TwoDetailViewController alloc] init];
//    CartoonModel *model= self.listArray[indexPath.row];
//    two.capterId = model.cartoonsId;
//    [self.navigationController pushViewController:two animated:NO];
//    
//
//
//}

#pragma mark ----- 加载数据
-(void)requestCartoons{
    AFHTTPSessionManager *sessionManage = [AFHTTPSessionManager manager];
    sessionManage.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [sessionManage GET:[NSString stringWithFormat:@"%@&id=%@",kCartoons,self.cartoonsId] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //  GYRLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
        
        NSDictionary *dic = responseObject;
        NSDictionary *dict = dic[@"results"];
        NSArray *arr = dict[@"cartoonChapterList"];
        if (self.chapterArray.count > 0) {
            [self.chapterArray removeAllObjects];
        }
        for (NSDictionary *dico in arr) {
            CartoonModel *chapterModel = [[CartoonModel alloc] initWithDic:dico];
            [self.chapterArray addObject:chapterModel];
           
        }
        NSLog(@"%ld",self.chapterArray.count);
      self.model = [[CartoonModel alloc] initWithDic:dict];
        self.timeLabel.text = self.model.name;
        self.contentLabel.text = self.model.introduction;
        self.authorLabel.text = [NSString stringWithFormat:@"作者:%@",self.model.author];
        self.timeLabel.text = self.model.updateValue;
        self.gengxinLabel.text = [NSString stringWithFormat:@"最近更新时间:%@",self.model.creatTime];
        
        [self.coverImage sd_setImageWithURL:[NSURL URLWithString:self.model.imageUrl] placeholderImage:nil];
        
           //   [self.view addSubview:self.collectionView];
        
        [self.collectionView reloadData];
        [self muluAction];

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
        if (self.commentArray.count > 0) {
            [self.commentArray removeAllObjects];
        }

        NSDictionary *dic = responseObject;
        NSDictionary *dict = dic[@"results"];
        NSArray *array = dict[@"commentList"];
        NSArray *arr = dict[@"cartoonChapterList"];
//        if (self.chapterArray.count > 0) {
//            [self.chapterArray removeAllObjects];
//        }
//        for (NSDictionary *dico in arr) {
//            CartoonModel *chapterModel = [[CartoonModel alloc] initWithDic:dico];
//            [self.chapterArray addObject:chapterModel];
//            NSLog( @"%@",chapterModel);
//        }
        
        if (self.listArray.count > 0) {
            [self.listArray removeAllObjects];
        }
        for (NSDictionary *dicm in array) {
            
            CartoonModel *model = [[CartoonModel alloc] initWithDic:dicm];
            [self.listArray addObject:model];
            
        }

        for (NSDictionary *ddd in array) {
           NSDictionary *user= ddd[@"userIDInfo"];
            CartoonModel *Carmodel = [[CartoonModel alloc] initWithDic:user];
            [self.commentArray addObject:Carmodel];
        }
        [self.collectionView reloadData];
        [self.view addSubview:self.collectionView];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"222222222222%@",error);
        
    }];
    
}




////http://api.playsm.com/index.php?id=350&r=cartoonSet%2Fdetail&
//-(void)loadDetailView:(NSString *)url{
//    NSString *urlStr = url;
//    NSString *httpUrl = @"http://api.playsm.com/index.php?&r=cartoonSet%2Fdetail&";
//    if (![url hasPrefix:@"http://"]) {
//        urlStr = [NSString stringWithFormat:@"%@id=
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
