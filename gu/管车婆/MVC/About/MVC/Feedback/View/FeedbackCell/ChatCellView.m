//
//  ChatCellView.m
//  管车婆
//
//  Created by 李伟 on 17/1/7.
//  Copyright © 2017年 远恒网络科技有限公司. All rights reserved.
//

#import "ChatCellView.h"

#define kContentStartMargin 25*kRate

@implementation ChatCellView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.iconImgView = [[UIImageView alloc] init];
        self.iconImgView.userInteractionEnabled = YES;
        [self addSubview:self.iconImgView];
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.textAlignment = NSTextAlignmentLeft;
        self.contentLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13*kRate];
        [self addSubview:self.contentLabel];
        
    }
    
    return self;
}

//重写Frame
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    self.iconImgView.frame = self.bounds;
    
    CGFloat contentLabelX = 0;
    if ([self.feedBackModel.uid isEqual:[[self getLocalDic] objectForKey:@"uid"]]) {
        //NSLog(@"用户反馈");
        contentLabelX = kContentStartMargin * 0.5;
        
    } else if ([self.feedBackModel.uid isEqual:@"sys"]) {
        //NSLog(@"系统回复");
        
        contentLabelX = kContentStartMargin * 0.8;
    }
    self.contentLabel.frame = CGRectMake(contentLabelX, -3*kRate, self.frame.size.width - kContentStartMargin - 5*kRate, self.frame.size.height);
    
    
}

@end
