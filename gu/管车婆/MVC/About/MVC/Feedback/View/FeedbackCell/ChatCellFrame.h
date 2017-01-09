//
//  ChatCellFrame.h
//  管车婆
//
//  Created by 李伟 on 17/1/7.
//  Copyright © 2017年 远恒网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeedbackModel.h"
#import <CoreGraphics/CoreGraphics.h>

@interface ChatCellFrame : NSObject

@property (nonatomic, assign)CGRect iconRect;//图标位置大小
@property (nonatomic, assign)CGRect chatViewRect;//内容位置大小

@property (nonatomic, strong)FeedbackModel *feedbackModel;//

@property (nonatomic, assign)CGFloat cellHeight;//cell高度

@end
