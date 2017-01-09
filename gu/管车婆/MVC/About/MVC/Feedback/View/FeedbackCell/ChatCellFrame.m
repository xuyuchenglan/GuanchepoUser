//
//  ChatCellFrame.m
//  管车婆
//
//  Created by 李伟 on 17/1/7.
//  Copyright © 2017年 远恒网络科技有限公司. All rights reserved.
//

#import "ChatCellFrame.h"

#define kIconMarginX 10*kRate
#define kIconMarginY 10*kRate

@implementation ChatCellFrame

- (void)setFeedbackModel:(FeedbackModel *)feedbackModel
{
    _feedbackModel = feedbackModel;
    
    CGFloat iconX = kIconMarginX;
    CGFloat iconY = kIconMarginY;
    CGFloat iconWidth = 40*kRate;
    CGFloat iconHeight = 40*kRate;
    
    if ([feedbackModel.uid isEqual:[[self getLocalDic] objectForKey:@"uid"]]) {
        //NSLog(@"用户反馈");
        _feedbackModel.iconStr = [[self getLocalDic] objectForKey:@"userHeadUrl"];
        
        iconX = kScreenWidth - kIconMarginX - iconWidth;
        
    } else if ([feedbackModel.uid isEqual:@"sys"]) {
        //NSLog(@"系统回复");
        _feedbackModel.iconStr = @"head_guanchepo";
        
    }
    
    /*图标的位置大小*/
    self.iconRect = CGRectMake(iconX, iconY, iconWidth, iconHeight);
    
    CGFloat contentX = CGRectGetMaxX(self.iconRect) + kIconMarginX;
    CGFloat contentY = iconY;
    
    //设置字体大小
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:13*kRate]};
    //文本自适应大小
    CGSize contentSize = [self.feedbackModel.content boundingRectWithSize:CGSizeMake(200*kRate, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    
    if ([feedbackModel.uid isEqual:[[self getLocalDic] objectForKey:@"uid"]]) {
        //NSLog(@"用户反馈");
        contentX = iconX - kIconMarginX - contentSize.width - iconWidth;
        
    } else if ([feedbackModel.uid isEqual:@"sys"]) {
        //NSLog(@"系统回复");
        
    }
    
    /*内容视图的位置大小*/
    self.chatViewRect = CGRectMake(contentX, contentY, contentSize.width + 35*kRate, contentSize.height + 30*kRate);
    
    
    /*单元格的高度*/
    self.cellHeight = MAX(CGRectGetMaxY(self.iconRect), CGRectGetMaxY(self.chatViewRect)) + kIconMarginX;
}

@end
