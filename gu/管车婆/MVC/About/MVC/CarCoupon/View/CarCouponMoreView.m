//
//  CarCouponMoreView.m
//  管车婆
//
//  Created by 李伟 on 17/1/12.
//  Copyright © 2017年 远恒网络科技有限公司. All rights reserved.
//

#import "CarCouponMoreView.h"


@interface CarCouponMoreView()
{
    UIImageView *_headView;//车行头像
    UILabel     *_nameLabel;//车行名字
    UILabel     *_dataLabel_type;//使用卡种
    UILabel     *_dataLabel_name;//服务项目
    UILabel     *_dataLabel_phoneNum;//订单用户
    UILabel     *_dataLabel_orderNum;//订单号码
    UILabel     *_dataLabel_couponTime;//买券时间
    UILabel     *_dataLabel_fee;//费用
}

@end


@implementation CarCouponMoreView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //第一行，车行名字和头像
        [self addFirstLine];
        
        //第二行，券种、用户姓名、订单电话、订单号码、买券时间、费用
        [self addSecondLine];
        
    }
    return self;
}

//第一行，车行名字和头像
- (void)addFirstLine
{
    _headView = [[UIImageView alloc] initWithFrame:CGRectMake(20*kRate, 5*kRate, 30*kRate, 30*kRate)];
    _headView.layer.cornerRadius = 15*kRate;
    _headView.layer.masksToBounds = YES;
    [self addSubview:_headView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headView.frame)+10*kRate, 10*kRate, 200*kRate, 20*kRate)];
    _nameLabel.font = [UIFont systemFontOfSize:14.0*kRate];
    [self addSubview:_nameLabel];
    
}

//第二行，卡种、服务项目,用户和项目
- (void)addSecondLine
{
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 40*kRate, kScreenWidth, 0.5*kRate)];
    lineView1.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    [self addSubview:lineView1];
    
    ///使用券种
    UILabel *titleLabel_type = [[UILabel alloc] initWithFrame:CGRectMake(35*kRate, 50*kRate, 100*kRate, 15*kRate)];
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:@"使用券种"];
    [attrStr addAttribute:NSKernAttributeName value:@(3.0*kRate) range:NSMakeRange(0, attrStr.length)];///文字间间距
    titleLabel_type.attributedText = attrStr;
    titleLabel_type.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    titleLabel_type.font = [UIFont systemFontOfSize:12.0*kRate];
    [self addSubview:titleLabel_type];
    
    _dataLabel_type = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 150*kRate, 50*kRate, 150*kRate, 15*kRate)];
    _dataLabel_type.font = [UIFont systemFontOfSize:12.0*kRate];
    _dataLabel_type.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_dataLabel_type];
    
    ///用户姓名
    UILabel *titleLabel_name = [[UILabel alloc] initWithFrame:CGRectMake(35*kRate, 75*kRate, 100*kRate, 15*kRate)];
    NSMutableAttributedString* attrStr2 = [[NSMutableAttributedString alloc] initWithString:@"用户姓名"];
    [attrStr2 addAttribute:NSKernAttributeName value:@(3.0*kRate) range:NSMakeRange(0, attrStr2.length)];///文字间间距
    titleLabel_name.attributedText = attrStr2;
    titleLabel_name.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    titleLabel_name.font = [UIFont systemFontOfSize:12.0*kRate];
    [self addSubview:titleLabel_name];
    
    _dataLabel_name = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 150*kRate, 75*kRate, 150*kRate, 15*kRate)];
    _dataLabel_name.font = [UIFont systemFontOfSize:12.0*kRate];
    _dataLabel_name.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_dataLabel_name];
    
    ///订单电话
    UILabel *titleLabel_phoneNum = [[UILabel alloc] initWithFrame:CGRectMake(35*kRate, 100*kRate, 150*kRate, 15*kRate)];
    NSMutableAttributedString* attrStr3 = [[NSMutableAttributedString alloc] initWithString:@"订单电话"];
    [attrStr3 addAttribute:NSKernAttributeName value:@(3.0*kRate) range:NSMakeRange(0, attrStr3.length)];///文字间间距
    titleLabel_phoneNum.attributedText = attrStr3;
    titleLabel_phoneNum.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    titleLabel_phoneNum.font = [UIFont systemFontOfSize:12.0*kRate];
    [self addSubview:titleLabel_phoneNum];
    
    _dataLabel_phoneNum = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 150*kRate, 100*kRate, 150*kRate, 15*kRate)];
    _dataLabel_phoneNum.font = [UIFont systemFontOfSize:12.0*kRate];
    _dataLabel_phoneNum.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_dataLabel_phoneNum];
    
    ///订单号码
    UILabel *titleLabel_orderNum = [[UILabel alloc] initWithFrame:CGRectMake(35*kRate, 125*kRate, 100*kRate, 15*kRate)];
    NSMutableAttributedString* attrStr4 = [[NSMutableAttributedString alloc] initWithString:@"订单号码"];
    [attrStr4 addAttribute:NSKernAttributeName value:@(3.0*kRate) range:NSMakeRange(0, attrStr3.length)];///文字间间距
    titleLabel_orderNum.attributedText = attrStr4;
    titleLabel_orderNum.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    titleLabel_orderNum.font = [UIFont systemFontOfSize:12.0*kRate];
    [self addSubview:titleLabel_orderNum];
    
    _dataLabel_orderNum = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 150*kRate, 125*kRate, 150*kRate, 15*kRate)];
    _dataLabel_orderNum.font = [UIFont systemFontOfSize:12.0*kRate];
    _dataLabel_orderNum.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_dataLabel_orderNum];
    
    ///买券时间
    UILabel *titleLabel_couponTime = [[UILabel alloc] initWithFrame:CGRectMake(35*kRate, 150*kRate, 100*kRate, 15*kRate)];
    NSMutableAttributedString* attrStr5 = [[NSMutableAttributedString alloc] initWithString:@"买券时间"];
    [attrStr5 addAttribute:NSKernAttributeName value:@(3.0*kRate) range:NSMakeRange(0, attrStr3.length)];///文字间间距
    titleLabel_couponTime.attributedText = attrStr5;
    titleLabel_couponTime.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    titleLabel_couponTime.font = [UIFont systemFontOfSize:12.0*kRate];
    [self addSubview:titleLabel_couponTime];
    
    _dataLabel_couponTime = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 150*kRate, 150*kRate, 150*kRate, 15*kRate)];
    _dataLabel_couponTime.textAlignment = NSTextAlignmentCenter;
    _dataLabel_couponTime.font = [UIFont systemFontOfSize:12.0*kRate];
    [self addSubview:_dataLabel_couponTime];
    
    ///分割线
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 170*kRate, kScreenWidth, 0.5*kRate)];
    lineView2.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    [self addSubview:lineView2];
    
    ///费用
    UILabel *titleLabel_fee = [[UILabel alloc] initWithFrame:CGRectMake(35*kRate, 180*kRate, 100*kRate, 15*kRate)];
    NSMutableAttributedString* attrStr6 = [[NSMutableAttributedString alloc] initWithString:@"费用"];
    [attrStr6 addAttribute:NSKernAttributeName value:@(33.0*kRate) range:NSMakeRange(0, attrStr6.length)];///文字间间距
    titleLabel_fee.attributedText = attrStr6;
    titleLabel_fee.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    titleLabel_fee.font = [UIFont systemFontOfSize:12.0*kRate];
    [self addSubview:titleLabel_fee];
    
    _dataLabel_fee = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 150*kRate, 180*kRate, 150*kRate, 15*kRate)];
    _dataLabel_fee.font = [UIFont systemFontOfSize:12.0*kRate];
    _dataLabel_fee.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_dataLabel_fee];
    
}

- (void)layoutSubviews
{
//    [_headView sd_setImageWithURL:_carCouponModel.merchantUrl placeholderImage:[UIImage imageNamed:@"about_order_head"]];
    _nameLabel.text = _carCouponModel.mname;//商户名字
    _dataLabel_type.text = _carCouponModel.name;//使用券种
    _dataLabel_name.text = [[self getLocalDic] objectForKey:@"realname"];//用户姓名
    _dataLabel_phoneNum.text = [[self getLocalDic] objectForKey:@"phone"];//订单电话
    _dataLabel_orderNum.text = @"";//订单号码
    _dataLabel_couponTime.text = _carCouponModel.addtime;//买券时间
    _dataLabel_fee.text = [NSString stringWithFormat:@"%@元", _carCouponModel.money];//费用
}

@end
