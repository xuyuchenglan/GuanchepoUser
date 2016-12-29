//
//  RechargeFuelCardVC.m
//  管车婆
//
//  Created by 李伟 on 16/10/8.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "RechargeFuelCardVC.h"
#import "CardView.h"
#import "CardRechargeMoneyView.h"
#import "PayForFuelCardRechargingVC.h"

#define kCardRechargeMoneyViewWidth (kScreenWidth-30*kRate*4)/3
#define kNonFuelCardImgViewWidth    230*kRate

@interface RechargeFuelCardVC ()<UITextFieldDelegate>
{
    CardView              *cardView;
    CardRechargeMoneyView *cardRechargeMoneyView100;
    UILabel               *savedMoneyLB;
}
@end

@implementation RechargeFuelCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kRGBColor(233, 239, 239);
    
    //设置导航栏
    [self addNavBar];
    
    //设置下面的内容
    if (_isExistFuelCard) {
        [self addFuelCardContentView];
    } else {
        [self addNonFuelCardContent];
    }
    

}

#pragma mark *************   设置导航栏   *********************
- (void)addNavBar
{
    [self setNavigationItemTitle:@"加油卡充值"];
    
    [self setBackButtonWithImageName:@"back"];
}

#pragma mark *********   设置下面的内容   **************
#pragma mark --- <一>有加油卡
- (void)addFuelCardContentView
{
    //加油卡
    [self addCardView];
    
    //充值金额
    [self addCardRechargeMoneyView];
    
    //自定义充值金额
    [self addDIYMoneyView];
    
    //立即充值按钮
    [self addRechargeBtn];
    
}

//加油卡
- (void)addCardView
{
    UILabel *cardTitle = [[UILabel alloc] init];
    cardTitle.text = @"加油卡";
    cardTitle.font = [UIFont systemFontOfSize:15*kRate];
    [self.view addSubview:cardTitle];
    [cardTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150*kRate, 20*kRate));
        make.left.equalTo(self.view).with.offset(30*kRate);
        make.top.equalTo(self.view).with.offset(64 + 10*kRate);
    }];
    
    cardView = [[CardView alloc] init];
    cardView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:cardView];
    [cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 90*kRate));
        make.top.equalTo(cardTitle.mas_bottom).with.offset(10*kRate);
    }];

}

//充值金额
- (void)addCardRechargeMoneyView
{
    UILabel *moneyTitle = [[UILabel alloc] init];
    moneyTitle.text = @"充值金额";
    moneyTitle.font = [UIFont systemFontOfSize:15*kRate];
    [self.view addSubview:moneyTitle];
    [moneyTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150*kRate, 20*kRate));
        make.left.equalTo(self.view).with.offset(30*kRate);
        make.top.equalTo(cardView.mas_bottom).with.offset(20*kRate);
    }];
    
    //100
    cardRechargeMoneyView100 = [[CardRechargeMoneyView alloc] init];
    [self.view addSubview:cardRechargeMoneyView100];
    [cardRechargeMoneyView100 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kCardRechargeMoneyViewWidth, 50*kRate));
        make.left.equalTo(self.view).with.offset(30*kRate);
        make.top.equalTo(moneyTitle.mas_bottom).with.offset(10*kRate);
    }];
    cardRechargeMoneyView100.money = @"100";
    
    //500
    CardRechargeMoneyView *cardRechargeMoneyView500 = [[CardRechargeMoneyView alloc] init];
    [self.view addSubview:cardRechargeMoneyView500];
    [cardRechargeMoneyView500 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kCardRechargeMoneyViewWidth, 50*kRate));
        make.left.equalTo(self.view).with.offset(30*kRate*2 + kCardRechargeMoneyViewWidth);
        make.top.equalTo(moneyTitle.mas_bottom).with.offset(10*kRate);
    }];
    cardRechargeMoneyView500.money = @"500";
    
    //1000
    CardRechargeMoneyView *cardRechargeMoneyView1000 = [[CardRechargeMoneyView alloc] init];
    [self.view addSubview:cardRechargeMoneyView1000];
    [cardRechargeMoneyView1000 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kCardRechargeMoneyViewWidth, 50*kRate));
        make.left.equalTo(self.view).with.offset(30*kRate*3 + kCardRechargeMoneyViewWidth*2);
        make.top.equalTo(moneyTitle.mas_bottom).with.offset(10*kRate);
    }];
    cardRechargeMoneyView1000.money = @"1000";
}

//自定义充值金额
- (void)addDIYMoneyView
{
    UILabel *moneyTitleDIY = [[UILabel alloc] init];
    moneyTitleDIY.text = @"自定义充值金额";
    moneyTitleDIY.font = [UIFont systemFontOfSize:15*kRate];
    [self.view addSubview:moneyTitleDIY];
    [moneyTitleDIY mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150*kRate, 20*kRate));
        make.left.equalTo(self.view).with.offset(30*kRate);
        make.top.equalTo(cardRechargeMoneyView100.mas_bottom).with.offset(20*kRate);
    }];
    
    UITextField *tf = [[UITextField alloc] init];
    tf.delegate = self;
    [tf setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:tf];
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 60*kRate, 50*kRate));
        make.left.equalTo(self.view).with.offset(30*kRate);
        make.top.equalTo(moneyTitleDIY.mas_bottom).with.offset(10*kRate);
    }];
    
    savedMoneyLB = [[UILabel alloc] init];
    savedMoneyLB.text = @"为您节省  1元";
    savedMoneyLB.textAlignment = NSTextAlignmentRight;
    savedMoneyLB.font = [UIFont systemFontOfSize:15.0*kRate];
    [self.view addSubview:savedMoneyLB];
    [savedMoneyLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150*kRate, 20*kRate));
        make.right.equalTo(self.view).with.offset(-30*kRate);
        make.top.equalTo(tf.mas_bottom).with.offset(10*kRate);
    }];

}

//立即充值按钮
- (void)addRechargeBtn
{
    UIButton *rechargeBtn = [[UIButton alloc] init];
    rechargeBtn.layer.cornerRadius = 5.0*kRate;
    rechargeBtn.titleLabel.font = [UIFont systemFontOfSize:19.0*kRate];
    [rechargeBtn setTitle:@"立即充值" forState:UIControlStateNormal];
    [rechargeBtn setBackgroundColor:kRGBColor(22, 129, 251)];
    [rechargeBtn addTarget:self action:@selector(rechargeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rechargeBtn];
    [rechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 60*kRate, 50*kRate));
        make.left.equalTo(self.view).with.offset(30*kRate);
        make.top.mas_equalTo(savedMoneyLB.mas_bottom).with.offset(30*kRate);
    }];
}

#pragma mark --------- UIButtonAction
- (void)rechargeBtnAction
{
    NSLog(@"立即充值");
    
    PayForFuelCardRechargingVC *pay4FuelcardRechargingVC = [[PayForFuelCardRechargingVC alloc] init];
    [self.navigationController pushViewController:pay4FuelcardRechargingVC animated:NO];
}

#pragma mark --- <二>没有加油卡
- (void)addNonFuelCardContent
{
    //“暂无加油卡”视图
    UIImageView *nonFuelCardImgView = [[UIImageView alloc] init];
    nonFuelCardImgView.image = [UIImage imageNamed:@"home_forth_rechargeFuelcard_noFuelcard"];
    [self.view addSubview:nonFuelCardImgView];
    [nonFuelCardImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kNonFuelCardImgViewWidth, kNonFuelCardImgViewWidth*0.756));
        make.left.equalTo(self.view).with.offset((kScreenWidth-kNonFuelCardImgViewWidth)/2);
        make.top.equalTo(self.view).with.offset(64 + 30*kRate);
    }];
    
    UILabel *nonFuelCardLB = [[UILabel alloc] init];
    nonFuelCardLB.textColor = kRGBColor(156, 157, 158);
    nonFuelCardLB.textAlignment  = NSTextAlignmentCenter;
    nonFuelCardLB.font = [UIFont systemFontOfSize:15.0*kRate];
    nonFuelCardLB.text = @"暂无加油卡";
    [self.view addSubview:nonFuelCardLB];
    [nonFuelCardLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 20*kRate));
        make.top.equalTo(nonFuelCardImgView.mas_bottom).with.offset(0);
    }];
    
    
    //"添加加油卡"按钮
    UIButton *addFuelcardBtn = [[UIButton alloc] init];
    addFuelcardBtn.backgroundColor = kRGBColor(22, 129, 251);
    addFuelcardBtn.layer.cornerRadius = 3.0*kRate;
    [addFuelcardBtn setTitle:@"添 加 加 油 卡" forState:UIControlStateNormal];
    [self.view addSubview:addFuelcardBtn];
    [addFuelcardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 60*kRate, 50*kRate));
        make.left.equalTo(self.view).with.offset(30*kRate);
        make.top.equalTo(nonFuelCardLB.mas_bottom).with.offset(40*kRate);
    }];
}

@end
