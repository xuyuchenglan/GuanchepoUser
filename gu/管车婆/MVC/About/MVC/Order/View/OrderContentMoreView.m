//
//  OrderContentMoreView.m
//  管车婆
//
//  Created by 李伟 on 16/8/19.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "OrderContentMoreView.h"

@interface OrderContentMoreView()
{
    UIImageView *_headView;//车行头像
    UILabel     *_nameLabel;//车行名字
    UILabel     *_dataLabel_type;//使用卡种
    UILabel     *_dataLabel_item;//服务项目
    UILabel     *_dataLabel_user;//订单用户
    UILabel     *_dataLabel_fee;//费用
    
}
@end

@implementation OrderContentMoreView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //第一行，车行名字和头像
        [self addFirstLine];
        
        //第二行，卡种、服务项目和用户
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
    
       ///使用卡种
    UILabel *titleLabel_type = [[UILabel alloc] initWithFrame:CGRectMake(35*kRate, 50*kRate, 100*kRate, 15*kRate)];
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:@"使用卡种"];
    [attrStr addAttribute:NSKernAttributeName value:@(3.0*kRate) range:NSMakeRange(0, attrStr.length)];///文字间间距
    titleLabel_type.attributedText = attrStr;
    titleLabel_type.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    titleLabel_type.font = [UIFont systemFontOfSize:12.0*kRate];
    [self addSubview:titleLabel_type];
    
    _dataLabel_type = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 150*kRate, 50*kRate, 100*kRate, 15*kRate)];
    _dataLabel_type.font = [UIFont systemFontOfSize:12.0*kRate];
    [self addSubview:_dataLabel_type];
    
       ///服务项目
    UILabel *titleLabel_item = [[UILabel alloc] initWithFrame:CGRectMake(35*kRate, 75*kRate, 100*kRate, 15*kRate)];
    NSMutableAttributedString* attrStr2 = [[NSMutableAttributedString alloc] initWithString:@"服务项目"];
    [attrStr2 addAttribute:NSKernAttributeName value:@(3.0*kRate) range:NSMakeRange(0, attrStr2.length)];///文字间间距
    titleLabel_item.attributedText = attrStr2;
    titleLabel_item.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    titleLabel_item.font = [UIFont systemFontOfSize:12.0*kRate];
    [self addSubview:titleLabel_item];
    
    _dataLabel_item = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 150*kRate, 75*kRate, 100*kRate, 15*kRate)];
    _dataLabel_item.font = [UIFont systemFontOfSize:12.0*kRate];
    [self addSubview:_dataLabel_item];
    
       ///订单用户
    UILabel *titleLabel_user = [[UILabel alloc] initWithFrame:CGRectMake(35*kRate, 100*kRate, 100*kRate, 15*kRate)];
    NSMutableAttributedString* attrStr3 = [[NSMutableAttributedString alloc] initWithString:@"订单用户"];
    [attrStr3 addAttribute:NSKernAttributeName value:@(3.0*kRate) range:NSMakeRange(0, attrStr3.length)];///文字间间距
    titleLabel_user.attributedText = attrStr3;
    titleLabel_user.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    titleLabel_user.font = [UIFont systemFontOfSize:12.0*kRate];
    [self addSubview:titleLabel_user];
    
    _dataLabel_user = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 150*kRate, 100*kRate, 100*kRate, 15*kRate)];
    _dataLabel_user.font = [UIFont systemFontOfSize:12.0*kRate];
    [self addSubview:_dataLabel_user];
    
       ///分割线
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 120*kRate, kScreenWidth, 0.5*kRate)];
    lineView2.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    [self addSubview:lineView2];
    
       ///费用
    UILabel *titleLabel_fee = [[UILabel alloc] initWithFrame:CGRectMake(35*kRate, 130*kRate, 100*kRate, 15*kRate)];
    NSMutableAttributedString* attrStr4 = [[NSMutableAttributedString alloc] initWithString:@"费用"];
    [attrStr4 addAttribute:NSKernAttributeName value:@(33.0*kRate) range:NSMakeRange(0, attrStr4.length)];///文字间间距
    titleLabel_fee.attributedText = attrStr4;
    titleLabel_fee.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    titleLabel_fee.font = [UIFont systemFontOfSize:12.0*kRate];
    [self addSubview:titleLabel_fee];
    
    _dataLabel_fee = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 150*kRate, 130*kRate, 100*kRate, 15*kRate)];
    _dataLabel_fee.font = [UIFont systemFontOfSize:12.0*kRate];
    [self addSubview:_dataLabel_fee];

    
}

- (void)layoutSubviews
{
    _headView.image = [UIImage imageNamed:@"about_order_head"];
    _nameLabel.text = @"李叔家的洗车店";
    _dataLabel_type.text = @"白银会员";
    _dataLabel_item.text = @"保养";
    _dataLabel_user.text = @"李大伟";
    _dataLabel_fee.text = @"666元";
    
}

@end
