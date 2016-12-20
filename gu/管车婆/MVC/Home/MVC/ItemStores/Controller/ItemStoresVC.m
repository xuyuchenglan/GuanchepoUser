//
//  ItemStoresVC.m
//  管车婆
//
//  Created by 李伟 on 16/12/14.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import "ItemStoresVC.h"
#import "ItemStoresListVC.h"


@interface ItemStoresVC ()



@end

@implementation ItemStoresVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //导航栏
    [self setNavigationItemTitle:self.sname];
    [self setBackButtonWithImageName:@"back"];
    
    
    
    //设置下面的订单列表同步滑动视图
//    [self addOrderList];

}

#pragma mark ******   设置下面的订单列表同步滑动视图   ******
- (void)addOrderList
{
    //配置按钮标题数组
    self.titleArray = [NSArray arrayWithObjects:@"距离", @"销量", @"好评", nil];
    
    //配置控制器数组(需要与上面的标题相对应)
    ItemStoresListVC *distanceVC = [[ItemStoresListVC alloc] init];
    distanceVC.vc = self;
    distanceVC.superID = _sid;
    distanceVC.type = @"1";//距离
    ItemStoresListVC *salesVC = [[ItemStoresListVC alloc] init];
    salesVC.vc = self;
    salesVC.superID = _sid;
    salesVC.type = @"2";//销量
    ItemStoresListVC *praiseVC = [[ItemStoresListVC alloc] init];
    praiseVC.vc = self;
    praiseVC.superID = _sid;
    praiseVC.type = @"3";//好评
    
    
    self.controllerArray = [NSArray arrayWithObjects:distanceVC, salesVC, praiseVC, nil];

}




@end
