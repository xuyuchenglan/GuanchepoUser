//
//  ExchangePointsView.m
//  管车婆
//
//  Created by 李伟 on 16/11/3.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "ExchangePointsView.h"

#define kHeadImgViewWidth (frame.size.width - 8*kRate*2)
#define kBottomHeight     (frame.size.height - CGRectGetMaxY(_titleLB.frame) - 8*kRate)

@interface ExchangePointsView()
{
    UIImageView *_bgImgView;
    UIImageView *_headImgView;
    UILabel     *_titleLB;
    UILabel     *_pointsLB;
    UILabel     *_exchangePeopleAccountLB;
}
@end

@implementation ExchangePointsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _bgImgView.image = [UIImage imageNamed:@"about_exchangePoints_bg"];
        [self addSubview:_bgImgView];
        
        _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(8*kRate, 8*kRate, kHeadImgViewWidth, kHeadImgViewWidth)];
        [self addSubview:_headImgView];
        
        _titleLB = [[UILabel alloc] initWithFrame:CGRectMake(8*kRate, CGRectGetMaxY(_headImgView.frame), kHeadImgViewWidth, 30*kRate)];
        _titleLB.numberOfLines = 2;
        _titleLB.font = [UIFont systemFontOfSize:10.0*kRate];
        [self addSubview:_titleLB];
        
        _pointsLB = [[UILabel alloc] initWithFrame:CGRectMake(8*kRate, CGRectGetMaxY(_titleLB.frame), kHeadImgViewWidth/2, kBottomHeight)];
        _pointsLB.font = [UIFont systemFontOfSize:13.0*kRate];
        _pointsLB.textColor = [UIColor redColor];
        [self addSubview:_pointsLB];
        
        _exchangePeopleAccountLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_pointsLB.frame), CGRectGetMaxY(_titleLB.frame), kHeadImgViewWidth/2, kBottomHeight)];
        _exchangePeopleAccountLB.font = [UIFont systemFontOfSize:8.0*kRate];
        _exchangePeopleAccountLB.textColor = [UIColor colorWithWhite:0.5 alpha:1];
        _exchangePeopleAccountLB.textAlignment = NSTextAlignmentRight;
        [self addSubview:_exchangePeopleAccountLB];
        
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    _headImgView.image = [UIImage imageNamed:@"about_exchangePoints_head"];
    _titleLB.text = @"移动50元钱快充值电信联通河南河北卡秒充全国秒充话费50块";
    _pointsLB.text = @"6000积分";
    _exchangePeopleAccountLB.text = @"已有666人兑换";
}
@end
