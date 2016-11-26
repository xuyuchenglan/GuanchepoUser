//
//  PayForFuelCardRechargingVC.m
//  管车婆
//
//  Created by 李伟 on 16/11/1.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "PayForFuelCardRechargingVC.h"
#import "PaymentWayView.h"
#import "RechargeFuelcardInfoContentView.h"

@interface PayForFuelCardRechargingVC ()
{
    UIView *_orderInfoView;
    UIView *_paymentWayView;
}
@end

@implementation PayForFuelCardRechargingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:233/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    
    //设置导航栏
    [self addNavBar];
    
    //设置下面的内容视图
    [self addContentView];
}

#pragma mark ****** 设置导航栏 ******
- (void)addNavBar
{
    [self setNavigationItemTitle:@"加油卡充值"];
    [self setBackButtonWithImageName:@"back"];
}

#pragma mark ****** 设置下面的内容视图 ******
- (void)addContentView
{
    //订单详情
    [self addOrderInfoView];
    
    //请选择支付方式
    [self addPaymentWayView];
    
    //需支付金额Btn
    [self addMoneyBtn];
}

#pragma mark --- <一>订单详情
- (void)addOrderInfoView
{
    _orderInfoView = [[UIView alloc] init];
    [self.view addSubview:_orderInfoView];
    [_orderInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 180*kRate));//45*4
        make.top.equalTo(self.view).with.offset(64);
        make.left.equalTo(self.view).with.offset(0);
    }];
    
    //title
    UILabel *titleLB = [[UILabel alloc] init];
    titleLB.text = @"订单详情";
    titleLB.font = [UIFont systemFontOfSize:15.0*kRate];
    [_orderInfoView addSubview:titleLB];
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*kRate, 45*kRate));
        make.left.equalTo(_orderInfoView).with.offset(30*kRate);
        make.top.equalTo(_orderInfoView).with.offset(0);
    }];
    
    //content
    [self addInfoContentView];
}

//content
- (void)addInfoContentView
{
    RechargeFuelcardInfoContentView *infoContentView = [[RechargeFuelcardInfoContentView alloc] init];
    infoContentView.backgroundColor = [UIColor whiteColor];
    [_orderInfoView addSubview:infoContentView];
    [infoContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 45*kRate*3));
        make.left.equalTo(_orderInfoView).with.offset(0);
        make.top.equalTo(_orderInfoView).with.offset(45*kRate);
    }];
    
    
}


#pragma mark --- <二>请选择支付方式
- (void)addPaymentWayView
{
    _paymentWayView = [[UIView alloc] init];
    [self.view addSubview:_paymentWayView];
    [_paymentWayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 155*kRate));//45+55*2
        make.top.equalTo(_orderInfoView.mas_bottom).with.offset(0);
        make.left.equalTo(self.view).with.offset(0);
    }];
    
    //title
    UILabel *titleLB = [[UILabel alloc] init];
    titleLB.text = @"请选择支付方式";
    titleLB.font = [UIFont systemFontOfSize:15.0*kRate];
    [_paymentWayView addSubview:titleLB];
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150*kRate, 45*kRate));
        make.left.equalTo(_paymentWayView).with.offset(30*kRate);
        make.top.equalTo(_paymentWayView).with.offset(0);
    }];
    
    //content
    [self addWayContentView];
}

//content
- (void)addWayContentView
{
    UIView *wayContentView = [[UIView alloc] init];
    wayContentView.backgroundColor = [UIColor whiteColor];
    [_paymentWayView addSubview:wayContentView];
    [wayContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 55*kRate*2));
        make.left.equalTo(_paymentWayView).with.offset(0);
        make.top.equalTo(_paymentWayView).with.offset(45*kRate);
    }];
    
    /***分割线***/
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    [wayContentView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 1*kRate));
        make.top.equalTo(wayContentView).with.offset(54*kRate);
        make.left.equalTo(wayContentView).with.offset(0);
    }];
    /***分割线***/
    
    //微信支付
    PaymentWayView *weixinView = [[PaymentWayView alloc] init];
    weixinView.type = @"wechat";
    [wayContentView addSubview:weixinView];
    [weixinView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 54*kRate));
        make.top.equalTo(wayContentView).with.offset(0);
        make.left.equalTo(wayContentView).with.offset(0);
    }];
    
    //支付宝支付
    PaymentWayView *aliPayView = [[PaymentWayView alloc] init];
    aliPayView.type = @"alipay";
    [wayContentView addSubview:aliPayView];
    [aliPayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 55*kRate));
        make.top.equalTo(line1.mas_bottom).with.offset(0);
        make.left.equalTo(wayContentView).with.offset(0);
    }];
}

#pragma mark --- <三>需支付金额Btn
- (void)addMoneyBtn
{
    UIButton *moneyBtn = [[UIButton alloc] init];
    [moneyBtn setBackgroundColor:[UIColor colorWithRed:22/255.0 green:130/255.0 blue:251/255.0 alpha:1]];
    [moneyBtn setTitle:@"需支付88元" forState:UIControlStateNormal];
    moneyBtn.titleLabel.font = [UIFont systemFontOfSize:20.0*kRate];
    moneyBtn.layer.cornerRadius = 3.0*kRate;
    [self.view addSubview:moneyBtn];
    [moneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-30*kRate*2, 45*kRate));
        make.left.equalTo(self.view).with.offset(30*kRate);
        make.top.equalTo(_paymentWayView.mas_bottom).with.offset(30*kRate);
    }];
}

@end
