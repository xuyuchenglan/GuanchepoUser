//
//  CouponInfoView.m
//  管车婆
//
//  Created by 李伟 on 16/10/24.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "CouponInfoView.h"
#import "CouponItemsView.h"
#import "CouponModel.h"

@interface CouponInfoView()
{
    UILabel  *titleLB;
    UILabel  *subTitleLB;
    UIButton *editBtn;//编辑按钮
    UIView   *lineView;//分割线
    
    UIScrollView *contentScrollView;
}
@end

@implementation CouponInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, frame.size.height)];//滑动视图的可视范围
        contentScrollView.backgroundColor = [UIColor whiteColor];
        
        contentScrollView.showsVerticalScrollIndicator = YES;
        contentScrollView.contentSize = CGSizeMake(kScreenWidth, 700*kRate);
        [self addSubview:contentScrollView];
        
        //分割线以及之上的部分
        [self addAboveContent];
        
        //分割线之下的部分
        [self addFollowingContent];
    }
    
    return self;
}

//分割线以及之上的部分
- (void)addAboveContent
{
    titleLB = [[UILabel alloc] init];
    titleLB.font = [UIFont systemFontOfSize:15.0*kRate];
    titleLB.adjustsFontSizeToFitWidth = YES;
    [contentScrollView addSubview:titleLB];
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200*kRate, 20*kRate));
        make.left.equalTo(contentScrollView).with.offset(20*kRate);
        make.top.equalTo(contentScrollView).with.offset(10*kRate);
    }];
    
    subTitleLB = [[UILabel alloc] init];
    subTitleLB.font = [UIFont systemFontOfSize:15.0*kRate];
    subTitleLB.adjustsFontSizeToFitWidth = YES;
    subTitleLB.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    [contentScrollView addSubview:subTitleLB];
    [subTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(250*kRate, 20*kRate));
        make.left.equalTo(contentScrollView).with.offset(20*kRate);
        make.top.equalTo(titleLB.mas_bottom).with.offset(5*kRate);
    }];
    
    editBtn = [[UIButton alloc] init];
    [editBtn setBackgroundImage:[UIImage imageNamed:@"stores_btnBorder_blue"] forState:UIControlStateNormal];
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn setTitleColor:kRGBColor(22, 129, 251) forState:UIControlStateNormal];
    editBtn.titleLabel.font = [UIFont systemFontOfSize:15.0*kRate];
    [editBtn addTarget:self action:@selector(editBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [contentScrollView addSubview:editBtn];
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60*kRate, 30*kRate));
        make.right.equalTo(self).with.offset(-20*kRate);
        make.top.equalTo(contentScrollView).with.offset(15*kRate);
    }];
    
    
    
    
    lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    [contentScrollView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 1*kRate));
        make.top.equalTo(contentScrollView).with.offset(60*kRate);
    }];

}

//分割线下面的部分
- (void)addFollowingContent
{
    CouponModel *m1 = [[CouponModel alloc] init];
    m1.itemImg = @"stores_oil";
    m1.itemCount = @"x1";
    m1.itemTitle = @"美孚一号4升装";
    m1.itemCharge = @"¥300";
    
    NSArray *arr = [NSArray arrayWithObjects:m1, m1, m1, m1, nil];
    
    CouponItemsView *couponItemsView = [[CouponItemsView alloc] init];
    couponItemsView.couponModels = arr;
    [contentScrollView addSubview:couponItemsView];
    [couponItemsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 70*kRate*arr.count));
        make.top.equalTo(lineView.mas_bottom).with.offset(0);
    }];
}

- (void)layoutSubviews
{
    titleLB.text = @"小保养";
    subTitleLB.text = @"建议5000公里或三个月保养一次";
    
}

#pragma make ButtonAction
- (void)editBtnAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"editBtn" object:self];
}

@end
