//
//  ExchangePointsVC.m
//  管车婆
//
//  Created by 李伟 on 16/11/3.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "ExchangePointsVC.h"
#import "ExchangePointsView.h"

#define kExchangePointsViewWidth ((kScreenWidth - 10*kRate*2 - 15*kRate)/2)

@interface ExchangePointsVC ()

@end

@implementation ExchangePointsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kRGBColor(233, 239, 239);
    
    //设置导航栏
    [self addNavBar];
    
    //设置下面的内容视图
    [self addContentView];
}

#pragma mark ****** 设置导航栏 ******
- (void)addNavBar
{
    [self setNavigationItemTitle:@"积分兑换"];
    [self setBackButtonWithImageName:@"back"];
}

#pragma mark ****** 设置下面的内容视图
- (void)addContentView
{
    for (int i = 0; i < 4; i++) {
        
        int a = i%2;
        int b = i/2;
        
        ExchangePointsView *exchangePointsView = [[ExchangePointsView alloc] initWithFrame:CGRectMake(10*kRate + (kExchangePointsViewWidth+15*kRate)*a, 64 + 10*kRate + (kExchangePointsViewWidth*1.272+10*kRate)*b, kExchangePointsViewWidth, kExchangePointsViewWidth*1.272)];
        [self.view addSubview:exchangePointsView];
        
    }
    
}


@end
