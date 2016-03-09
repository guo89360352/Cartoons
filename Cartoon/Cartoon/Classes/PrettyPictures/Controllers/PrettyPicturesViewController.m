//
//  PrettyPicturesViewController.m
//  Cartoon
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 郭亚茹. All rights reserved.
//

#import "PrettyPicturesViewController.h"
#import "MyLayout.h"
#import "CartoonModel.h"
#import "PictureDetailViewController.h"
#import <AFNetworking/AFHTTPSessionManager.h>

@interface PrettyPicturesViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UICollectionView *collectionV;
@property (nonatomic, strong) NSMutableArray *listArray;


@end

@implementation PrettyPicturesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.listArray = [NSMutableArray new];
    self.view.backgroundColor = [UIColor colorWithRed:255/255.0 green:184/255.0 blue:185/255.0 alpha:1];
    [self requestModel];
}
-(UICollectionView *)collectionV{
    if (_collectionV == nil) {
        //创建一个layout布局类
       UICollectionViewFlowLayout  *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置布局方向为垂直流布局（默认垂直方向）
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //设置每个item的大小
       layout.itemSize = CGSizeMake(kScreenWidth/3-10, 55);
               //设置每一行间距
        layout.minimumLineSpacing = 5;
        //设置item的间距
        layout.minimumInteritemSpacing = 2;
        //设置section的间距
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        //设置设置区头区尾的大小
        layout.headerReferenceSize = CGSizeMake(kScreenWidth, 30);
        
        
        //通过一个layout布局创建collectionView
        self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight-90) collectionViewLayout:layout];
        
        
        
        //设置代理
        self.collectionV.delegate = self;
        self.collectionV.dataSource = self;
        self.collectionV.backgroundColor = [UIColor clearColor];
        self.collectionV.translatesAutoresizingMaskIntoConstraints = NO;
        self.collectionV.alwaysBounceVertical = YES;
        //注册item类型
        [self.collectionV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"miss"];
       
        
        
    }

    
    return _collectionV;
    
    
    
}


- (void)selectItemAtIndexPath:(nullable NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(UICollectionViewScrollPosition)scrollPosition{
    
    scrollPosition = UICollectionViewScrollPositionTop;
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return self.listArray.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
        
   
    
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"miss" forIndexPath:indexPath];
    self.textLabel = [[UILabel alloc] initWithFrame:cell.frame];
    self.textLabel.text = self.listArray[indexPath.row];
    self.textLabel.tintColor = [UIColor whiteColor];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    [cell setBackgroundView:self.textLabel];
    cell.backgroundColor = [UIColor colorWithRed:255/255.0 green:154/255.0 blue:143/255.0 alpha:1];
    return cell;

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    PictureDetailViewController *pic = [[PictureDetailViewController alloc] init];
    pic.labelId = self.listArray[indexPath.row];
    [self presentViewController:pic animated:NO completion:nil];

}
-(void)requestModel{
    AFHTTPSessionManager *sessionManage = [AFHTTPSessionManager manager];
    sessionManage.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [sessionManage GET:kPrrttyPic parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //  GYRLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject;
        NSArray *array = dic[@"results"];
        
        if (self.listArray.count > 0) {
            [self.listArray removeAllObjects];
        }
        for (NSString *str in array) {
        
            [self.listArray addObject:str];
            
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
