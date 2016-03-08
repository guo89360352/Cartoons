//
//  TwoDetailViewController.m
//  Cartoon
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 郭亚茹. All rights reserved.
//

#import "TwoDetailViewController.h"

@interface TwoDetailViewController ()

@end

@implementation TwoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadDetailView:self.capterId];
}
-(void)loadDetailView:(NSString *)url{
    NSString *urlStr = url;
    NSString *httpUrl = kCapter;
    if (![url hasPrefix:@"http://"]) {
        urlStr = [NSString stringWithFormat:@"%@id=%@",httpUrl,url];
     //   NSLog(@"%@",urlStr);

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
