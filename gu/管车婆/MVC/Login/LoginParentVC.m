//
//  LoginParentVC.m
//  管车婆
//
//  Created by 李伟 on 16/9/29.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "LoginParentVC.h"


@interface LoginParentVC ()
{
    UIView *_titleView;//类似导航栏的视图
}
@end

@implementation LoginParentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //设置导航栏
    [self addNavBar];
}

#pragma mark ****************  设置导航栏  ******************
- (void)addNavBar
{
    _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64*kRate)];
    _titleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_titleView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 64*kRate, kScreenWidth, 1*kRate)];
    lineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    [self.view addSubview:lineView];
    
}

//导航栏标题(文字)
- (void)setNavigationItemTitle:(NSString *)title
{
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-90*kRate,20*kRate,180*kRate,44*kRate)];
    titleLabel.text = title;
    
    titleLabel.backgroundColor = [UIColor clearColor];  //设置Label背景透明
    titleLabel.font            = [UIFont boldSystemFontOfSize:18*kRate];  //设置文本字体与大小
    titleLabel.textColor       = [UIColor colorWithRed:0 green:126/255.0 blue:1 alpha:1];  //设置文本颜色
    titleLabel.textAlignment   = NSTextAlignmentCenter;
    [_titleView addSubview:titleLabel];
}

//设置返回按钮
- (void)setBackButtonWithIsText:(BOOL)isText_noImage withIsExit:(BOOL)isExit WithText:(NSString *)text WithImageName:(NSString *)imageName
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(15*kRate, 30*kRate, 25*kRate, 25*kRate);
    
    if (isText_noImage == YES) {
        [btn setTitle:text forState:UIControlStateNormal];
    } else {
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    
    if (isExit) {
        [btn addTarget:self action:@selector(exitBtnAction) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [btn addTarget: self action: @selector(goBackAction) forControlEvents: UIControlEventTouchUpInside];
    }
    
    
    [_titleView addSubview:btn];
}

///返回按钮Action
- (void)goBackAction
{
    NSLog(@"返回");
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

///退出按钮Action
- (void)exitBtnAction
{
    NSLog(@"退出");
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"退出" message:@"您确定要退出吗？" preferredStyle:UIAlertControllerStyleAlert];//上拉菜单样式
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancel];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        exit(0);
        
    }];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];//这种弹出方式会在原来视图的背景下弹出一个视图。
}

#pragma mark
#pragma mark --- 手机号登录（在验证码登录、修改密码、注册三个页面中会用到）
- (void)loginByNumber:(NSString *)number
{
    NSString *url_post = [NSString stringWithFormat:@"http://%@:8080/zcar/userapp/loginByPhone.action", kIP];
    
    NSDictionary *params = @{
                             @"phone":number
                             };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer = responseSerializer;
    
    [manager POST:url_post parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"手机验证码成功，请求下来的Json格式的数据是%@", content);
        
        NSDictionary *jsondataDic = [content objectForKey:@"jsondata"];
        NSString *resultStr = [content objectForKey:@"result"];
        
        if ([resultStr isEqualToString:@"success"]  && ![jsondataDic  isEqual: @""]) {
            
            NSLog(@"登陆成功");
            
            //保存个人数据,将获取到的jsondata对应的数组中的uid等数据存储到本地plist文件中
            [self saveDataToPlistWithDic:jsondataDic];
            
            //跳入到MainViewController
            [self presentViewController:[[MainViewController alloc] init] animated:NO completion:nil];
            
        } else {
            NSLog(@"登录失败");
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败， 失败原因是：%@", error);
    }];
}

#pragma mark --- 获取手机验证码
//获取手机验证码
- (void)getVerificationCodePostWithNumber:(NSString *)number
{
    NSString *url_post = [NSString stringWithFormat:@"http://%@:8080/zcar/userapp/getSmsAlidayu.action", kIP];
    
    NSDictionary *params = @{
                             @"phone":number
                             };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = responseSerializer;
    
    [manager POST:url_post parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        _verificationCodePostStr = [NSString stringWithFormat:@"%@", [content objectForKey:@"sms_yzm"]];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败， 失败原因是：%@", error);
    }];
    
}

#pragma mark --- 登陆成功后，保存数据到本地
//保存数据到plist文件
- (void)saveDataToPlistWithDic:(NSDictionary *)contentDic
{
    //将请求下来的数据中的data对应的字典保存到沙盒的自己创建的plist文件中
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"my.plist"];
    [contentDic  writeToFile:filename atomically:YES];
    
    //从沙盒中获取到plist文件
    //NSDictionary * getDic = [NSDictionary dictionaryWithContentsOfFile:filename];
    //NSLog(@"沙盒中存储的信息是：%@", getDic);
}


@end
