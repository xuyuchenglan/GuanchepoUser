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
    _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _titleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_titleView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 1)];
    lineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    [self.view addSubview:lineView];
    
}

//导航栏标题(文字)
- (void)setNavigationItemTitle:(NSString *)title
{
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-90,20,180,44)];
    titleLabel.text = title;
    
    titleLabel.backgroundColor = [UIColor clearColor];  //设置Label背景透明
    titleLabel.font            = [UIFont boldSystemFontOfSize:18];  //设置文本字体与大小
    titleLabel.textColor       = [UIColor colorWithRed:0 green:126/255.0 blue:1 alpha:1];  //设置文本颜色
    titleLabel.textAlignment   = NSTextAlignmentCenter;
    [_titleView addSubview:titleLabel];
}

//设置返回按钮
- (void)setBackButtonWithIsText:(BOOL)isText_noImage withIsExit:(BOOL)isExit WithText:(NSString *)text WithImageName:(NSString *)imageName
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(15, 30, 25, 25);
    
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
