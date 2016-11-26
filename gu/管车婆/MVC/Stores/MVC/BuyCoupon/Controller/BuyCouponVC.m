//
//  BuyCouponVC.m
//  管车婆
//
//  Created by 李伟 on 16/10/22.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "BuyCouponVC.h"
#import "CouponListVC.h"
#import "MaintainCouponVC.h"

#define kTitleHeight 45*kRate

@interface BuyCouponVC ()

@end

@implementation BuyCouponVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self addNavBar];
    
    //设置下方的内容视图
    [self addContentView];
}

#pragma mark ******  设置导航栏  ******
- (void)addNavBar
{
    self.view.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    
    [self setBackButtonWithImageName:@"back"];
    [self setNavigationItemTitle:@"购买店铺券"];
}

#pragma mark ******  设置下方的内容视图  ******
- (void)addContentView
{
    //店铺大头照
    UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 225*kRate)];
    headImgView.image = [UIImage imageNamed:@"stores_headImg"];
    [self.view addSubview:headImgView];
    
    //配置按钮标题数组
    self.titleFrame = CGRectMake(0, CGRectGetMaxY(headImgView.frame), kScreenWidth, kTitleHeight);
    self.titleArray = [NSArray arrayWithObjects:@"洗车", @"保养", @"美容", @"其他", nil];
    
    //配置控制器数组(需要与上面的标题相对应)
    CouponListVC *carCleanVC = [[CouponListVC alloc] init];
    carCleanVC.type = @"1";//洗车
    MaintainCouponVC *carMaintainVC = [[MaintainCouponVC alloc] init];//保养
    CouponListVC *carBeautyVC = [[CouponListVC alloc] init];
    carBeautyVC.type = @"3";//美容
    CouponListVC *otherVC = [[CouponListVC alloc] init];
    otherVC.type = @"4";//其他
    self.controllerArray = [NSArray arrayWithObjects:carCleanVC, carMaintainVC, carBeautyVC, otherVC, nil];
}
@end
