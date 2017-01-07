//
//  ChatCell.m
//  管车婆
//
//  Created by 李伟 on 17/1/7.
//  Copyright © 2017年 远恒网络科技有限公司. All rights reserved.
//

#import "ChatCell.h"

@interface ChatCell()

@property (nonatomic, strong)UIImageView *icon;
@property (nonatomic, strong)ChatCellView *chatView;
@property (nonatomic, strong)ChatCellView *currentChatView;
@property (nonatomic, strong)NSString     *contentStr;

@end

@implementation ChatCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.icon = [[UIImageView alloc] init];
        [self.contentView addSubview:self.icon];
        
        self.chatView = [[ChatCellView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:self.chatView];
    }
    return self;
}

- (void)setCellFrame:(ChatCellFrame *)cellFrame
{
    _cellFrame = cellFrame;
    
    FeedbackModel *feedBackModel = cellFrame.feedbackModel;
    
    self.icon.frame = cellFrame.iconRect;//将图标位置赋值给icon
    if ([feedBackModel.uid isEqual:[[self getLocalDic] objectForKey:@"uid"]]) {
        //NSLog(@"用户反馈");
        [self.icon sd_setImageWithURL:[NSURL URLWithString:feedBackModel.iconStr] placeholderImage:[UIImage imageNamed:@"about_first_head"]];
        
    } else if ([feedBackModel.uid isEqual:@"sys"]) {
        //NSLog(@"系统回复");
        self.icon.image = [UIImage imageNamed:feedBackModel.iconStr];
    }
    
    self.chatView.feedBackModel = feedBackModel;
    self.chatView.frame = cellFrame.chatViewRect;//将内容位置赋值给chatView
    [self setBgImgOnView:self.chatView WithMerchantImgPath:@"chatbg_m" SysBgImgPath:@"chatbg_guanchepo"];
    self.chatView.contentLabel.text = feedBackModel.content;
    
}

#pragma mark 根据不同类型更换不同的聊天背景
- (void)setBgImgOnView:(ChatCellView *)chatCellView WithMerchantImgPath:(NSString *)merchantImgPath SysBgImgPath:(NSString *)sysBgImgPath
{
    UIImage *normal = nil;
    
    if ([chatCellView.feedBackModel.uid isEqual:[[self getLocalDic] objectForKey:@"uid"]]) {
        //NSLog(@"用户反馈");
        normal = [UIImage imageNamed:merchantImgPath];
        normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.7];
        
    } else if ([chatCellView.feedBackModel.uid isEqual:@"sys"]) {
        //NSLog(@"系统回复");
        normal = [UIImage imageNamed:sysBgImgPath];
        normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.7];
        
    }
    
    chatCellView.iconImgView.image = normal;
}



@end
