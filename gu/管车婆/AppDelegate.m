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
#import "WXApi.h"


#define AMapKey @"9cb391853ef6652d8a67f4d571d4169f"
#define kUmengAppkey @"586e0429c62dca606900044f"


@interface AppDelegate ()<WXApiDelegate>
{
    NSString *_out_trade_no;
}
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
    
    /*********************************   微信支付   *******************************/
    //如果项目中第三方分享用的是友盟，在注册的时候要把友盟注册放在微信注册的前面执行
    [WXApi registerApp:@"wxfaf46b7e52252829" withDescription:@"管车婆用户版微信支付"];//向微信注册APPID
    
    
    
    BOOL isLogin = [self isLogin];
    
    if (isLogin) {
        self.window.rootViewController = [[MainViewController alloc] init];
    } else {
        self.window.rootViewController = [[LoginViewController alloc] init];
    }
    
    [self.window makeKeyAndVisible];
    
    
    //接收CouponCell中发送过来的通知，以接收传递过来的out_trade_no值，在支付成功后验证后台是否也是支付成功的状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateOut_trade_no_Value:) name:@"out_trade_no" object:nil];
    
    return YES;
}


//增加下面的系统回调配置，添加了这个方法才能在分享后从其他应用回到我们的应用来。注意如果同时使用微信支付、支付宝等其他需要改写回调代理的SDK，请在if分支下做区分，否则会影响 分享、登录的回调。
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //    BOOL result = [UMSocialSnsService handleOpenURL:url];
    //
    //    NSLog(@"友盟分享回调:%d", result);
    //
    //    if (result == FALSE) {
    //        //调用其他SDK，例如支付宝SDK等
    //
    //        result = [WXApi handleOpenURL:url delegate:self];
    //        NSLog(@"微信支付回调：%d", result);
    //
    //    }
    //
    //    return result;
    
    return [WXApi handleOpenURL:url delegate:self];//这里的逻辑啥的我没怎么搞懂，先暂且这样吧。即便把openURL整个方法都给注释掉，无论是友盟分享完毕后还是微信支付完毕后，都是可以返回管车婆app的。但是如果不调用[WXApi handleOpenURL:url delegate:self]的话，代理方法onResp就不会在支付完成返回管车婆APP后被调用，这肯定是不行的，所以[WXApi handleOpenURL:url delegate:self]方法是必须被调用的。
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

#pragma mark
#pragma mark 接收传递过来的out_trade_no值，以在支付成功后验证后台是否也是支付成功的状态
- (void)updateOut_trade_no_Value:(NSNotification *)notification
{
    _out_trade_no = notification.userInfo[@"out_trade_no"];
}

#pragma mark
#pragma mark WXApiDelegate
- (void)onResp:(BaseResp *)resp
{
    if ([resp isKindOfClass:[PayResp class]]){
        
        PayResp *response=(PayResp*)resp;
        
        switch(response.errCode){
            case WXSuccess:
                //服务器端查询支付通知或查询API返回的结果再提示成功
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                
                //查询后台的支付状态
                [self varifyTheBackgroundState];
                
                break;
            default:
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                
                break;
        }
    }
}

#pragma mark --- 在支付成功后验证后台是否也是支付成功的状态
- (void)varifyTheBackgroundState
{
    NSString *url_post = [NSString stringWithFormat:@"http://%@/zcar/wxCtl/orderquery.action", kIP];
    
    NSDictionary *params = @{
                             @"outTradeNo":_out_trade_no,
                             @"zfType":@"2",//支付类型    1-微信公众号支付   2-微信APP支付
                             };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = responseSerializer;
    [manager POST:url_post parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSString *result = [content objectForKey:@"result"];
        if ([result isEqualToString:@"success"]) {
            
            NSString *trade_state = [content objectForKey:@"trade_state"];
            if ([trade_state isEqualToString:@"SUCCESS"]) {
                
                //查询后台的支付结果是成功的之后，在这里面进行页面的刷新或者是支付成功后的业务逻辑等操作
                
                //给CouponCell.m发送个通知，让CouponCell来完成添加店铺券的网络申请
                [[NSNotificationCenter defaultCenter] postNotificationName:@"addDianpuquan.action" object:self];
                
                //给PayForOpeningCard.m发送通知，让其完成添加会员卡的网络申请
                [[NSNotificationCenter defaultCenter] postNotificationName:@"addCard.action" object:self];
            }
            
        }
        
        
        
    } failure:nil];
}



#pragma mark
#pragma mark 移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
