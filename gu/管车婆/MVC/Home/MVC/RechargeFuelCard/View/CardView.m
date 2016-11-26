//
//  CardView.m
//  管车婆
//
//  Created by 李伟 on 16/10/27.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "CardView.h"
#import "ChangeFuelcardVC.h"

@interface CardView()
{
    UIImageView *headImgView;
    UILabel     *titleLB;
    UILabel     *cardNumberLB;
    UILabel     *phoneNumberLB;
    UIButton    *changeBtn;
}
@end

@implementation CardView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        headImgView = [[UIImageView alloc] init];
        [self addSubview:headImgView];
        [headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(55*kRate, 55*kRate));
            make.left.equalTo(self).with.offset(40*kRate);
            make.top.equalTo(self).with.offset(10*kRate);
        }];
        
        titleLB = [[UILabel alloc] init];
        titleLB.adjustsFontSizeToFitWidth = YES;
        titleLB.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLB];
        [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(90*kRate, 20*kRate));
            make.left.equalTo(self).with.offset(25*kRate);
            make.top.equalTo(headImgView.mas_bottom).with.offset(0);
        }];
        
        cardNumberLB = [[UILabel alloc] init];
        cardNumberLB.adjustsFontSizeToFitWidth = YES;
        cardNumberLB.textColor = [UIColor colorWithRed:22/255.0 green:129/255.0 blue:251/255.0 alpha:1];
        [self addSubview:cardNumberLB];
        [cardNumberLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(220*kRate, 20*kRate));
            make.left.equalTo(headImgView.mas_right).with.offset(20*kRate);
            make.top.equalTo(self).with.offset(20*kRate);
        }];
        
        phoneNumberLB = [[UILabel alloc] init];
        phoneNumberLB.adjustsFontSizeToFitWidth = YES;
        [self addSubview:phoneNumberLB];
        [phoneNumberLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100*kRate, 20*kRate));
            make.left.equalTo(headImgView.mas_right).with.offset(20*kRate);
            make.top.equalTo(cardNumberLB.mas_bottom).with.offset(5*kRate);
        }];
        
        changeBtn = [[UIButton alloc] init];
        changeBtn.backgroundColor = [UIColor colorWithRed:22/255.0 green:129/255.0 blue:251/255.0 alpha:1];
        changeBtn.layer.cornerRadius = 3.0*kRate;
        [changeBtn setTitle:@"更换" forState:UIControlStateNormal];
        changeBtn.titleLabel.font = [UIFont systemFontOfSize:16.0*kRate];
        [changeBtn addTarget:self action:@selector(changeBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:changeBtn];
        [changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60*kRate, 30*kRate));
            make.top.equalTo(cardNumberLB.mas_bottom).with.offset(5*kRate);
            make.right.equalTo(self).with.offset(-30*kRate);
        }];
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    headImgView.image = [UIImage imageNamed:@"home_forth_rechargeFuelcard_zhongshiyou"];
    titleLB.text = @"中石油加油卡";
    cardNumberLB.text = @"1000 1122 5655 6556 515";
    phoneNumberLB.text = @"18653400191";
}

#pragma mark ButtonAction
- (void)changeBtnAction
{
    NSLog(@"更换");
    
    ChangeFuelcardVC *changeFuelcardVC = [[ChangeFuelcardVC alloc] init];
    changeFuelcardVC.hidesBottomBarWhenPushed = YES;
    [[self findResponderVC].navigationController pushViewController:changeFuelcardVC animated:NO];
    changeFuelcardVC.hidesBottomBarWhenPushed = NO;
}

- (UIViewController *)findResponderVC
{
    UIResponder *responder_vc = (UIResponder *)self;
    do {
        responder_vc = responder_vc.nextResponder;
    } while (![responder_vc isKindOfClass:[UIViewController class]]);
    
    UIViewController *vc = (UIViewController *)responder_vc;
    
    return vc;
}

@end
