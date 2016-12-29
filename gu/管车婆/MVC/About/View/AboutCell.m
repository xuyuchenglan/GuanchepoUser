//
//  AboutCell.m
//  管车婆
//
//  Created by 李伟 on 16/8/10.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "AboutCell.h"

@interface AboutCell()
{
    UIImageView *_leftImgView;
    UILabel     *_mediumLabel;
    UIImageView *_rightImgView;
    UILabel     *_bottomLabel;
}
@end

@implementation AboutCell

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
        
        _leftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(30*kRate, 10*kRate, 20*kRate, 20*kRate)];
        [self.contentView addSubview:_leftImgView];
        
        _mediumLabel = [[UILabel alloc] initWithFrame:CGRectMake(60*kRate, 10*kRate, 120*kRate, 20*kRate)];
        _mediumLabel.font = [UIFont systemFontOfSize:16.0*kRate];
        _mediumLabel.textColor = [UIColor colorWithWhite:0.3 alpha:1];
        [self.contentView addSubview:_mediumLabel];
        
        _rightImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 30*kRate, 15*kRate, 10*kRate, 10*kRate)];
        [self.contentView addSubview:_rightImgView];
        
        _bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 100*kRate, 10*kRate, 200*kRate, 20*kRate)];
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        _bottomLabel.textColor = kRGBColor(16, 92, 255);
        _bottomLabel.font = [UIFont systemFontOfSize:16.0*kRate];
        [self.contentView addSubview:_bottomLabel];
    }
    
    return self;
}

- (void)layoutSubviews
{
    _leftImgView.image = [UIImage imageNamed:self.leftImgName];
    _mediumLabel.text = self.mediumName;
    _rightImgView.image = [UIImage imageNamed:self.rightArrowName];
    _bottomLabel.text = self.bottomStr;
    
}

//设置单元格上下左右都有边距~
- (void)setFrame:(CGRect)frame
{
    
    //frame.origin.x = 25;//左右距屏幕的距离
    //frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 1*kRate;//上下两个单元格的边距
    
    [super setFrame:frame];
}


@end
