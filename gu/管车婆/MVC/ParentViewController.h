//
//  ParentViewController.h
//  管车婆
//
//  Created by 李伟 on 16/9/27.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParentViewController : UIViewController

- (void)setNavigationItemTitle:(NSString *)title;//导航栏标题

- (void)setBackButtonWithImageName:(NSString *)imageName;//返回按钮

- (void)addObserver;//添加通知观察者

/******************  同步滑动页的配置  *******************/
@property (nonatomic, assign) int       selectedNum;
@property (nonatomic, strong) NSArray  *titleArray;
@property (nonatomic, strong) NSArray  *controllerArray;

@property (nonatomic, assign) CGRect   titleFrame;

@end
