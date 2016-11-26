//
//  FreeExperienceVoucherVC.m
//  管车婆
//
//  Created by 李伟 on 16/11/4.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "FreeExperienceVoucherVC.h"

@interface FreeExperienceVoucherVC ()

@end

@implementation FreeExperienceVoucherVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self addNavBar];
    
}


#pragma mark ****** 设置导航栏 ******
- (void)addNavBar
{
    [self setNavigationItemTitle:@"赠送体验券"];
    [self setBackButtonWithImageName:@"back"];
}


@end
