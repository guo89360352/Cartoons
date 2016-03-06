//
//  CartoonsDetailViewController.m
//  Cartoon
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 郭亚茹. All rights reserved.
//

#import "CartoonsDetailViewController.h"

@interface CartoonsDetailViewController ()

@end

@implementation CartoonsDetailViewController
-(void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBar.hidden = NO;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadDetailView:self.cartoonsId];
    
}
//http://api.playsm.com/index.php?id=350&r=cartoonSet%2Fdetail&
-(void)loadDetailView:(NSString *)url{
    NSString *urlStr = url;
    NSString *httpUrl = @"http://api.playsm.com/index.php?&r=cartoonSet%2Fdetail&";
    if (![url hasPrefix:@"http://"]) {
        urlStr = [NSString stringWithFormat:@"%@id=%@",httpUrl,url];
        NSLog(@"%@",urlStr);
        
    }
    NSURL *urlStr1 = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlStr1];
    [self.webView loadRequest:request];

    
}
-(UIWebView *)webView{
    
    if (_webView == nil) {
        self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        self.webView.backgroundColor = [UIColor clearColor];
        self.webView.opaque = NO;
        self.webView.dataDetectorTypes = UIDataDetectorTypeAll;
        [self.view addSubview:self.webView];
    }
    return _webView;
    
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
