//
//  MembershipServicesView.m
//  管车婆
//
//  Created by 李伟 on 16/12/10.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import "MembershipServicesView.h"
#import "MembershipServicesModel.h"

#define kLabelWidth 100
#define kNumberLeft ((kScreenWidth-30*2-kLabelWidth*3)/2)


@interface MembershipServicesView()
{
    UIView *_titleView;
    UIView *_itemsView;
}

@end

@implementation MembershipServicesView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //title
        [self addtitleView];
        
    }
    return self;
}

- (void)setMembershipModels:(NSArray *)membershipModels
{
    //items
    [self addItemsViewWithArr:membershipModels];
}


#pragma mark


//title
- (void)addtitleView
{
    _titleView = [[UIView alloc] init];
    [self addSubview:_titleView];
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 50));
        make.left.equalTo(self).with.offset(0);
        make.top.equalTo(self).with.offset(10);
    }];
    
    UILabel *serviceLB = [[UILabel alloc] init];
    serviceLB.text = @"服  务";
    serviceLB.font = [UIFont systemFontOfSize:18.0];
    serviceLB.textAlignment = NSTextAlignmentCenter;
    [_titleView addSubview:serviceLB];
    [serviceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kLabelWidth, 50));
        make.top.equalTo(_titleView).with.offset(0);
        make.left.equalTo(_titleView).with.offset(30);
    }];
    
    UILabel *numberLB = [[UILabel alloc] init];
    numberLB.text = @"次  数";
    numberLB.font = [UIFont systemFontOfSize:18.0];
    numberLB.textAlignment = NSTextAlignmentCenter;
    [_titleView addSubview:numberLB];
    [numberLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kLabelWidth, 50));
        make.top.equalTo(_titleView).with.offset(0);
        make.left.equalTo(serviceLB.mas_right).with.offset(kNumberLeft);
    }];

    UILabel *remainingLB = [[UILabel alloc] init];
    remainingLB.text = @"剩  余";
    remainingLB.font = [UIFont systemFontOfSize:18.0];
    remainingLB.textAlignment = NSTextAlignmentCenter;
    [_titleView addSubview:remainingLB];
    [remainingLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kLabelWidth, 50));
        make.top.equalTo(_titleView).with.offset(0);
        make.right.equalTo(_titleView).with.offset(-30);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
    [_titleView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 1));
        make.left.equalTo(_titleView).with.offset(0);
        make.bottom.equalTo(_titleView).with.offset(0);
    }];

}

//items
- (void)addItemsViewWithArr:(NSArray *)membershipModels
{
    _itemsView = [[UIView alloc] init];
    [self addSubview:_itemsView];
    [_itemsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 10+30*membershipModels.count));
        make.left.equalTo(self).with.offset(0);
        make.top.equalTo(_titleView.mas_bottom).with.offset(0);
    }];
    
    for (int i = 0; i < membershipModels.count; i++) {
        MembershipServicesModel *currentModel = membershipModels[i];
        [self addItemViewAtIndex:i WithModel:currentModel];
    }
}

      //
- (void)addItemViewAtIndex:(int) index WithModel:(MembershipServicesModel *)model
{
    UILabel *serviceLB = [[UILabel alloc] init];
    serviceLB.text = model.name;
    serviceLB.adjustsFontSizeToFitWidth = YES;
    serviceLB.font = [UIFont systemFontOfSize:16.0];
    serviceLB.textAlignment = NSTextAlignmentCenter;
    [_itemsView addSubview:serviceLB];
    [serviceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kLabelWidth, 20));
        make.top.equalTo(_itemsView).with.offset(10 + 30*index);
        make.left.equalTo(_itemsView).with.offset(30);
    }];
    
    UILabel *countLB = [[UILabel alloc] init];
    countLB.text = model.count;
    countLB.font = [UIFont systemFontOfSize:16.0];
    countLB.textColor = [UIColor colorWithRed:22/255.0 green:29/255.0 blue:252/255.0 alpha:0.7];
    countLB.textAlignment = NSTextAlignmentCenter;
    [_itemsView addSubview:countLB];
    [countLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kLabelWidth, 20));
        make.top.equalTo(_itemsView).with.offset(10 + 30*index);
        make.left.equalTo(serviceLB.mas_right).with.offset(kNumberLeft);
    }];
    
    UILabel *leftCountLB = [[UILabel alloc] init];
    leftCountLB.text = model.leftCount;
    leftCountLB.font = [UIFont systemFontOfSize:16.0];
    leftCountLB.textAlignment = NSTextAlignmentCenter;
    [_itemsView addSubview:leftCountLB];
    [leftCountLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kLabelWidth, 20));
        make.top.equalTo(_itemsView).with.offset(10 + 30*index);
        make.right.equalTo(_itemsView).with.offset(-30);
    }];

}



@end
