//
//  CompanyCardView.m
//  管车婆
//
//  Created by 李伟 on 16/10/31.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "CompanyCardView.h"

#define kSelectBtnHeight 15*kRate
#define kHeadViewHeight  60*kRate

@interface CompanyCardView()
{
    UIImageView *_selectImgView;
    UIImageView *_headImgView;
    UILabel     *_titleLB;
    UILabel     *_englishTitleLB;
}
@property (nonatomic, assign)BOOL isSelected;
@end

@implementation CompanyCardView

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        _isSelected = NO;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [self addGestureRecognizer:tap];
        
    }
    
    return self;
}


- (void)setCardType:(NSString *)cardType
{
    _selectImgView = [[UIImageView alloc] init];
    _selectImgView.image = [UIImage imageNamed:@"home_forth_rechargeFuelcard_company_unselect"];
    [self addSubview:_selectImgView];
    [_selectImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kSelectBtnHeight, kSelectBtnHeight));
        make.left.equalTo(self).with.offset(10*kRate);
        make.top.equalTo(self).with.offset((100*kRate-kSelectBtnHeight)/2);
    }];
    
    _headImgView = [[UIImageView alloc] init];
    [self addSubview:_headImgView];
    [_headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kHeadViewHeight, kHeadViewHeight));
        make.left.equalTo(_selectImgView.mas_right).with.offset(10*kRate);
        make.top.equalTo(self).with.offset((100*kRate-kHeadViewHeight)/2);
    }];
    
    _titleLB = [[UILabel alloc] init];
    _titleLB.font = [UIFont systemFontOfSize:15.0*kRate];
    [self addSubview:_titleLB];
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*kRate, 18*kRate));
        make.left.equalTo(_headImgView.mas_right).with.offset(5*kRate);
        make.top.equalTo(self).with.offset((100-20)*kRate/2);
    }];
    
    _englishTitleLB = [[UILabel alloc] init];
    _englishTitleLB.font = [UIFont systemFontOfSize:16.0*kRate];
    [self addSubview:_englishTitleLB];
    [_englishTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*kRate, 18*kRate));
        make.left.equalTo(_headImgView.mas_right).with.offset(5*kRate);
        make.top.equalTo(_titleLB.mas_bottom).with.offset(0);
    }];
    
    if ([cardType isEqualToString:@"中石油"]) {
        
        _headImgView.image = [UIImage imageNamed:@"home_forth_rechargeFuelcard_zhongshiyou"];
        _titleLB.text = @"中石油加油卡";
        _englishTitleLB.text = @"Zhongshiyou";
        
    } else if ([cardType isEqualToString:@"中石化"]) {
        
        _headImgView.image = [UIImage imageNamed:@"home_forth_rechargeFuelcard_zhongshihua"];
        _titleLB.text = @"中石化加油卡";
        _englishTitleLB.text = @"Zhongshihua";
        
    }
    
}

#pragma mark TapGuesterAction
- (void)tapAction
{
    _isSelected = !_isSelected;
    
    if (_isSelected) {
        [_selectImgView setImage:[UIImage imageNamed:@"home_forth_rechargeFuelcard_selected"]];
    } else {
        [_selectImgView setImage:[UIImage imageNamed:@"home_forth_rechargeFuelcard_company_unselect"]];
    }
}

@end
