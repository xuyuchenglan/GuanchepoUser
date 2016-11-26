//
//  ProtocolViewController.m
//  管车婆
//
//  Created by 李伟 on 16/10/8.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "ProtocolViewController.h"

@interface ProtocolViewController ()

@end

@implementation ProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self addNavigationBar];
    
    //设置下面的协议展示视图
    [self addContentView];
}

#pragma mark ****************  设置导航栏  ******************
- (void)addNavigationBar
{
    [self setNavigationItemTitle:@"管车婆用户服务协议"];
    
    [self setBackButtonWithIsText:NO withIsExit:NO WithText:nil WithImageName:@"back_blue"];
}


#pragma mark ****************  设置下面的内容  ******************
- (void)addContentView
{
    
}

@end
