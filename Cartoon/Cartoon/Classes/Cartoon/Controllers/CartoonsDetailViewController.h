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



@end
