//
//  RechargeFuelcardInfoContentView.m
//  管车婆
//
//  Created by 李伟 on 16/11/1.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "RechargeFuelcardInfoContentView.h"

@interface RechargeFuelcardInfoContentView()
{
    UIView *_line1;
    UIView *_line2;
    
    UILabel *_itemValueLB;
    UILabel *_originalChargeValueLB;
    UILabel *_discountValueLB;
}
@end

@implementation RechargeFuelcardInfoContentView

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        /***分割线***/
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
        [self addSubview:_line1];
        [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenWidth, 1*kRate));
            make.top.equalTo(self).with.offset(45*kRate);
            make.left.equalTo(self).with.offset(0);
        }];
        
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
        [self addSubview:_line2];
        [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenWidth, 1*kRate));
            make.top.equalTo(self).with.offset(90*kRate);
            make.left.equalTo(self).with.offset(0);
        }];
        /***分割线***/
        
        //服务项目
        UILabel *itemLB = [[UILabel alloc] init];
        itemLB.font = [UIFont systemFontOfSize:15.0*kRate];
        itemLB.text = @"服务项目";
        [self addSubview:itemLB];
        [itemLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(100*kRate, 45*kRate));
            make.left.equalTo(self).with.offset(30*kRate);
            make.top.equalTo(self).with.offset(0);
        }];
        
        _itemValueLB = [[UILabel alloc] init];
        _itemValueLB.font = [UIFont systemFontOfSize:15.0*kRate];
        _itemValueLB.textAlignment = NSTextAlignmentRight;
        _itemValueLB.textColor = [UIColor colorWithWhite:0.3 alpha:1];
        [self addSubview:_itemValueLB];
        [_itemValueLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(100*kRate, 45*kRate));
            make.right.equalTo(self).with.offset(-30*kRate);
            make.top.equalTo(self).with.offset(0);
        }];
        
        //原价
        UILabel *originalChargeLB = [[UILabel alloc] init];
        originalChargeLB.font = [UIFont systemFontOfSize:15.0*kRate];
        originalChargeLB.text = @"原       价";
        [self addSubview:originalChargeLB];
        [originalChargeLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(100*kRate, 44*kRate));
            make.left.equalTo(self).with.offset(30*kRate);
            make.top.equalTo(_line1.mas_bottom).with.offset(0);
        }];
        
        _originalChargeValueLB = [[UILabel alloc] init];
        _originalChargeValueLB.font = [UIFont systemFontOfSize:15.0*kRate];
        _originalChargeValueLB.textAlignment = NSTextAlignmentRight;
        _originalChargeValueLB.textColor = [UIColor colorWithWhite:0.3 alpha:1];
        [self addSubview:_originalChargeValueLB];
        [_originalChargeValueLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(100*kRate, 44*kRate));
            make.right.equalTo(self).with.offset(-30*kRate);
            make.top.equalTo(_line1.mas_bottom).with.offset(0);
        }];
        
        
        //优惠
        UILabel *discountLB = [[UILabel alloc] init];
        discountLB.font = [UIFont systemFontOfSize:15.0*kRate];
        discountLB.textColor = [UIColor redColor];
        discountLB.text = @"优       惠";
        [self addSubview:discountLB];
        [discountLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(100*kRate, 44*kRate));
            make.left.equalTo(self).with.offset(30*kRate);
            make.top.equalTo(_line2.mas_bottom).with.offset(0);
        }];

        _discountValueLB = [[UILabel alloc] init];
        _discountValueLB.font = [UIFont systemFontOfSize:15.0*kRate];
        _discountValueLB.textAlignment = NSTextAlignmentRight;
        _discountValueLB.textColor = [UIColor redColor];
        [self addSubview:_discountValueLB];
        [_discountValueLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(100*kRate, 44*kRate));
            make.right.equalTo(self).with.offset(-30*kRate);
            make.top.equalTo(_line2.mas_bottom).with.offset(0);
        }];
    }
    
    return self;
}

- (void)layoutSubviews
{
    _itemValueLB.text = @"油卡充值";
    _originalChargeValueLB.text = @"100";
    _discountValueLB.text = @"-10";
}

@end
