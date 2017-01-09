//
//  FeedbackInfoCell.m
//  管车婆
//
//  Created by 李伟 on 17/1/7.
//  Copyright © 2017年 远恒网络科技有限公司. All rights reserved.
//

#import "FeedbackInfoCell.h"

@interface FeedbackInfoCell()
{
    UILabel      *_textContent;
    UIView       *_lineView;//分割线
    UIButton     *_moreTextBtn;
    UIButton     *_replyBtn;//回复按钮
}
@end

@implementation FeedbackInfoCell

+ (CGFloat)cellDefaultHeight
{
    ///默认cell高度
    return 90.0*kRate;
}

+ (CGFloat)cellMoreHeight:(FeedbackModel *)feedbackModel
{
    //展开后的高度(计算出文本内容的高度+固定控件的高度)
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14*kRate]};
    NSStringDrawingOptions option = (NSStringDrawingOptions)(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading);
    CGSize size = [feedbackModel.content boundingRectWithSize:CGSizeMake(kScreenWidth - 44*kRate, 100000) options:option attributes:attribute context:nil].size;
    
    return size.height + 30*kRate + 30*kRate;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        _textContent = [[UILabel alloc] init];
        _textContent.textColor = [UIColor colorWithWhite:0.5 alpha:1];
        _textContent.font = [UIFont systemFontOfSize:14*kRate];
        _textContent.numberOfLines = 0;
        [self.contentView addSubview:_textContent];
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
        [self.contentView addSubview:_lineView];
        
        _moreTextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreTextBtn.titleLabel.font = [UIFont systemFontOfSize:15.0*kRate];
        [_moreTextBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:_moreTextBtn];
        [_moreTextBtn addTarget:self action:@selector(moreTextBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        _replyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_replyBtn setImage:[UIImage imageNamed:@"feedback_message"] forState:UIControlStateNormal];
        [self.contentView addSubview:_replyBtn];
        [_replyBtn addTarget:self action:@selector(replyBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return self;
}

- (void)moreTextBtnAction
{
    self.feedbackModel.isShowMoreText = !self.feedbackModel.isShowMoreText;
    if (self.showMoreTextBlock) {
        self.showMoreTextBlock(self);
    }
}

- (void)replyBtnAction
{
    NSLog(@"回复");
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _textContent.text = self.feedbackModel.content;
    
    if (self.feedbackModel.isShowMoreText)
    {
        ///计算文本高度
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14*kRate]};
        NSStringDrawingOptions option = (NSStringDrawingOptions)(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading);
        CGSize size = [self.feedbackModel.content boundingRectWithSize:CGSizeMake(kScreenWidth - 44*kRate, 100000) options:option attributes:attribute context:nil].size;
        [_textContent setFrame:CGRectMake(10*kRate, 5*kRate, kScreenWidth - 44*kRate, size.height)];
        
        [_moreTextBtn setTitle:@"收起" forState:UIControlStateNormal];
    }
    else
    {
        [_moreTextBtn setTitle:@"查看全部" forState:UIControlStateNormal];
        [_textContent setFrame:CGRectMake(10*kRate, 5*kRate, kScreenWidth - 44*kRate, 40*kRate)];
    }
    
    _lineView.frame = CGRectMake(0, CGRectGetMaxY(_textContent.frame) + 4*kRate, kScreenWidth - 24*kRate, 0.5);
    _moreTextBtn.frame = CGRectMake(15*kRate, CGRectGetMaxY(_textContent.frame) + 10*kRate, 80*kRate, 20*kRate);
    _replyBtn.frame = CGRectMake(kScreenWidth - 60*kRate, CGRectGetMaxY(_textContent.frame) + 10*kRate, 20*kRate, 20*kRate);
}

//设置单元格上下左右都有边距~
- (void)setFrame:(CGRect)frame
{
    
    //frame.origin.x = 10;//左右距屏幕的距离
    //frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 5*kRate;//上下两个单元格的边距
    
    [super setFrame:frame];
}

@end
