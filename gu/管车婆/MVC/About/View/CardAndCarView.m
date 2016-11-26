//
//  CardAndCarView.m
//  管车婆
//
//  Created by 李伟 on 16/10/8.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "CardAndCarView.h"

#define kSelfHeight self.frame.size.height
#define kSelfWidth self.frame.size.width

#define kEdgeWidth (kSelfWidth - 135*kRate)/2

@interface CardAndCarView()
{
    UIImageView *imgView;
    UILabel *titleLabel;
    UILabel *subTitleLabel;
    
}
@end

@implementation CardAndCarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(kEdgeWidth, kSelfHeight*0.4, 30*kRate, 25*kRate)];
        [self addSubview:imgView];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgView.frame) + 5*kRate, CGRectGetMinY(imgView.frame), 80*kRate, 15*kRate)];
        titleLabel.font = [UIFont systemFontOfSize:14.0*kRate];
        titleLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:titleLabel];
        
        subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgView.frame) + 5*kRate, CGRectGetMaxY(titleLabel.frame), 100*kRate, 12*kRate)];
        subTitleLabel.textColor = [UIColor grayColor];
        subTitleLabel.font = [UIFont systemFontOfSize:10.0*kRate];
        subTitleLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:subTitleLabel];
        
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    imgView.image = [UIImage imageNamed:_imgName];
    titleLabel.text = _title;
    subTitleLabel.text = _subTitle;
}

@end
