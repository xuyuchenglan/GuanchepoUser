//
//  SellCardView.m
//  管车婆
//
//  Created by 李伟 on 16/11/4.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "SellCardView.h"

@interface SellCardView()
{
    UILabel     *_accountLB;
}
@end

@implementation SellCardView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setType:(NSString *)type
{
    _accountLB = [[UILabel alloc] init];
    _accountLB.font = [UIFont systemFontOfSize:13.0 weight:0];
    _accountLB.textAlignment = NSTextAlignmentCenter;
    _accountLB.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    [self addSubview:_accountLB];
    [_accountLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth/2, 15));
        make.left.equalTo(self).with.offset(0);
        make.top.equalTo(self).with.offset(10);
    }];
    
    UIView *titleView = [[UIView alloc] init];
    [self addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth/2, 20));
        make.left.equalTo(self).with.offset(0);
        make.top.equalTo(_accountLB.mas_bottom).with.offset(8);
    }];
    
    UIImageView *headImgView = [[UIImageView alloc] init];
    if ([type isEqualToString:@"userAccountView"]) {
        headImgView.image = [UIImage imageNamed:@"about_tableview_sellcard_useracount"];
    } else if ([type isEqualToString:@"moneyAccountView"]) {
        headImgView.image = [UIImage imageNamed:@"about_tableview_sellcard_money"];
    }
    [titleView addSubview:headImgView];
    [headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        if ([type isEqualToString:@"userAccountView"]) {
            make.size.mas_equalTo(CGSizeMake(15, 15));
        } else if ([type isEqualToString:@"moneyAccountView"]) {
            make.size.mas_equalTo(CGSizeMake(10, 15));
        }
        make.left.equalTo(titleView).with.offset((kScreenWidth/2 - 15 - 95)/2);
        make.top.equalTo(titleView).with.offset(2.5);
    }];
    
    UILabel *titleLB = [[UILabel alloc] init];
    titleLB.font = [UIFont systemFontOfSize:15.0 weight:0.1];
    if ([type isEqualToString:@"userAccountView"]) {
        titleLB.text = @"累计推广用户";
    } else if ([type isEqualToString:@"moneyAccountView"]) {
        titleLB.text = @"累计推广佣金";
    }
    [titleView addSubview:titleLB];
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(95, 20));
        make.left.equalTo(headImgView.mas_right).with.offset(3);
        make.top.equalTo(titleView).with.offset(0);
    }];
    
    
    
    
}

- (void)layoutSubviews
{
    _accountLB.text = @"888元/人";
}

@end
