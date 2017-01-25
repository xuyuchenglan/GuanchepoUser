//
//  FillInPersonalInfoCell.m
//  管车婆
//
//  Created by 李伟 on 17/1/18.
//  Copyright © 2017年 远恒网络科技有限公司. All rights reserved.
//

#import "FillInPersonalInfoCell.h"

@interface FillInPersonalInfoCell()
{
    UILabel *_leftTitleLB;
}
@end

@implementation FillInPersonalInfoCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        _leftTitleLB = [[UILabel alloc] initWithFrame:CGRectMake(30*kRate, 10*kRate, 120*kRate, 20*kRate)];
        _leftTitleLB.font = [UIFont systemFontOfSize:18.0*kRate];
        _leftTitleLB.textColor = [UIColor colorWithWhite:0.1 alpha:1];
        [self.contentView addSubview:_leftTitleLB];
        
    }
    
    return self;
}

- (void)layoutSubviews
{
    _leftTitleLB.text = _leftName;
}

//设置单元格上下边距~
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;//上下两个单元格的边距
    
    [super setFrame:frame];
}

@end
