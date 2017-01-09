//
//  MaintainCouponVC.m
//  管车婆
//
//  Created by 李伟 on 16/10/24.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "MaintainCouponVC.h"
#import "CouponInfoView.h"
#import "MaintainItemsVC.h"
#import "BuyCouponVC.h"

#define kNavbarAndImgviewAndTitleviewHeight (64 + 225*kRate + 45*kRate)
#define kFirstViewHeight                     60*kRate
#define kSecondContentHeight                 280*kRate
#define kBottomViewHeight                    (kScreenHeight - kNavbarAndImgviewAndTitleviewHeight - kFirstViewHeight - kSecondContentHeight)

@interface MaintainCouponVC ()
{
    UIView          *firstView;
    CouponInfoView  *couponInfoView;
    UIView          *bottomView;
}
@end

@implementation MaintainCouponVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //选择推荐项目
    [self addFirstContent];
    
    //展示选择的项目
    [self addSecondContent];
    
    //底部视图：合计、联系客服、去结算
    [self addBottomView];
    
}


#pragma mark ****** 选择推荐项目 ******
- (void)addFirstContent
{
    firstView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kFirstViewHeight)];
    [self.view addSubview:firstView];
    
    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(20*kRate, 10*kRate, 200*kRate, 20*kRate)];
    titleLB.text = @"推荐保养x1";
    titleLB.font = [UIFont systemFontOfSize:15.0*kRate];
    [firstView addSubview:titleLB];
    
    UILabel *subTitleLB = [[UILabel alloc] initWithFrame:CGRectMake(20*kRate, CGRectGetMaxY(titleLB.frame) + 5*kRate, 200*kRate, 20*kRate)];
    subTitleLB.text = @"根据爱车信息推荐";
    subTitleLB.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    subTitleLB.font = [UIFont systemFontOfSize:15.0*kRate];
    [firstView addSubview:subTitleLB];
    
    UIButton * selectItemsBtn = [[UIButton alloc] init];
    [selectItemsBtn setTitle:[NSString stringWithFormat:@"剩余可选项目x%lu>", (unsigned long)_couponModels.count] forState:UIControlStateNormal];
    [selectItemsBtn setTitleColor:kRGBColor(22, 129, 252) forState:UIControlStateNormal];
    selectItemsBtn.titleLabel.font = [UIFont systemFontOfSize:15.0*kRate];
    [selectItemsBtn addTarget:self action:@selector(selectItemsBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [firstView addSubview:selectItemsBtn];
    [selectItemsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(130*kRate, 60*kRate));
        make.right.equalTo(firstView).with.offset(-20*kRate);
    }];
    
}

#pragma mark ****** 展示选择的项目 ******
- (void)addSecondContent
{
    couponInfoView = [[CouponInfoView alloc] initWithFrame:CGRectMake(0, kFirstViewHeight, kScreenWidth, kSecondContentHeight)];
    couponInfoView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:couponInfoView];
}

#pragma mark ****** 底部视图：合计、联系客服、去结算 ******
- (void)addBottomView
{
    bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, kBottomViewHeight));
        make.top.equalTo(couponInfoView.mas_bottom).with.offset(0);
    }];
    
    //合计
    UILabel *totalLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/3, kBottomViewHeight)];
    totalLB.text = @"合计666元";
    totalLB.font = [UIFont systemFontOfSize:15.0*kRate];
    totalLB.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:totalLB];
    
    //联系客服
    UIButton *contactServer = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/3, 0, kScreenWidth/3, kBottomViewHeight)];
    [contactServer setBackgroundColor:[UIColor redColor]];
    contactServer.titleLabel.font = [UIFont systemFontOfSize:18.0*kRate];
    [contactServer setTitle:@"联系客服" forState:UIControlStateNormal];
    [contactServer addTarget:self action:@selector(contactServerAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:contactServer];
    
    //去结算
    UIButton *payBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/3*2, 0, kScreenWidth/3, kBottomViewHeight)];
    payBtn.titleLabel.font = [UIFont systemFontOfSize:18.0*kRate];
    [payBtn setTitle:@"去结算" forState:UIControlStateNormal];
    payBtn.backgroundColor = kRGBColor(22, 129, 250);
    [payBtn addTarget:self action:@selector(payBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:payBtn];
}

#pragma mark ButtonAction
- (void)selectItemsBtnAction
{
    NSLog(@"剩余可选项目");
    
    MaintainItemsVC *maintainItems = [[MaintainItemsVC alloc] init];
    maintainItems.couponModels = _couponModels;
    maintainItems.hidesBottomBarWhenPushed = YES;
    [[self findResponderVCWith:[[BuyCouponVC alloc]init]].navigationController pushViewController:maintainItems animated:NO];
}

- (void)contactServerAction
{
    NSLog(@"联系客服");
}

- (void)payBtnAction
{
    NSLog(@"去结算");
}


@end
