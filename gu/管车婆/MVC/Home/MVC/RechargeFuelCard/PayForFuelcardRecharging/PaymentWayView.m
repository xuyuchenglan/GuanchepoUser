 //
//  PaymentWayView.m
//  管车婆
//
//  Created by 李伟 on 16/11/1.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "PaymentWayView.h"

#define kHeadImgViewWidth  23*kRate

@interface PaymentWayView()
{
    UIImageView *_headImgView;
    UILabel     *_titleLB;
    UILabel     *_subTitleLB;
    UIImageView *_selectImgView;
}
@property (nonatomic, assign)BOOL isSelected;
@end

@implementation PaymentWayView

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        _isSelected = NO;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [self addGestureRecognizer:tap];
        
    }
    
    return self;
}

- (void)tapAction
{
    _isSelected = !_isSelected;
    
    if (_isSelected) {
        _selectImgView.image = [UIImage imageNamed:@"pay_selected"];
    } else {
        _selectImgView.image = [UIImage imageNamed:@"pay_unselected"];
    }
}

- (void)setType:(NSString *)type
{
    _headImgView = [[UIImageView alloc] init];
    [self addSubview:_headImgView];
    [_headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kHeadImgViewWidth, kHeadImgViewWidth*0.8));
        make.left.equalTo(self).with.offset(30*kRate);
        make.top.equalTo(self).with.offset((55*kRate-kHeadImgViewWidth*0.8)/2);
    }];
    
    _titleLB = [[UILabel alloc] init];
    _titleLB.font = [UIFont systemFontOfSize:14.0*kRate];
    [self addSubview:_titleLB];
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200*kRate, 17.5*kRate));
        make.top.equalTo(self).with.offset(10*kRate);
        make.left.equalTo(_headImgView.mas_right).with.offset(15*kRate);
    }];
    
    _subTitleLB = [[UILabel alloc] init];
    _subTitleLB.font = [UIFont systemFontOfSize:12.0*kRate];
    _subTitleLB.textColor = [UIColor colorWithWhite:0.6 alpha:1];
    [self addSubview:_subTitleLB];
    [_subTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200*kRate, 17.5*kRate));
        make.top.equalTo(_titleLB.mas_bottom).with.offset(0);
        make.left.equalTo(_headImgView.mas_right).with.offset(15*kRate);
    }];
    
    _selectImgView = [[UIImageView alloc] init];
    _selectImgView.image = [UIImage imageNamed:@"pay_unselected"];
    [self addSubview:_selectImgView];
    [_selectImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(15*kRate, 15*kRate));
        make.top.equalTo(self).with.offset((55-15)*kRate/2);
        make.right.equalTo(self).with.offset(-30*kRate);
    }];
    
    
    if ([type isEqualToString:@"wechat"]) {
        
        _headImgView.image = [UIImage imageNamed:@"wechat"];
        _titleLB.text = @"微信支付";
        _subTitleLB.text = @"推荐安装微信5.0以上的用户使用";
        
    } else if ([type isEqualToString:@"alipay"]) {
        
        _headImgView.image = [UIImage imageNamed:@"alipay"];
        _titleLB.text = @"支付宝支付";
        _subTitleLB.text = @"推荐支付宝用户使用";
        
    }
}

@end
