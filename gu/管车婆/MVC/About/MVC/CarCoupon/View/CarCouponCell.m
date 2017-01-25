//
//  CarCouponCell.m
//  管车婆
//
//  Created by 李伟 on 16/11/3.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "CarCouponCell.h"

@interface CarCouponCell()
{
    UIView      *_upView;
    UILabel     *_couponNameLB;
    UILabel     *_dateLB;
    UILabel     *_storeNameLB;
    UILabel     *_addressLB;
    UILabel     *_serviceLB;
    UIImageView *_isUsedImgView;
}
@end

@implementation CarCouponCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self addUpView];
        [self addDownView];
        
    }
    
    return self;
}

#pragma mark ****** upView ******
- (void)addUpView
{
    _upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 46*kRate)];
    [self.contentView addSubview:_upView];
    
    _couponNameLB = [[UILabel alloc] initWithFrame:CGRectMake(30*kRate, 0, 100*kRate, 46*kRate)];
    _couponNameLB.font = [UIFont systemFontOfSize:15.0*kRate];
    [_upView addSubview:_couponNameLB];
    
    _dateLB = [[UILabel alloc] init];
    _dateLB.font = [UIFont systemFontOfSize:15.0*kRate];
    _dateLB.textAlignment = NSTextAlignmentRight;
    _dateLB.textColor = [UIColor colorWithWhite:0.4 alpha:1];
    [_upView addSubview:_dateLB];
    [_dateLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*kRate, 46*kRate));
        make.right.equalTo(_upView).with.offset(-30*kRate);
        make.top.equalTo(_upView).with.offset(0);
    }];
}


#pragma mark ****** downView ******
- (void)addDownView
{
    _storeNameLB = [[UILabel alloc] init];
    _storeNameLB.font = [UIFont systemFontOfSize:15.0*kRate];
    _storeNameLB.textColor = [UIColor colorWithWhite:0.4 alpha:1];
    _storeNameLB.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_storeNameLB];
    [_storeNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(260*kRate, 25*kRate));
        make.left.equalTo(self.contentView).with.offset(30*kRate);
        make.top.equalTo(_upView.mas_bottom).with.offset(20*kRate);
    }];
    
    _addressLB = [[UILabel alloc] init];
    _addressLB.font = [UIFont systemFontOfSize:15.0*kRate];
    _addressLB.textColor = [UIColor colorWithWhite:0.4 alpha:1];
    _addressLB.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_addressLB];
    [_addressLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(260*kRate, 25*kRate));
        make.left.equalTo(self.contentView).with.offset(30*kRate);
        make.top.equalTo(_storeNameLB.mas_bottom).with.offset(0);
    }];
    
    _serviceLB = [[UILabel alloc] init];
    _serviceLB.font = [UIFont systemFontOfSize:15.0*kRate];
    _serviceLB.textColor = [UIColor colorWithWhite:0.4 alpha:1];
    _serviceLB.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_serviceLB];
    [_serviceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(260*kRate, 25*kRate));
        make.left.equalTo(self.contentView).with.offset(30*kRate);
        make.top.equalTo(_addressLB.mas_bottom).with.offset(0);
    }];
    
    _isUsedImgView = [[UIImageView alloc] init];
    [self.contentView addSubview:_isUsedImgView];
    [_isUsedImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80*kRate, 80*kRate));
        make.right.equalTo(self.contentView).with.offset(-30*kRate);
        make.top.equalTo(_upView.mas_bottom).with.offset(20*kRate);
    }];
    
}


#pragma mark
- (void)layoutSubviews
{
    if ([_type isEqualToString:@"0"]) {//全部
        _upView.backgroundColor = kRGBColor(86, 214, 128);//与“其他”相同
    } else if ([_type isEqualToString:@"1"]) {//洗车券
        _upView.backgroundColor = kRGBColor(170, 213, 253);
    } else if ([_type isEqualToString:@"2"]) {//保养券
        _upView.backgroundColor = kRGBColor(251, 184, 172);
    } else if ([_type isEqualToString:@"3"]) {//美容券
        _upView.backgroundColor = kRGBColor(253, 233, 174);
    } else if ([_type isEqualToString:@"4"]) {//其他
        _upView.backgroundColor = kRGBColor(86, 214, 128);
    }
    if (_carCouponModel.isUsed) {//所有已经使用过的券，变成灰色
        _upView.backgroundColor = kRGBColor(211, 212, 213);
    }
    
    _couponNameLB.text = _carCouponModel.name;
    
    _dateLB.text = [self getDate:YES getTime:NO WithTimeDateStr:_carCouponModel.addtime];
    
    _storeNameLB.text = [NSString stringWithFormat:@"店铺：%@", _carCouponModel.mname];
    
    _addressLB.text = [NSString stringWithFormat:@"地址：%@", _carCouponModel.maddr];

    _serviceLB.text = [NSString stringWithFormat:@"服务：%@", _carCouponModel.name];
    
    if (!_carCouponModel.isUsed) {//未使用
        _isUsedImgView.image = [UIImage imageNamed:@"about_carCoupon_unused"];
    } else {//已使用
        _isUsedImgView.image = [UIImage imageNamed:@"about_carCoupon_used"];
    }
    
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 10*kRate;
    
    [super setFrame:frame];
}

@end
