//
//  ChatCellView.h
//  管车婆
//
//  Created by 李伟 on 17/1/7.
//  Copyright © 2017年 远恒网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedbackModel.h"

@interface ChatCellView : UIView

@property (nonatomic, strong)UIImageView *iconImgView;
@property (nonatomic, strong)UILabel     *contentLabel;
@property (nonatomic, strong)FeedbackModel *feedBackModel;

@end
