//
//  AppointContentInfoView.m
//  管车婆
//
//  Created by 李伟 on 16/8/26.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "AppointContentInfoView.h"

@interface AppointContentInfoView()
{
    UILabel *_dataLabel_number;//订单号码
    UILabel *_dataLabel_time;//下单时间
    UILabel *_dataLabel_appointTime;//预约时间
    UILabel *_dataLabel_xiadanWay;//下单方式
}
@end

@implementation AppointContentInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //第一行
        [self addFirstLine];
        
        //第二行
        [self addSecondLine];
        
        //第三行
        [self addThirdLine];
        
        //第四行
        [self addForthLine];
    }
    return self;
}

//第一行，订单号码
- (void)addFirstLine
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(35*kRate, 5*kRate, 100*kRate, 20*kRate)];
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:@"订单号码"];
    [attrStr addAttribute:NSKernAttributeName value:@(3.0*kRate) range:NSMakeRange(0, attrStr.length)];///文字间间距
    titleLabel.attributedText = attrStr;
    titleLabel.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    titleLabel.font = [UIFont systemFontOfSize:12.0*kRate];
    [self addSubview:titleLabel];
    
    _dataLabel_number = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame) + 20*kRate, 5*kRate, kScreenWidth - CGRectGetMaxX(titleLabel.frame) - 50*kRate, 20*kRate)];
    _dataLabel_number.font = [UIFont systemFontOfSize:12.0*kRate];
    [self addSubview:_dataLabel_number];
    
    
}

//第二行，下单时间
- (void)addSecondLine
{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 30, kScreenWidth, 0.5)];
    lineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    [self addSubview:lineView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 35, 100, 20)];
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:@"下单时间"];
    [attrStr addAttribute:NSKernAttributeName value:@(3.0) range:NSMakeRange(0, attrStr.length)];///文字间间距
    titleLabel.attributedText = attrStr;
    titleLabel.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    titleLabel.font = [UIFont systemFontOfSize:12.0];
    [self addSubview:titleLabel];
    
    _dataLabel_time = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame) + 20, 35, kScreenWidth - CGRectGetMaxX(titleLabel.frame) - 50, 20)];
    _dataLabel_time.font = [UIFont systemFontOfSize:12.0];
    [self addSubview:_dataLabel_time];
    
}

//第三行，预约时间
- (void)addThirdLine
{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth, 0.5)];
    lineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    [self addSubview:lineView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 65, 100, 20)];
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:@"预约时间"];
    [attrStr addAttribute:NSKernAttributeName value:@(3.0) range:NSMakeRange(0, attrStr.length)];///文字间间距
    titleLabel.attributedText = attrStr;
    titleLabel.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    titleLabel.font = [UIFont systemFontOfSize:12.0];
    [self addSubview:titleLabel];
    
    _dataLabel_appointTime = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame) + 20, 65, kScreenWidth - CGRectGetMaxX(titleLabel.frame) - 50, 20)];
    _dataLabel_appointTime.textColor = [UIColor blueColor];
    _dataLabel_appointTime.font = [UIFont systemFontOfSize:12.0];
    [self addSubview:_dataLabel_appointTime];
    
}

//第四行，下单方式
- (void)addForthLine
{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 90, kScreenWidth, 0.5)];
    lineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    [self addSubview:lineView];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 95, 100, 20)];
    titleLabel.font = [UIFont systemFontOfSize:12.0];
    titleLabel.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:@"下单方式"];
    [attrStr addAttribute:NSKernAttributeName value:@(3.0) range:NSMakeRange(0, attrStr.length)];///文字间间距
    titleLabel.attributedText = attrStr;
    [self addSubview:titleLabel];
    
    _dataLabel_xiadanWay = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame) + 20, 95, kScreenWidth - CGRectGetMaxX(titleLabel.frame) - 50, 20)];
    _dataLabel_xiadanWay.font = [UIFont systemFontOfSize:12.0];
    [self addSubview:_dataLabel_xiadanWay];
    
}

- (void)layoutSubviews
{
    _dataLabel_number.text = @"20160803050733666";
    _dataLabel_time.text = @"2016-08-03 05:07:33";
    _dataLabel_appointTime.text = @"2016-08-03 15:07";
    _dataLabel_xiadanWay.text = @"客户扫码";
}

@end
