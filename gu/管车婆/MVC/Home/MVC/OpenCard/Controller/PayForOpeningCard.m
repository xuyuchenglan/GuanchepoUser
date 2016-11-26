//
//  PayForOpeningCard.m
//  管车婆
//
//  Created by 李伟 on 16/11/8.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "PayForOpeningCard.h"
#import "Way4PaymentOfOpencardView.h"

#define kThirdHeight 50*kRate
#define kMembershipWidth (kScreenWidth-40*kRate*2)

@interface PayForOpeningCard ()
{
    UIImageView *_firstImgView;
    UIView      *_secondView;
    UIView      *_thirdView;
    UIView      *_forthView;
    UIButton    *_openCardBtn;
}
@property (nonatomic, strong)UIScrollView *scrollView;
@end

@implementation PayForOpeningCard

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self addNavBar];
    
    //设置下面的内容视图
    [self addContentView];
}
#pragma mark
#pragma mark ****** 设置导航栏 ******
- (void)addNavBar
{
    [self setNavigationItemTitle:@"办卡支付"];
    [self setBackButtonWithImageName:@"back"];
}

#pragma mark ****** 设置下面的内容视图 ******
- (void)addContentView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _scrollView.backgroundColor = [UIColor colorWithRed:233/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight + 200);
    [self.view addSubview:_scrollView];
    
    //第一部分：卡片名称、金额
    [self addFirst];
    
    //第二部分：服务项目、详细
    [self addSecond];
    
    //第三部分：推荐人推荐码
    [self addThird];
    
    //第四部分：支付方式
    [self addForth];
    
    //第五部分：立即开卡
    [self addFifth];
    
}

//第一部分：卡片名称、金额
- (void)addFirst
{
    _firstImgView = [[UIImageView alloc] init];
    _firstImgView.image = [UIImage imageNamed:@"home_third_membership_pay_bg"];
    [_scrollView addSubview:_firstImgView];
    [_firstImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 250*kRate));
        make.top.equalTo(_scrollView).with.offset(8*kRate);
        make.left.equalTo(_scrollView).with.offset(0);
    }];
    
    UIImageView *membershipImgView = [[UIImageView alloc] init];
    membershipImgView.image = [UIImage imageNamed:@"home_third_membership_card"];
    [_firstImgView addSubview:membershipImgView];
    [membershipImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kMembershipWidth, kMembershipWidth*0.58));
        make.left.equalTo(_firstImgView).with.offset(40*kRate);
        make.top.equalTo(_firstImgView).with.offset(10*kRate);
    }];
    
    UIImageView *cardImgView = [[UIImageView alloc] init];
    cardImgView.image = [UIImage imageNamed:@"home_third_membership_pay_head"];
    [_firstImgView addSubview:cardImgView];
    [cardImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20*kRate, 20*kRate*0.71));
        make.left.equalTo(_firstImgView).with.offset(50*kRate);
        make.top.equalTo(membershipImgView.mas_bottom).with.offset(15*kRate);
    }];
    
    UILabel *cardNameLB = [[UILabel alloc] init];
    cardNameLB.text = @"铂金贵宾卡";
    cardNameLB.font = [UIFont systemFontOfSize:15*kRate];
    [_firstImgView addSubview:cardNameLB];
    [cardNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*kRate, 20*kRate));
        make.left.equalTo(cardImgView.mas_right).with.offset(5*kRate);
        make.centerY.equalTo(cardImgView.mas_centerY).with.offset(0);
    }];
    
    UILabel *moneyLB = [[UILabel alloc] init];
    moneyLB.text = @"1980元";
    moneyLB.textAlignment = NSTextAlignmentRight;
    moneyLB.font = [UIFont systemFontOfSize:13.0*kRate];
    moneyLB.textColor = [UIColor redColor];
    [_firstImgView addSubview:moneyLB];
    [moneyLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*kRate, 20*kRate));
        make.right.equalTo(_firstImgView).with.offset(-50*kRate);
        make.centerY.equalTo(cardImgView.mas_centerY).with.offset(0);
    }];
}

//第二部分：服务项目、详细
- (void)addSecond
{
    _secondView = [[UIView alloc] init];
    _secondView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_secondView];
    [_secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 160*kRate));
        make.top.equalTo(_firstImgView.mas_bottom).with.offset(8*kRate);
        make.left.equalTo(_scrollView).with.offset(0);
    }];
}

//第三部分：推荐人推荐码
- (void)addThird
{
    _thirdView = [[UIView alloc] init];
    _thirdView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_thirdView];
    [_thirdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, kThirdHeight));
        make.top.equalTo(_secondView.mas_bottom).with.offset(8*kRate);
        make.left.equalTo(_scrollView).with.offset(0);
    }];
    
    UILabel *titleLB = [[UILabel alloc] init];
    titleLB.text = @"推荐人推荐码";
    titleLB.textColor = [UIColor colorWithRed:22/255.0 green:129/255.0 blue:251/255.0 alpha:1];
    titleLB.font = [UIFont systemFontOfSize:13.5*kRate];
    [_thirdView addSubview:titleLB];
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*kRate, kThirdHeight));
        make.left.equalTo(_thirdView).with.offset(30*kRate);
        make.top.equalTo(_thirdView).with.offset(0);
    }];
    
    UILabel *valueLB = [[UILabel alloc] init];
    valueLB.text = @"125487524555";
    valueLB.font = [UIFont systemFontOfSize:13.5*kRate];
    valueLB.textColor = [UIColor colorWithWhite:0.6 alpha:1];
    valueLB.adjustsFontSizeToFitWidth = YES;
    [_thirdView addSubview:valueLB];
    [valueLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150*kRate, kThirdHeight));
        make.left.equalTo(titleLB.mas_right).with.offset(10*kRate);
        make.top.equalTo(_thirdView).with.offset(0);
    }];

}

//第四部分：支付方式
- (void)addForth
{
    _forthView = [[UIView alloc] init];
    _forthView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_forthView];
    [_forthView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 120*kRate));
        make.top.equalTo(_thirdView.mas_bottom).with.offset(8*kRate);
        make.left.equalTo(_scrollView).with.offset(0);
    }];
    
    /*** 分割线 ***/
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    [_forthView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 1*kRate));
        make.top.equalTo(_forthView).with.offset(40*kRate);
        make.left.equalTo(_forthView).with.offset(0);
    }];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    [_forthView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 1*kRate));
        make.top.equalTo(_forthView).with.offset(80*kRate);
        make.left.equalTo(_forthView).with.offset(0);
    }];
    /*** 分割线 ***/
    
    //支付方式
    UILabel *titleLB = [[UILabel alloc] init];
    titleLB.text = @"支付方式";
    titleLB.font = [UIFont systemFontOfSize:15.5*kRate weight:0.11];
    [_forthView addSubview:titleLB];
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*kRate, 20*kRate));
        make.left.equalTo(_forthView).with.offset(30*kRate);
        make.top.equalTo(_forthView).with.offset(10*kRate);
    }];
    
    //微信支付
    Way4PaymentOfOpencardView *wechatView = [[Way4PaymentOfOpencardView alloc] init];
    wechatView.type = @"wechat";
    [_forthView addSubview:wechatView];
    [wechatView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 39*kRate));
        make.left.equalTo(_forthView).with.offset(0);
        make.top.equalTo(line1.mas_bottom).with.offset(0);
    }];
    
    //支付宝支付
    Way4PaymentOfOpencardView *alipayView = [[Way4PaymentOfOpencardView alloc] init];
    alipayView.type = @"alipay";
    [_forthView addSubview:alipayView];
    [alipayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 39*kRate));
        make.left.equalTo(_forthView).with.offset(0);
        make.top.equalTo(line2.mas_bottom).with.offset(0);
    }];
}

//第五部分：立即开卡
- (void)addFifth
{
    _openCardBtn = [[UIButton alloc] init];
    [_openCardBtn addTarget:self action:@selector(openCardBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_openCardBtn setTitle:@"立 即 开 卡" forState:UIControlStateNormal];
    [_openCardBtn setBackgroundColor:[UIColor colorWithRed:22/255.0 green:129/255.0 blue:251/255.0 alpha:1]];
    _openCardBtn.titleLabel.font = [UIFont systemFontOfSize:20.0*kRate];
    _openCardBtn.layer.cornerRadius = 5.0*kRate;
    [_scrollView addSubview:_openCardBtn];
    [_openCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-60*kRate, 50*kRate));
        make.left.equalTo(_scrollView).with.offset(30*kRate);
        make.top.equalTo(_forthView.mas_bottom).with.offset(12*kRate);
    }];
}

- (void)openCardBtnAction
{
    NSLog(@"立即开卡");
}

@end
