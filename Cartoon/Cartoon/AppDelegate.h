//
//  AppDelegate.h
//  Cartoon
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 郭亚茹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSString *wbtoken;
    NSString *wbCurrentUserID;
    
}
@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic)NSString *wbtoken;
@property(strong,nonatomic)NSString *wbRefreshToken;
@property(strong,nonatomic)NSString *wbCurrentUserID;
@property (strong, nonatomic) UITabBarController *tabBC;


@end

