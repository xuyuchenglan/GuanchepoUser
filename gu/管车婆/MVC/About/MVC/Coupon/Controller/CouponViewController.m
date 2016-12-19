//
//  CouponViewController.m
//  管车婆
//
//  Created by 李伟 on 16/11/10.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "CouponViewController.h"
#import "CouponListViewController.h"

@interface CouponViewController ()

@end

@implementation CouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //导航栏
    [self addNavBar];
    
    //设置下面的同步滑动视图
    [self addSyncScrollView];
    
}

#pragma mark ******************      导航栏      ****************
- (void)addNavBar
{
    [self setNavigationItemTitle:@"选择类型"];
    [self setBackButtonWithImageName:@"back"];
    
}

#pragma mark ******************  设置同步滑动视图  ****************
- (void)addSyncScrollView
{
    //配置按钮标题数组
    self.titleArray = [NSArray arrayWithObjects:@"未使用", @"已使用", @"已过期", nil];
    
    //配置控制器数组(需要与上面的标题相对应)
    CouponListViewController *usableVC = [[CouponListViewController alloc] init];
    usableVC.type = @"1";
    CouponListViewController *usedVC = [[CouponListViewController alloc] init];
    usedVC.type = @"2";
    CouponListViewController *expiredVC = [[CouponListViewController alloc] init];
    expiredVC.type = @"3";
    self.controllerArray = [NSArray arrayWithObjects:usableVC, usedVC, expiredVC, nil];
    
}



@end
