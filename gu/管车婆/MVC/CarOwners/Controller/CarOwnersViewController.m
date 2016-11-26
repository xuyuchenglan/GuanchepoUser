//
//  CarOwnersViewController.m
//  管车婆
//
//  Created by 李伟 on 16/9/27.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "CarOwnersViewController.h"
#import "CarOwnersListVC.h"

@interface CarOwnersViewController ()

@end

@implementation CarOwnersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self addNavBar];
    
    //设置下面的同步滑动视图
    [self addSyncScrollView];
}

#pragma mark ******************      设置导航栏      ****************
- (void)addNavBar
{
    //标题
    [self setNavigationItemTitle:@"车一族"];
    
    //距离搜索按钮
    
}


#pragma mark ******************  设置同步滑动视图  ****************
- (void)addSyncScrollView
{
    //配置按钮标题数组
    self.titleArray = [NSArray arrayWithObjects:@"保养常识", @"驾驶技巧", @"汽车大全", @"保养常识", @"驾驶技巧", @"汽车大全", @"保养常识", @"驾驶技巧", @"汽车大全", nil];
    
    //配置控制器数组(需要与上面的标题相对应)
    CarOwnersListVC *commonSenseVC = [[CarOwnersListVC alloc] init];
    commonSenseVC.type = @"1";//保养常识
    CarOwnersListVC *skillsVC = [[CarOwnersListVC alloc] init];
    skillsVC.type = @"2";//驾驶技巧
    CarOwnersListVC *everythingVC = [[CarOwnersListVC alloc] init];
    everythingVC.type = @"3";//汽车大全
    CarOwnersListVC *commonSenseVC1 = [[CarOwnersListVC alloc] init];
    commonSenseVC.type = @"1";//保养常识
    CarOwnersListVC *skillsVC1 = [[CarOwnersListVC alloc] init];
    skillsVC.type = @"2";//驾驶技巧
    CarOwnersListVC *everythingVC1 = [[CarOwnersListVC alloc] init];
    everythingVC.type = @"3";//汽车大全
    CarOwnersListVC *commonSenseVC2 = [[CarOwnersListVC alloc] init];
    commonSenseVC.type = @"1";//保养常识
    CarOwnersListVC *skillsVC2 = [[CarOwnersListVC alloc] init];
    skillsVC.type = @"2";//驾驶技巧
    CarOwnersListVC *everythingVC2 = [[CarOwnersListVC alloc] init];
    everythingVC.type = @"3";//汽车大全
    self.controllerArray = [NSArray arrayWithObjects:commonSenseVC, skillsVC, everythingVC, commonSenseVC1, skillsVC1, everythingVC1, commonSenseVC2, skillsVC2, everythingVC2, nil];
}

@end
