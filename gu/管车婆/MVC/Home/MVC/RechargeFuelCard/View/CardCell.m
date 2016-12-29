//
//  CardCell.m
//  管车婆
//
//  Created by 李伟 on 16/10/28.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "CardCell.h"

@interface CardCell()
{
    UIImageView *headImgView;
    UILabel     *titleLB;
    UILabel     *cardNumberLB;
    UILabel     *phoneNumberLB;
    UIButton    *selectBtn;
}
@property (nonatomic, assign)BOOL isSelected;
@end

@implementation CardCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        headImgView = [[UIImageView alloc] init];
        [self addSubview:headImgView];
        [headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(55*kRate, 55*kRate));
            make.left.equalTo(self).with.offset(40*kRate);
            make.top.equalTo(self).with.offset(10*kRate);
        }];
        
        titleLB = [[UILabel alloc] init];
        titleLB.adjustsFontSizeToFitWidth = YES;
        titleLB.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLB];
        [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(90*kRate, 20*kRate));
            make.left.equalTo(self).with.offset(25*kRate);
            make.top.equalTo(headImgView.mas_bottom).with.offset(0);
        }];
        
        cardNumberLB = [[UILabel alloc] init];
        cardNumberLB.adjustsFontSizeToFitWidth = YES;
        cardNumberLB.textColor = kRGBColor(22, 129, 251);
        [self addSubview:cardNumberLB];
        [cardNumberLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(220*kRate, 20*kRate));
            make.left.equalTo(headImgView.mas_right).with.offset(20*kRate);
            make.top.equalTo(self).with.offset(20*kRate);
        }];
        
        phoneNumberLB = [[UILabel alloc] init];
        phoneNumberLB.adjustsFontSizeToFitWidth = YES;
        [self addSubview:phoneNumberLB];
        [phoneNumberLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100*kRate, 20*kRate));
            make.left.equalTo(headImgView.mas_right).with.offset(20*kRate);
            make.top.equalTo(cardNumberLB.mas_bottom).with.offset(5*kRate);
        }];
        
        selectBtn = [[UIButton alloc] init];
        [selectBtn addTarget:self action:@selector(selectBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:selectBtn];
        [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20*kRate, 20*kRate));
            make.top.equalTo(self.contentView).with.offset(35*kRate);
            make.right.equalTo(self).with.offset(-30*kRate);
        }];
        if (_isSelected) {
            [selectBtn setImage:[UIImage imageNamed:@"home_forth_rechargeFuelcard_selected"] forState:UIControlStateNormal];
        } else {
            [selectBtn setImage:[UIImage imageNamed:@"home_forth_rechargeFuelcard_unselected"] forState:UIControlStateNormal];
        }
        
    }
    
    return self;
}

- (void)layoutSubviews
{
    headImgView.image = [UIImage imageNamed:@"home_forth_rechargeFuelcard_zhongshiyou"];
    titleLB.text = @"中石油加油卡";
    cardNumberLB.text = @"1000 1122 5655 6556 515";
    phoneNumberLB.text = @"18653400191";
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 10*kRate;
    [super setFrame:frame];
}

#pragma mark ButtonAction
- (void)selectBtnAction
{
    _isSelected = !_isSelected;
    if (_isSelected) {
        [selectBtn setImage:[UIImage imageNamed:@"home_forth_rechargeFuelcard_selected"] forState:UIControlStateNormal];
    } else {
        [selectBtn setImage:[UIImage imageNamed:@"home_forth_rechargeFuelcard_unselected"] forState:UIControlStateNormal];
    }
}

@end
