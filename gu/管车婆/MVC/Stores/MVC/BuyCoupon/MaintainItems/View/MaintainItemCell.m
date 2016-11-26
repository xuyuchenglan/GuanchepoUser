//
//  MaintainItemCell.m
//  管车婆
//
//  Created by 李伟 on 16/10/26.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "MaintainItemCell.h"

@interface MaintainItemCell()
{
    UILabel  *_titleLB;
    UILabel  *_contentLB;
    UIView   *_line;
    UIButton *_selectBtn;
}
@property (nonatomic, assign)BOOL isSelected;
@end

@implementation MaintainItemCell

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
        
        _isSelected = NO;
        
        _titleLB = [[UILabel alloc] init];
        _titleLB.font = [UIFont systemFontOfSize:15.0*kRate];
        [self.contentView addSubview:_titleLB];
        [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200*kRate, 20*kRate));
            make.top.equalTo(self.contentView).with.offset(5*kRate);
            make.left.equalTo(self.contentView).with.offset(30*kRate);
        }];
        
        _selectBtn = [[UIButton alloc] init];
        [_selectBtn setImage:[UIImage imageNamed:@"stores_unselect"] forState:(UIControlStateNormal)];
        [self.contentView addSubview:_selectBtn];
        [_selectBtn addTarget:self action:@selector(selectBtnACtion) forControlEvents:UIControlEventTouchUpInside];
        [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(10*kRate, 10*kRate));
            make.right.equalTo(self.contentView).with.offset(-30*kRate);
            make.top.equalTo(self.contentView).with.offset(10*kRate);
        }];
        
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        [self.contentView addSubview:_line];
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenWidth, 1*kRate));
            make.top.equalTo(self.contentView).with.offset(30*kRate);
        }];
        
        _contentLB = [[UILabel alloc] init];
        _contentLB.numberOfLines = 3;
        _contentLB.textColor = [UIColor colorWithWhite:0.3 alpha:1];
        _contentLB.font = [UIFont systemFontOfSize:13.0*kRate];
        [self.contentView addSubview:_contentLB];
        [_contentLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenWidth - 40*kRate, 75*kRate));
            make.left.equalTo(self.contentView).with.offset(20*kRate);
            make.top.equalTo(_line.mas_bottom).with.offset(5*kRate);
        }];
        
    }
    
    return self;
}

- (void)layoutSubviews
{
    _titleLB.text = @"小保养";
    
    NSString *string = @"小保养一般是汽车行驶一定距离后，为保证车辆性能而在厂商规定的时间或里程内做的常规保养项目，主要包括更换机油和机油滤清器.";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 8; // 调整行间距
    NSRange range = NSMakeRange(0, [string length]);
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    _contentLB.attributedText = attributedString;
}


- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 15;
    
    [super setFrame:frame];
}

#pragma mark ButtonAction
- (void)selectBtnACtion
{
    
    _isSelected = !_isSelected;
    
    if (_isSelected) {
        [_selectBtn setImage:[UIImage imageNamed:@"stores_select"] forState:UIControlStateNormal];
    } else {
        [_selectBtn setImage:[UIImage imageNamed:@"stores_unselect"] forState:UIControlStateNormal];
    }
}

@end
