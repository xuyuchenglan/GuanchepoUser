//
//  MainViewController.m
//  管车婆
//
//  Created by 李伟 on 16/9/27.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "StoresViewController.h"
#import "CarOwnersViewController.h"
#import "AboutViewController.h"


@interface MainViewController ()<UITabBarControllerDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self markTabbarController];
    
    
}

- (void)markTabbarController
{
    _tabbarController = [[UITabBarController alloc] init];
    _tabbarController.delegate = self;
    
    /***************************  设置每个tabbarItem对应的页面  **************************/
    //首页页面
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    [homeVC.navigationController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -2)];//设置tabbar上面的title文字靠上一点
    
    //门店页面
    StoresViewController *storesVC = [[StoresViewController alloc] init];
    storesVC.selectedNum = 0;
    [storesVC addObserver];
    UINavigationController *storesNav = [[UINavigationController alloc] initWithRootViewController:storesVC];
    [storesVC.navigationController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -2)];
    
    
    
    //车一族页面
    CarOwnersViewController *carOwnersVC = [[CarOwnersViewController alloc] init];
    UINavigationController *carOwnersNav = [[UINavigationController alloc] initWithRootViewController:carOwnersVC];
    [carOwnersVC.navigationController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -2)];
    
    
    //我的页面
    AboutViewController *aboutVC = [[AboutViewController alloc] init];
    UINavigationController *aboutNav = [[UINavigationController alloc] initWithRootViewController:aboutVC];
    [aboutVC.navigationController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -2)];
    
    _tabbarController.viewControllers = [NSArray arrayWithObjects:homeNav, storesNav, carOwnersNav,  aboutNav, nil];
    
    /********************  设置每个页面所对应的tabbarItem上的标题和图片  *******************/
    _tabbar = _tabbarController.tabBar;
    
    NSArray *barImgs_un = [NSArray arrayWithObjects:@"tabbar_home_un", @"tabbar_stores_un", @"tabbar_carowners_un", @"tabbar_about_un", nil];
    NSArray *barImgs = [NSArray arrayWithObjects:@"tabbar_home", @"tabbar_stores", @"tabbar_carowners", @"tabbar_about", nil];
    NSArray *barNames = [NSArray arrayWithObjects:@"首  页", @"门  店", @"车一族", @"我  的", nil];
    
    for (int i = 0; i < barNames.count; i++) {
        _tabbarItem = [_tabbar.items objectAtIndex:i];
        
        [_tabbarItem setTitle:barNames[i]];
        [_tabbarItem setImage:[[UIImage imageNamed:barImgs_un[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];//未选中状态的图片
        _tabbarItem.selectedImage = [[UIImage imageNamed:barImgs[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//选中状态的图片
    }
    
    /*****************************  设置底部tabbar的背景颜色  ****************************/
    UIView *tabbarBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 49)];
    
    tabbarBgView.backgroundColor = [UIColor whiteColor];
    
    [self.tabbarController.tabBar insertSubview:tabbarBgView atIndex:0];
    
    /*********************************** 结束线 ***************************************/
    
    ///一开始停留在哪个页面
    [_tabbarController setSelectedIndex:0];
    
    [self.view addSubview:_tabbarController.view];
    
}



#pragma mark UITabBarControllerDelegate
//当页面处于3级页面的时候，点击tabbar会进入首页，这个时候动画效果会导致3级页面的导航栏延迟消失，很丑，而我又不知道怎么让该动画消失，所以就禁止“在3几页面的时候点击tabbar进入首页”
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    UIViewController *selected = [tabBarController selectedViewController];
    if ([selected isEqual:viewController]) {
        return NO;
    }
    return YES;
}



@end
