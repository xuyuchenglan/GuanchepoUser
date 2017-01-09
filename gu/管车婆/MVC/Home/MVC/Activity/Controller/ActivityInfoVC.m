//
//  ActivityInfoVC.m
//  管车婆
//
//  Created by 李伟 on 17/1/9.
//  Copyright © 2017年 远恒网络科技有限公司. All rights reserved.
//

#import "ActivityInfoVC.h"

@interface ActivityInfoVC ()
{
    UIView *_titleView;//类似导航栏的视图
    UIScrollView *_scrollView;
    UIWebView *webView;//网页视图
}
@end

@implementation ActivityInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self setNavigationBar];
    
    //设置WebView
    [self addWebView];
    
}

#pragma  mark *****************  设置导航栏  ****************
- (void)setNavigationBar
{
    [self setNavigationItemTitle:_titleStr];
    [self setBackButtonWithImageName:@"back"];
}

#pragma  mark *****************  设置WebView  ****************
- (void)addWebView
{
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:webView];
    
    //加载网络页面
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.linkUrl]];
    [webView loadRequest:request];
}

@end
