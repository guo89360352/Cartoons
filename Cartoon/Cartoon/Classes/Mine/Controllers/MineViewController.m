//
//  MineViewController.m
//  Cartoon
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 郭亚茹. All rights reserved.
//

#import "MineViewController.h"
#import <SDWebImage/SDImageCache.h>
#import <BmobSDK/Bmob.h>
#import <MessageUI/MessageUI.h>
#import "ProgressHUD.h"
#import "ShareView.h"
#import "WeiboSDK.h"
#import "LoginViewController.h"
#import "WXApi.h"

@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) ShareView *shareView;
@property (nonatomic, strong) UIButton *headerImageButton;
@property (nonatomic, strong) UILabel *nikeNameLabel;

@property (nonatomic, strong) NSArray *imageArray;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    self.titleArray = [NSMutableArray arrayWithObjects:@"清除缓存",@"用户反馈",@"分享给朋友",@"给我评分",@"当前版本1.0" ,nil];
    self.imageArray = @[@"fenxiang_infor",@"fenxiang_infor",@"fenxiang_infor",@"fenxiang_infor",@"fenxiang_infor"];
    
    
    [self setUpTableViewHeaderView];
    
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    //当页面将要出现的时候重新计算页面的大小
    SDImageCache *cashes = [SDImageCache sharedImageCache];
    
    NSInteger casheSize = [cashes getSize];
    NSString *cacheStr = [NSString stringWithFormat:@"清除图片缓存大小(%.02fM)",(float)casheSize/1024/1024];
    [self.titleArray replaceObjectAtIndex:0 withObject:cacheStr];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    
}
#pragma mark ------- UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdent = @"cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdent];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdent];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.imageView.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.text = self.titleArray[indexPath.row];
    
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
        {
            [ProgressHUD show:@"正在清理中"];
            [self performSelector:@selector(clearImage) withObject:nil afterDelay:1.0];
                    }
            break;
        case 1:
        {
            //发送邮件
            [self sendEmail];
        }
            break;
        case 2:
        {
            [self share];
            }
            break;
        case 3:
        {//评分
            NSString *str = [NSString stringWithFormat:
                             @"itms-apps://itunes.apple.com/app"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
            break;
        case 4:
        {
            [ProgressHUD show:@"O_O"];
            [self performSelector:@selector(checkAppVersion) withObject:nil afterDelay:2.0];
        }
            break;
       default:
            break;
    }
    
}
#pragma mark ------- 自定义方法
-(void)checkAppVersion{
    
    [ProgressHUD showSuccess:@"=3="];
    
}
-(void)share{
    
    self.shareView = [[ShareView alloc] init];
    [self.view addSubview:self.shareView];
    
    
}

-(void)sendEmail{
    Class mailClass = NSClassFromString(@"MFMailComposeViewController");
    if (mailClass == nil) {
        if ([MFMailComposeViewController canSendMail]) {
            
            MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
            picker.mailComposeDelegate = self;
            //设置主题
            [picker setSubject:@"博客园-FlyElephant"];
            
            //设置收件人
            NSArray *toRecipients = [NSArray arrayWithObjects:@"1036956742@qq.com",
                                     nil];
            [picker setToRecipients:toRecipients];
            // 设置邮件发送内容
            NSString *emailBody = @"请留下你宝贵的意见";
            [picker setMessageBody:emailBody isHTML:NO];
            
            //邮件发送的模态窗口
            [self presentViewController:picker animated:NO completion:nil];
            
        }else{
            
            NSLog(@"T_T");
        }
    }else {
        
        NSLog(@"T_T");
    }
    
}

-(void)clearImage{
    [ProgressHUD showSuccess:@"清理成功"];
    
    NSLog(@"%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES));
    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    [imageCache clearDisk];
    [self.titleArray replaceObjectAtIndex:0 withObject:@"清除图片缓存"];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
}


#pragma mark ------ 懒加载
-(UILabel *)nikeNameLabel{
    if (_nikeNameLabel == nil) {
        self.nikeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/3+30, 75, kScreenWidth-200, 60)];
        self.nikeNameLabel.text = @"登陆之后开始卖萌";
        self.nikeNameLabel.textColor = [UIColor whiteColor];
        self.nikeNameLabel.numberOfLines= 0;
        
    }
    return _nikeNameLabel;
    
}

-(UIButton *)headerImageButton{
    
    if (_headerImageButton == nil) {
        self.headerImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.headerImageButton.frame = CGRectMake(20, 40, 130, 130);
        [self.headerImageButton setTitle:@"登陆/注册" forState:UIControlStateNormal];
        [self.headerImageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.headerImageButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        self.headerImageButton.layer.cornerRadius =65;
        [self.headerImageButton setBackgroundColor:[UIColor whiteColor]];
        self.headerImageButton.clipsToBounds = YES;
        
    }
    return _headerImageButton;
    
    
}
-(void)login{
    
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Login" bundle:nil];
    UINavigationController *nav = sb.instantiateInitialViewController;
    [self presentViewController:nav animated:YES completion:nil];
    
    
}



-(void)setUpTableViewHeaderView{
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 210)];
    headView.backgroundColor = [UIColor redColor];
    self.tableView.tableHeaderView = headView;
    [headView addSubview:self.headerImageButton ];
    [headView addSubview:self.nikeNameLabel];
    
    
    
    
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        self.tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-40) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
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
