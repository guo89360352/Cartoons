//
//  MessageDetailViewController.h
//  Cartoon
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 郭亚茹. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageDetailVIew.h"

@interface MessageDetailViewController : UIViewController

@property (nonatomic, strong) NSString *messageId;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, assign) BOOL judg;
@end
