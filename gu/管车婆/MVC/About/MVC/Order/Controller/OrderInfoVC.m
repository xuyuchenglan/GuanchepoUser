//
//  OrderInfoVC.m
//  管车婆
//
//  Created by 李伟 on 16/10/22.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "OrderInfoVC.h"
#import "OrderContentInfoView.h"
#import "OrderContentMoreView.h"
#import "OrderStateView.h"
#import "AppointContentInfoView.h"

#define kImgWidth (kScreenWidth - 30*kRate)

@interface OrderInfoVC ()
{
    UIView *_moreView;
    UIView *_infoView;
    UIView *_stateView;
}
@property (nonatomic, strong)UIScrollView *scrollView;

@end

@implementation OrderInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _scrollView.backgroundColor = [UIColor colorWithRed:248/255.0 green:249/255.0 blue:250/255.0 alpha:1];
    _scrollView.contentSize = CGSizeMake(kScreenWidth, 1000 + kImgWidth * 2);
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    //设置导航栏
    [self addNavBar];
    
    //设置下面的内容视图
    [self addContentView];
}

#pragma mark ******   设置导航栏   ******
- (void)addNavBar
{
    [self setNavigationItemTitle:@"订单管理"];
    
    [self setBackButtonWithImageName:@"back"];
}


#pragma  mark *****************  设置下面的内容视图  ****************

- (void)addContentView
{
    //订单详情
    [self addMoreView];
    
    //订单信息
    [self addInfoView];
    
    if (![_isAppoint isEqual:@"yes"]) {
        //订单状态
        [self addStateView];
    }
    
}

//订单详情
- (void)addMoreView
{
    _moreView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 195*kRate)];
    [_scrollView addSubview:_moreView];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30*kRate, 10*kRate, kScreenWidth - 40*kRate, 20*kRate)];
    titleLabel.text = @"订单详情";
    titleLabel.font = [UIFont systemFontOfSize:15.0*kRate];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [_moreView addSubview:titleLabel];
    
    //内容
    OrderContentMoreView *contentView = [[OrderContentMoreView alloc] initWithFrame:CGRectMake(0, 40*kRate, kScreenWidth, 155*kRate)];
    contentView.backgroundColor = [UIColor whiteColor];
    [_moreView addSubview:contentView];
}

//订单信息
- (void)addInfoView
{
    if ([_isAppoint isEqual:@"yes"]) {
        _infoView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_moreView.frame), kScreenWidth, 160*kRate)];
    } else {
        _infoView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_moreView.frame), kScreenWidth, 130*kRate)];
    }
    [_scrollView addSubview:_infoView];
    
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30*kRate, 10*kRate, kScreenWidth - 40*kRate, 20*kRate)];
    titleLabel.text = @"订单信息";
    titleLabel.font = [UIFont systemFontOfSize:15.0*kRate];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [_infoView addSubview:titleLabel];
    
    //内容
    if ([_isAppoint isEqual:@"yes"]) {
        AppointContentInfoView *contentView = [[AppointContentInfoView alloc] initWithFrame:CGRectMake(0, 40*kRate, kScreenWidth, 120*kRate)];

        contentView.backgroundColor = [UIColor whiteColor];
        [_infoView addSubview:contentView];
    } else {
        OrderContentInfoView *contentView = [[OrderContentInfoView alloc] initWithFrame:CGRectMake(0, 40*kRate, kScreenWidth, 90*kRate)];
        contentView.backgroundColor = [UIColor whiteColor];
        [_infoView addSubview:contentView];
    }
    
}

//订单状态
- (void)addStateView
{
    _stateView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_infoView.frame), kScreenWidth, 130*kRate)];
    [_scrollView addSubview:_stateView];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30*kRate, 10*kRate, kScreenWidth - 40*kRate, 20*kRate)];
    titleLabel.text = @"订单状态";
    titleLabel.font = [UIFont systemFontOfSize:15.0*kRate];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [_stateView addSubview:titleLabel];
    
    //内容
    OrderStateView *contentView = [[OrderStateView alloc] initWithFrame:CGRectMake(0, 40*kRate, kScreenWidth, 90*kRate)];
    contentView.backgroundColor = [UIColor whiteColor];
    [_stateView addSubview:contentView];
}

@end
