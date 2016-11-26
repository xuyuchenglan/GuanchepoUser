//
//  ItemAndCountView.m
//  管车婆
//
//  Created by 李伟 on 16/10/20.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "ItemAndCountView.h"
#import "OrderModel.h"


@implementation ItemAndCountView


- (void)setModelsArr:(NSArray *)modelsArr
{
    for (int i = 0; i < modelsArr.count; i++) {
        
        OrderModel *currentModel = modelsArr[i];
        
        UILabel *itemLB = [[UILabel alloc] init];
        itemLB.text = currentModel.itemStr;
        itemLB.font = [UIFont systemFontOfSize:13.0*kRate];
        itemLB.textColor = [UIColor colorWithWhite:0.25 alpha:1];
        [self addSubview:itemLB];
        [itemLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200*kRate, 20*kRate));
            make.top.mas_equalTo(20*kRate*i);
            make.left.equalTo(self).with.offset(0);
        }];
        
        UILabel *itemCountLB = [[UILabel alloc] init];
        itemCountLB.text = currentModel.itemCount;
        itemCountLB.font = [UIFont systemFontOfSize:13.0*kRate];
        itemCountLB.textColor = [UIColor colorWithWhite:0.25 alpha:1];
        itemCountLB.textAlignment = NSTextAlignmentRight;
        [self addSubview:itemCountLB];
        [itemCountLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50*kRate, 20*kRate));
            make.top.mas_equalTo(20*kRate*i);
            make.right.equalTo(self).with.offset(0);
        }];
    }
}



@end
