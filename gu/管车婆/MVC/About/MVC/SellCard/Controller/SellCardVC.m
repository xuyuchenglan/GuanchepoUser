//
//  SellCardVC.m
//  管车婆
//
//  Created by 李伟 on 16/11/4.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "SellCardVC.h"
#import "SellCardView.h"

@interface SellCardVC ()

@end

@implementation SellCardVC

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
    [self setNavigationItemTitle:@"我的邀请码"];
    [self setBackButtonWithImageName:@"back"];
}

#pragma mark ****** 设置下面的内容视图 ******
- (void)addContentView
{
    //第一部分：推广用户和推广佣金
    SellCardView *userAccountView = [[SellCardView alloc] init];
    [self.view addSubview:userAccountView];
    [userAccountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth/2, 60));
        make.left.equalTo(self.view).with.offset(0);
        make.top.equalTo(self.view).with.offset(64);
    }];
    userAccountView.type = @"userAccountView";
    
    SellCardView *moneyAccountView = [[SellCardView alloc] init];
    [self.view addSubview:moneyAccountView];
    [moneyAccountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth/2-1, 60));
        make.left.equalTo(self.view).with.offset(kScreenWidth/2+1);
        make.top.equalTo(self.view).with.offset(64);
    }];
    moneyAccountView.type = @"moneyAccountView";
    
    //第二部分：我的邀请码
    UILabel *invatationCodeLB_value = [[UILabel alloc] init];
    invatationCodeLB_value.textAlignment = NSTextAlignmentCenter;
    invatationCodeLB_value.text = @"WDMAC2583";
    invatationCodeLB_value.font = [UIFont systemFontOfSize:35 weight:0];
    invatationCodeLB_value.textColor = [UIColor colorWithRed:248/255.0 green:161/255.0 blue:31/255.0 alpha:1];
    [self.view addSubview:invatationCodeLB_value];
    [invatationCodeLB_value mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 40));
        make.left.equalTo(self.view).with.offset(0);
        make.top.equalTo(userAccountView.mas_bottom).with.offset(35);
    }];
    
    UILabel *invatationCodeLB_title = [[UILabel alloc] init];
    invatationCodeLB_title.text = @"我的邀请码";
    invatationCodeLB_title.font = [UIFont systemFontOfSize:13.0 weight:0];
    invatationCodeLB_title.textAlignment = NSTextAlignmentCenter;
    invatationCodeLB_title.textColor = [UIColor colorWithWhite:0.2 alpha:1];
    [self.view addSubview:invatationCodeLB_title];
    [invatationCodeLB_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 20));
        make.left.equalTo(self.view).with.offset(0);
        make.top.equalTo(invatationCodeLB_value.mas_bottom).with.offset(5);
    }];
    
    //第三部分：备注说明
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 1));
        make.left.equalTo(self.view).with.offset(0);
        make.top.equalTo(invatationCodeLB_title.mas_bottom).with.offset(35);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    [self.view addSubview:label];
    label.attributedText = [self getAttributedStringWithTitleOne:@"备注说明：" Desc1:@"1.您可以将邀请码分享给您的朋友，如您的朋友成功办卡，您将获得10%提成；" Desc2:@"2.提成会记入您的余额当中，您可进行提现；" Desc3:@"3.提现金额3-5个工作日内打入您的账户。"];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-60, 120));
        make.left.equalTo(self.view).with.offset(30);
        make.top.equalTo(lineView.mas_bottom).with.offset(20);
    }];
}




-(NSMutableAttributedString *)getAttributedStringWithTitleOne:(NSString *)title Desc1:(NSString *)desc1 Desc2:(NSString *)desc2 Desc3:(NSString *)desc3
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5.0];//调整行间距
    
    NSMutableAttributedString *mutaTitle = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",title] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor blackColor],NSParagraphStyleAttributeName:paragraphStyle}];
    
    NSMutableAttributedString *mutaDesc1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",desc1] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor colorWithWhite:0.4 alpha:1],NSParagraphStyleAttributeName:paragraphStyle}];
    
    NSMutableAttributedString *mutaDesc2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",desc2] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor colorWithWhite:0.4 alpha:1],NSParagraphStyleAttributeName:paragraphStyle}];
    
    NSMutableAttributedString *mutaDesc3 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",desc3] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor colorWithWhite:0.4 alpha:1],NSParagraphStyleAttributeName:paragraphStyle}];
    
    [mutaTitle appendAttributedString:mutaDesc1];
    [mutaTitle appendAttributedString:mutaDesc2];
    [mutaTitle appendAttributedString:mutaDesc3];
    
    return mutaTitle;

}


@end
