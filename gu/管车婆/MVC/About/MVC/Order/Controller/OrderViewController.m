//
//  OrderViewController.m
//  管车婆
//
//  Created by 李伟 on 16/10/19.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderListVC.h"

@interface OrderViewController ()

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self addNavBar];
    
    //设置下面的订单列表同步滑动视图
    [self addOrderList];
    
}

#pragma mark ******   设置导航栏   ******
- (void)addNavBar
{
    [self setNavigationItemTitle:@"订单管理"];
    
    [self setBackButtonWithImageName:@"back"];
}

#pragma mark ******   设置下面的订单列表同步滑动视图   ******
- (void)addOrderList
{
    //配置按钮标题数组
    self.titleArray = [NSArray arrayWithObjects:@"全部", @"已预约", @"未完成", @"已完成", @"已评价", nil];
    
    //配置控制器数组(需要与上面的标题相对应)
    OrderListVC *allVC = [[OrderListVC alloc] init];
    allVC.vc = self;
    allVC.type = @"0";//全部
    OrderListVC *appointedVC = [[OrderListVC alloc] init];
    appointedVC.vc = self;
    appointedVC.type = @"1";//已预约
    OrderListVC *unCompletedVC = [[OrderListVC alloc] init];
    unCompletedVC.vc = self;
    unCompletedVC.type = @"2";//未完成
    OrderListVC *completedVC = [[OrderListVC alloc] init];
    completedVC.vc = self;
    completedVC.type = @"3";//已完成
    OrderListVC *evaluatedVC = [[OrderListVC alloc] init];
    evaluatedVC.type = @"4";//已评价
    evaluatedVC.vc = self;
    self.controllerArray = [NSArray arrayWithObjects:allVC, appointedVC, unCompletedVC, completedVC, evaluatedVC, nil];
    
}

@end
