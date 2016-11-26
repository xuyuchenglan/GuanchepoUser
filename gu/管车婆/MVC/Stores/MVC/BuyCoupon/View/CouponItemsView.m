//
//  CouponItemsView.m
//  管车婆
//
//  Created by 李伟 on 16/10/25.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "CouponItemsView.h"
#import "CouponItemView.h"

@implementation CouponItemsView

- (void)setCouponModels:(NSArray *)couponModels
{
    for (int i = 0; i < couponModels.count; i++) {
        
        CouponItemView *couponItemView = [[CouponItemView alloc] init];
        couponItemView.couponModel = couponModels[i];
        [self addSubview:couponItemView];
        [couponItemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenWidth, 70*kRate));
            make.top.equalTo(self).with.offset(70*kRate*i);
        }];
        
    }
    
}

@end
