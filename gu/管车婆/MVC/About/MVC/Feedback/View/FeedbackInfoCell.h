//
//  FeedbackInfoCell.h
//  管车婆
//
//  Created by 李伟 on 17/1/7.
//  Copyright © 2017年 远恒网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedbackModel.h"

@interface FeedbackInfoCell : UITableViewCell

///展开多个活动信息
@property (nonatomic, copy) void (^ showMoreTextBlock)(UITableViewCell *currentCell);

@property (nonatomic, strong)FeedbackModel *feedbackModel;

///未展开时的高度
+ (CGFloat)cellDefaultHeight;
///展开后的高度
+(CGFloat)cellMoreHeight:(FeedbackModel *)feedbackModel;

@end
