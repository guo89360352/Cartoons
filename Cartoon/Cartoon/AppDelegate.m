//
//  AppDelegate.m
//  Cartoon
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 郭亚茹. All rights reserved.
//

#import "AppDelegate.h"
#import "WeiboSDK.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import <BmobSDK/Bmob.h>

@interface AppDelegate ()<WeiboSDKDelegate,WXApiDelegate>

@end
@interface WBBaseRequest ()
-(void)debugPrint;
@end
@interface WBBaseResponse ()
-(void)debugPrint;
@end

@implementation AppDelegate
@synthesize wbtoken;
@synthesize wbCurrentUserID;
@synthesize wbRefreshToken;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    
    //微博  微信 
    
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:@"1986762279"];
    
    [WXApi registerApp:@"wx35bb644b40744d79"];
    
    [Bmob registerWithAppKey:@"4727c8d874e98c2f7e8f827a9b78e2b1"];

    
    
    
    
    
    
    
    
    
    
    self.tabBC = [[UITabBarController alloc] init];
    
    //资讯
    UIStoryboard *messageStory = [UIStoryboard storyboardWithName:@"Message" bundle:nil];
    UINavigationController *mesageNav= [[UINavigationController alloc] init];
   mesageNav = messageStory.instantiateInitialViewController;
    mesageNav.tabBarItem.image = [UIImage imageNamed:@"mengwo_new2"];
    UIImage *messageSec = [UIImage imageNamed:@"mengwo_new1"];
    mesageNav.tabBarItem.title = @"资讯";
    mesageNav.tabBarItem.selectedImage = [messageSec imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    mesageNav.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    //漫画
    
    UIStoryboard *cartoonStory = [UIStoryboard storyboardWithName:@"Cartoon" bundle:nil];
    UINavigationController *cartoonNav= cartoonStory.instantiateInitialViewController;
    cartoonNav.tabBarItem.image = [UIImage imageNamed:@"mengwo_new2"];
    UIImage *cartoonSec = [UIImage imageNamed:@"mengwo_new1"];
    cartoonNav.tabBarItem.title = @"漫画";
    cartoonNav.tabBarItem.selectedImage = [cartoonSec imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    cartoonNav.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    //美图
    
    UIStoryboard *prettyStory = [UIStoryboard storyboardWithName:@"PrettyPictures" bundle:nil];
     UINavigationController *prettyNAV = prettyStory.instantiateInitialViewController;
    prettyNAV.tabBarItem.image = [UIImage imageNamed:@"mengwo_new2"];
    UIImage *prettySec = [UIImage imageNamed:@"mengwo_new1"];
    prettyNAV.tabBarItem.title = @"美图";
  prettyNAV.tabBarItem.selectedImage = [prettySec imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    prettyNAV.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    
    
    //我的
    
    UIStoryboard *mineStro = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
    
    UINavigationController *mineNAV = mineStro.instantiateInitialViewController;
    mineNAV.tabBarItem.image = [UIImage imageNamed:@"mengwo_new2"];
    mineNAV.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    mineNAV.tabBarItem.title = @"我的";
    UIImage *minesec =[UIImage imageNamed:@"mengwo_new1"];
    mineNAV.tabBarItem.selectedImage = [minesec imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //添加被管理的视图控制器
    self.tabBC.viewControllers = @[mesageNav,cartoonNav,prettyNAV,mineNAV];
    self.window.rootViewController = self.tabBC;
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    if([WeiboSDK isCanSSOInWeiboApp]){
        
        return [WeiboSDK handleOpenURL:url delegate:self];
        
    }
    return [WXApi handleOpenURL:url delegate:self];
}
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    if([WeiboSDK isCanSSOInWeiboApp]){
        
        return [WeiboSDK handleOpenURL:url delegate:self];
        
    }
    
    
    return [WXApi handleOpenURL:url delegate:self];
    
    
    
}
-(void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    
}
-(void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    
    
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
