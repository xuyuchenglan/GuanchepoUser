//
//  CouponCell.m
//  管车婆
//
//  Created by 李伟 on 16/10/24.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "CouponCell.h"

@interface CouponCell()
{
    UILabel  *_titleLB;
    UILabel  *_subTitleLB;
    UILabel  *_chargeLB;
    UIButton *_payBtn;
}
@end

@implementation CouponCell

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
        
        _titleLB = [[UILabel alloc] initWithFrame:CGRectMake(20*kRate, 15*kRate, 200*kRate, 20*kRate)];
        _titleLB.font = [UIFont systemFontOfSize:15.0*kRate];
        _titleLB.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_titleLB];
        
        _chargeLB = [[UILabel alloc] init];
        _chargeLB.textAlignment = NSTextAlignmentRight;
        _chargeLB.textColor = [UIColor redColor];
        _chargeLB.font = [UIFont systemFontOfSize:15.0*kRate];
        [self.contentView addSubview:_chargeLB];
        [_chargeLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60*kRate, 20*kRate));
            make.right.equalTo(self.contentView).with.offset(-23*kRate);
            make.top.equalTo(self.contentView).with.offset(15*kRate);
        }];
        
        _subTitleLB = [[UILabel alloc] init];
        _subTitleLB.font = [UIFont systemFontOfSize:13.0*kRate];
        _subTitleLB.numberOfLines = 2;
        _subTitleLB.textColor = [UIColor colorWithWhite:0.3 alpha:1];
        [self.contentView addSubview:_subTitleLB];
        [_subTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200*kRate, 40*kRate));
            make.top.equalTo(_titleLB.mas_bottom).with.offset(5*kRate);
            make.left.equalTo(self.contentView).with.offset(20*kRate);
        }];
        
        _payBtn = [[UIButton alloc] init];
        [_payBtn setTitle:@"购买" forState:UIControlStateNormal];
        _payBtn.titleLabel.font = [UIFont systemFontOfSize:15.0*kRate];
        _payBtn.backgroundColor = kRGBColor(22, 129, 251);
        _payBtn.layer.cornerRadius = 6.0*kRate;
        [self.contentView addSubview:_payBtn];
        [_payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80*kRate, 35*kRate));
            make.right.equalTo(self.contentView).with.offset(-20*kRate);
            make.top.equalTo(_titleLB.mas_bottom).with.offset(10*kRate);
        }];
        
        
        
    }
    
    return self;
}

- (void)layoutSubviews
{
    _titleLB.text = @"普通洗车-5座轿车";
    _chargeLB.text = @"66元";
    _subTitleLB.text = @"整车泡沫清洗， 轮胎轮毂冲洗，车内吸尘，内饰简单清洗";
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 10*kRate;
    [super setFrame:frame];
}

@end
