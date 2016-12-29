//
//  BalanceViewController.m
//  管车婆
//
//  Created by 李伟 on 16/11/11.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "BalanceViewController.h"
#import "CashWithdrawalVC.h"

@interface BalanceViewController ()
{
    
}
@end

@implementation BalanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kRGBColor(233, 239, 239);
    
    //设置导航栏
    [self addNavBar];
    
    //设置下面的视图
    [self addContentView];
    
}

# pragma mark ****** 设置导航栏 ******
- (void)addNavBar
{
    [self setNavigationItemTitle:@"余额"];
    [self setBackButtonWithImageName:@"back"];
}

# pragma mark ****** 设置下面的视图 ******
- (void)addContentView
{
    //账户余额视图
    UIImageView *bgImgView = [[UIImageView alloc] init];
    bgImgView.image = [UIImage imageNamed:@"first_balance_bg"];
    [self.view addSubview:bgImgView];
    [bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-15*kRate*2, 160*kRate));
        make.left.equalTo(self.view).with.offset(15*kRate);
        make.top.equalTo(self.view).with.offset(64+20*kRate);
    }];
    
    UIImageView *balanceImgView = [[UIImageView alloc] init];
    balanceImgView.image = [UIImage imageNamed:@"first_balance_img"];
    [bgImgView addSubview:balanceImgView];
    [balanceImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(27*kRate, 30*kRate));
        make.left.equalTo(bgImgView).with.offset(30*kRate);
        make.top.equalTo(bgImgView).with.offset(20*kRate);
    }];
    
    UILabel *balanceTitle = [[UILabel alloc] init];
    balanceTitle.textColor = [UIColor whiteColor];
    balanceTitle.font = [UIFont systemFontOfSize:17.0*kRate];
    balanceTitle.text = @"账户余额";
    [bgImgView addSubview:balanceTitle];
    [balanceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*kRate, 20*kRate));
        make.left.equalTo(balanceImgView.mas_right).with.offset(6*kRate);
        make.centerY.equalTo(balanceImgView.mas_centerY).with.offset(0);
    }];
    
    UILabel *balanceValue = [[UILabel alloc] init];
    balanceValue.text = @"250.75";
    balanceValue.textColor = [UIColor whiteColor];
    balanceValue.font = [UIFont systemFontOfSize:66*kRate weight:0.1];
    balanceValue.adjustsFontSizeToFitWidth = YES;
    [bgImgView addSubview:balanceValue];
    [balanceValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(250*kRate, 70*kRate));
        make.top.equalTo(balanceImgView.mas_bottom).with.offset(10*kRate);
        make.left.equalTo(bgImgView).with.offset(50*kRate);
    }];
    
    //提现按钮
    UIButton *cashWithdrawalBtn = [[UIButton alloc] init];
    [cashWithdrawalBtn setBackgroundColor:kRGBColor(22, 129, 251)];
    cashWithdrawalBtn.layer.cornerRadius = 5.0*kRate;
    cashWithdrawalBtn.titleLabel.font = [UIFont systemFontOfSize:20.0*kRate weight:0];
    [cashWithdrawalBtn setTitle:@"提 现" forState:UIControlStateNormal];
    [cashWithdrawalBtn addTarget:self action:@selector(cashWithdrawalBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cashWithdrawalBtn];
    [cashWithdrawalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-20*kRate*2, 50*kRate));
        make.left.equalTo(self.view).with.offset(20*kRate);
        make.top.equalTo(bgImgView.mas_bottom).with.offset(40*kRate);
    }];
}

#pragma mark --- UIButtonAction
- (void)cashWithdrawalBtnAction
{
    NSLog(@"提现");
    
    CashWithdrawalVC *cashWithdrawalVC = [[CashWithdrawalVC alloc] init];
    cashWithdrawalVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cashWithdrawalVC animated:NO];
    
}

@end
