//
//  ServiceItemsView.m
//  管车婆
//
//  Created by 李伟 on 16/11/9.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "ServiceItemsView.h"
#import "MembershipServicesModel.h"

#define kLabelWidth 100*kRate

@interface ServiceItemsView()
{
    UIView *_titleView;
    UIView *_itemsView;
}
@end

@implementation ServiceItemsView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //title
        [self addtitleView];
        
    }
    return self;
}

- (void)setMembershipServiceModels:(NSArray *)membershipServiceModels
{
    _membershipServiceModels = membershipServiceModels;
    
    [self addItemsView];
}


#pragma mark


//title
- (void)addtitleView
{
    _titleView = [[UIView alloc] init];
    [self addSubview:_titleView];
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 40*kRate));
        make.left.equalTo(self).with.offset(0);
        make.top.equalTo(self).with.offset(0);
    }];
    
    UILabel *serviceLB = [[UILabel alloc] init];
    serviceLB.text = @"服  务";
    serviceLB.font = [UIFont systemFontOfSize:18.0*kRate];
    serviceLB.textAlignment = NSTextAlignmentCenter;
    [_titleView addSubview:serviceLB];
    [serviceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kLabelWidth, 40*kRate));
        make.top.equalTo(_titleView).with.offset(0);
        make.left.equalTo(_titleView).with.offset(30*kRate);
    }];
    
    UILabel *numberLB = [[UILabel alloc] init];
    numberLB.text = @"次  数";
    numberLB.font = [UIFont systemFontOfSize:18.0*kRate];
    numberLB.textAlignment = NSTextAlignmentCenter;
    [_titleView addSubview:numberLB];
    [numberLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kLabelWidth, 40*kRate));
        make.top.equalTo(_titleView).with.offset(0);
        make.right.equalTo(_titleView).with.offset(-30*kRate);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
    [_titleView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 1*kRate));
        make.left.equalTo(_titleView).with.offset(0);
        make.bottom.equalTo(_titleView).with.offset(0);
    }];
    
}

//items
- (void)addItemsView
{
    _itemsView = [[UIView alloc] init];
    [self addSubview:_itemsView];
    [_itemsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 10*kRate+30*kRate*_membershipServiceModels.count));
        make.left.equalTo(self).with.offset(0);
        make.top.equalTo(_titleView.mas_bottom).with.offset(0);
    }];
    
    for (int i = 0; i < _membershipServiceModels.count; i++) {
        MembershipServicesModel *currentModel = _membershipServiceModels[i];
        [self addItemViewAtIndex:i WithModel:currentModel];
    }
}

//
- (void)addItemViewAtIndex:(int) index WithModel:(MembershipServicesModel *)model
{
    UILabel *serviceLB = [[UILabel alloc] init];
    serviceLB.text = model.name;
    serviceLB.adjustsFontSizeToFitWidth = YES;
    serviceLB.font = [UIFont systemFontOfSize:16.0*kRate];
    serviceLB.textAlignment = NSTextAlignmentCenter;
    [_itemsView addSubview:serviceLB];
    [serviceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kLabelWidth, 20*kRate));
        make.top.equalTo(_itemsView).with.offset(10*kRate+30*kRate*index);
        make.left.equalTo(_itemsView).with.offset(30*kRate);
    }];
    
    UILabel *countLB = [[UILabel alloc] init];
    countLB.text = model.count;
    countLB.font = [UIFont systemFontOfSize:16.0*kRate];
    countLB.textColor = [UIColor colorWithRed:22/255.0 green:29/255.0 blue:252/255.0 alpha:0.7];
    countLB.textAlignment = NSTextAlignmentCenter;
    [_itemsView addSubview:countLB];
    [countLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kLabelWidth, 20*kRate));
        make.top.equalTo(_itemsView).with.offset(10*kRate+30*kRate*index);
        make.right.equalTo(_titleView).with.offset(-30*kRate);
    }];
    
}


@end
