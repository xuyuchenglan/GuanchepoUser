//
//  CarCouponVC.m
//  管车婆
//
//  Created by 李伟 on 16/11/3.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "CarCouponVC.h"
#import "CarCouponListVC.h"

@interface CarCouponVC ()

@end

@implementation CarCouponVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self addNavBar];
    
    //设置下面的同步滑动视图
    [self addSyncScrollView];
}

#pragma mark ****** 设置导航栏 ******
- (void)addNavBar
{
    [self setNavigationItemTitle:@"我的汽车券"];
    [self setBackButtonWithImageName:@"back"];
}

#pragma mark ******************  设置同步滑动视图  ****************
- (void)addSyncScrollView
{
    //配置按钮标题数组
    self.titleArray = [NSArray arrayWithObjects:@"全部", @"洗车", @"保养", @"美容", @"其他", nil];
    
    //配置控制器数组(需要与上面的标题相对应)
    CarCouponListVC *allVC = [[CarCouponListVC alloc] init];
    allVC.type = @"1";//全部
    CarCouponListVC *cleanVC = [[CarCouponListVC alloc] init];
    cleanVC.type = @"2";//洗车
    CarCouponListVC *maintainVC = [[CarCouponListVC alloc] init];
    maintainVC.type = @"3";//保养
    CarCouponListVC *beautyVC = [[CarCouponListVC alloc] init];
    beautyVC.type = @"4";//美容
    CarCouponListVC *otherVC = [[CarCouponListVC alloc] init];
    otherVC.type = @"5";//其他
    self.controllerArray = [NSArray arrayWithObjects:allVC, cleanVC, maintainVC, beautyVC,  otherVC, nil];
}



@end
