//
//  CartoonsDetailViewController.h
//  Cartoon
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 郭亚茹. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartoonModel.h"

@interface CartoonsDetailViewController : UIViewController
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSString *cartoonsId;

@property (nonatomic, strong) CartoonModel *model;


@property (weak, nonatomic) IBOutlet UIImageView *coverImage;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *gengxinLabel;
@property (weak, nonatomic) IBOutlet UIButton *shouBtn;
@property (weak, nonatomic) IBOutlet UIButton *luBtn;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *muluBtn;
@property (weak, nonatomic) IBOutlet UIButton *pinglunBtn;

@end
