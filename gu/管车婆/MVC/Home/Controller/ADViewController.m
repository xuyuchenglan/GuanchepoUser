//
//  ADViewController.m
//  管车婆
//
//  Created by 李伟 on 16/12/7.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import "ADViewController.h"

@interface ADViewController ()<UIWebViewDelegate>
{
    UIWebView *webView;//网页视图
}
@end

@implementation ADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self setNavigationBar];
    
    //设置WebView
    [self setWebView];
}

#pragma  mark *****************  设置导航栏  ****************
- (void)setNavigationBar
{
    [self setBackButtonWithImageName:@"back"];
    [self setNavigationItemTitle:_titleStr];
}


#pragma  mark *****************  设置WebView  ****************

- (void)setWebView
{
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
    webView.delegate = self;
    [self.view addSubview:webView];
    
    //加载网络页面
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_linkUrl]];
    [webView loadRequest:request];
}

#pragma mark -- UIWebViewDelegate
//网页加载之前调用该方法
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;//YES表示正常加载网页；NO表示将停止加载网页
}

@end
