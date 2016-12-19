//
//  LWCouponCell.m
//  管车婆
//
//  Created by 李伟 on 16/11/10.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "LWCouponCell.h"
#import "AboutCouponModel.h"

#define kCellWidth (kScreenWidth - 10*kRate*2)

@interface LWCouponCell()
{
    UIImageView *_bgImgView;
    UILabel     *_couponTypeLB;
    UILabel     *_conditionLB;
    UILabel     *_timeLB;
    UIView      *_lineView;
    UILabel     *_lb;
}
@end

@implementation LWCouponCell

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
        
        _bgImgView = [[UIImageView alloc] init];
        [self.contentView addSubview:_bgImgView];
        [_bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kCellWidth, (kCellWidth*0.289)));
            make.left.equalTo(self.contentView).with.offset(0);
            make.top.equalTo(self.contentView).with.offset(0);
        }];
        
        _couponTypeLB = [[UILabel alloc] init];
        _couponTypeLB.font = [UIFont fontWithName:@"FZXiaoBiaoSong-B05S" size:20*kRate];
        _couponTypeLB.textColor = [UIColor whiteColor];
        _couponTypeLB.textAlignment = NSTextAlignmentCenter;
        _couponTypeLB.adjustsFontSizeToFitWidth = YES;
        [_bgImgView addSubview:_couponTypeLB];
        [_couponTypeLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(140*kRate, 25*kRate));
            make.top.equalTo(_bgImgView).with.offset(25*kRate);
            make.right.equalTo(_bgImgView).with.offset(-120*kRate);
        }];
        
        _conditionLB = [[UILabel alloc] init];
        _conditionLB.font = [UIFont systemFontOfSize:14.5*kRate];
        _conditionLB.backgroundColor = [UIColor whiteColor];
        _conditionLB.textAlignment = NSTextAlignmentCenter;
        _conditionLB.adjustsFontSizeToFitWidth = YES;
        [_bgImgView addSubview:_conditionLB];
        [_conditionLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(140*kRate, 25*kRate));
            make.top.equalTo(_couponTypeLB.mas_bottom).with.offset(0);
            make.centerX.equalTo(_couponTypeLB.mas_centerX).with.offset(0);
        }];
        
        _timeLB = [[UILabel alloc] init];
        _timeLB.font = [UIFont systemFontOfSize:10.0*kRate];
        _timeLB.textColor = [UIColor whiteColor];
        _timeLB.textAlignment = NSTextAlignmentCenter;
        _timeLB.adjustsFontSizeToFitWidth = YES;
        [_bgImgView addSubview:_timeLB];
        [_timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(140*kRate, 20*kRate));
            make.top.equalTo(_conditionLB.mas_bottom).with.offset(0);
            make.centerX.equalTo(_couponTypeLB.mas_centerX).with.offset(0);
        }];
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor whiteColor];
        [_bgImgView addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(0.5, (kCellWidth*0.289-20*kRate*2)));
            make.top.equalTo(_bgImgView).with.offset(20*kRate);
            make.right.equalTo(_couponTypeLB.mas_left).with.offset(-15*kRate);
        }];
        
        _lb = [[UILabel alloc] init];
        _lb.font = [UIFont fontWithName:@"HoeflerText-Italic" size:35*kRate];
        _lb.textColor = [UIColor whiteColor];
        _lb.textAlignment = NSTextAlignmentCenter;
        [_bgImgView addSubview:_lb];
        [_lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(85*kRate, (kCellWidth*0.289-20*kRate*2)));
            make.right.equalTo(_lineView.mas_left).with.offset(-15*kRate);
            make.top.equalTo(_bgImgView).with.offset(20*kRate);
        }];
        
        
    }
    
    return self;
}


#pragma mark 
- (void)layoutSubviews
{
    if ([_type isEqualToString:@"jianmianquan"]) {
        _bgImgView.image = [UIImage imageNamed:@"jianmianquan"];
        _conditionLB.textColor = [UIColor colorWithRed:254/255.0 green:197/255.0 blue:46/255.0 alpha:1];
    } else if ([_type isEqualToString:@"dazhequan"]) {
        _bgImgView.image = [UIImage imageNamed:@"dazhequan"];
        _conditionLB.textColor = [UIColor colorWithRed:250/255.0 green:81/255.0 blue:31/255.0 alpha:1];
    } else if ([_type isEqualToString:@"tiyanquan"]) {
        _bgImgView.image = [UIImage imageNamed:@"tiyanquan"];
        _conditionLB.textColor = [UIColor colorWithRed:203/255.0 green:96/255.0 blue:252/255.0 alpha:1];
    }
    
    
    
    _couponTypeLB.text = @"管车婆打折券";
//    _conditionLB.text = @"仅限保养美容项目";
    _conditionLB.text = [NSString stringWithFormat:@"仅限%@%@项目", _aboutCouponModel.supername, _aboutCouponModel.sname];
    _timeLB.text = [NSString stringWithFormat:@"使用时间：截止%@", _aboutCouponModel.overdate];
    _lb.text = [NSString stringWithFormat:@"%@折", _aboutCouponModel.discount];
}



- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 15*kRate;
    
    frame.origin.x = 10*kRate;
    frame.size.width = kCellWidth;
    
    [super setFrame:frame];
}

@end
