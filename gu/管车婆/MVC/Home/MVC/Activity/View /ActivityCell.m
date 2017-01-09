//
//  ActivityCell.m
//  管车婆
//
//  Created by 李伟 on 17/1/9.
//  Copyright © 2017年 远恒网络科技有限公司. All rights reserved.
//

#import "ActivityCell.h"

@interface ActivityCell()
{
    UIImageView *_imgView;
    UILabel *_titleLabel;
    UILabel *_infoLabel;
    UILabel *_timeLabel;
}
@end


@implementation ActivityCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10*kRate, 15*kRate, 100*kRate, 70*kRate)];
        [self.contentView addSubview:_imgView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(120*kRate, 15*kRate, kScreenWidth-140*kRate, 15*kRate)];
        _titleLabel.font = [UIFont systemFontOfSize:14.0*kRate];
        [self.contentView addSubview:_titleLabel];
        
        _infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(120*kRate, 35*kRate, kScreenWidth-140*kRate, 35*kRate)];
        _infoLabel.numberOfLines = 2;
        _infoLabel.font = [UIFont systemFontOfSize:12.0*kRate];
        _infoLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_infoLabel];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 100*kRate, 70*kRate, 80*kRate, 20*kRate)];
        _timeLabel.font = [UIFont systemFontOfSize:11.0*kRate];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_timeLabel];
        
        
    }
    
    return self;
}

- (void)layoutSubviews
{
    NSLog(@"imageUrl:%@", self.activityModel.imgUrl);
    [_imgView sd_setImageWithURL:self.activityModel.imgUrl];
    _titleLabel.text = self.activityModel.title;
    _infoLabel.text = self.activityModel.info;
    _timeLabel.text = [self getDate:YES getTime:NO WithTimeDateStr:self.activityModel.time];
}

//设置单元格上下左右都有边距~
- (void)setFrame:(CGRect)frame
{
    
    //    frame.origin.x = 10;//左右距屏幕的距离
    //    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 1*kRate;//上下两个单元格的边距
    
    
    [super setFrame:frame];
}


@end
