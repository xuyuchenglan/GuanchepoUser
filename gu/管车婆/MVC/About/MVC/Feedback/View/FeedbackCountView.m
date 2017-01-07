//
//  FeedbackCountView.m
//  管车婆
//
//  Created by 李伟 on 17/1/7.
//  Copyright © 2017年 远恒网络科技有限公司. All rights reserved.
//

#import "FeedbackCountView.h"

#define kSelfHeight self.frame.size.height
#define kSelfWidth self.frame.size.width

@interface FeedbackCountView()
{
    UIImageView *imgView;
    UILabel *titleLabel;
    UILabel *accountLabel;
}
@end

@implementation FeedbackCountView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        accountLabel = [[UILabel alloc] initWithFrame:CGRectMake((kSelfWidth-50*kRate)/2, kSelfHeight*0.15, 50*kRate, kSelfHeight/5)];
        accountLabel.textColor = [UIColor grayColor];
        accountLabel.textAlignment = NSTextAlignmentCenter;
        accountLabel.font = [UIFont systemFontOfSize:10.0*kRate];
        [self addSubview:accountLabel];
        
        
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kSelfHeight/2, kSelfHeight*0.3, kSelfHeight*0.3)];
        [self addSubview:imgView];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgView.frame)+2, kSelfHeight/2, kSelfWidth-CGRectGetMaxX(imgView.frame), CGRectGetHeight(imgView.frame))];
        titleLabel.font = [UIFont systemFontOfSize:14.0*kRate];
        [self addSubview:titleLabel];
        
        
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    imgView.image = [UIImage imageNamed:_imgName];
    titleLabel.text = _title;
    accountLabel.text = _account;
}

@end
