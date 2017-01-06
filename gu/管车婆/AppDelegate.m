//
//  AppDelegate.m
//  管车婆
//
//  Created by 李伟 on 16/9/27.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "LoginViewController.h"
#import <AMapLocationKit/AMapLocationKit.h>//定位SDK头文件
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"//微信
#import "UMSocialQQHandler.h"//QQ
#import "UMSocialSinaSSOHandler.h"//新浪微博


#define AMapKey @"9cb391853ef6652d8a67f4d571d4169f"
#define kUmengAppkey @"586e0429c62dca606900044f"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    /***********************************   高德   *********************************/
    [AMapServices sharedServices].apiKey = (NSString *)AMapKey;//高德Key
    
    
    /*********************************   友盟分享   *******************************/
    [UMSocialData setAppKey:kUmengAppkey];
    
    //微信
    [UMSocialWechatHandler setWXAppId:@"wxfaf46b7e52252829" appSecret:@"3a40fd76a1152156133ebd221266a57b" url:@"http://www.umeng.com/social"];
    
    //手机QQ
    [UMSocialQQHandler setQQWithAppId:@"1105856517" appKey:@"rG7VRIsNyUf4x78g" url:@"http://www.umeng.com/social"];
    
    //新浪微博
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"1772386145"
                                              secret:@"70e6e66d4675991fb124863f9f2a8ca9"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    //对未安装客户端平台进行隐藏(这个接口只对默认分享面板平台有隐藏功能)
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline, UMShareToSina]];
    
    
    
    BOOL isLogin = [self isLogin];
    
    if (isLogin) {
        self.window.rootViewController = [[MainViewController alloc] init];
    } else {
        self.window.rootViewController = [[LoginViewController alloc] init];
    }
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}


//增加下面的系统回调配置，添加了这个方法才能在分享后从其他应用回到我们的应用来。注意如果同时使用微信支付、支付宝等其他需要改写回调代理的SDK，请在if分支下做区分，否则会影响 分享、登录的回调。
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    
    return result;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark 
#pragma mark --获取本地存储的数据，以验证是否已登录
- (BOOL)isLogin
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"my.plist"];
    
    NSDictionary * getDic = [NSDictionary dictionaryWithContentsOfFile:filename];
    
    if (getDic == NULL) {
        return NO;
    } else {
        return YES;
    }
}


@end
