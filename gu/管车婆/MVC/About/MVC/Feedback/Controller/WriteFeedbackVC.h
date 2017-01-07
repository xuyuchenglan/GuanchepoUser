//
//  WriteFeedbackVC.h
//  管车婆
//
//  Created by 李伟 on 17/1/6.
//  Copyright © 2017年 远恒网络科技有限公司. All rights reserved.
//

#import "ParentViewController.h"

@interface WriteFeedbackVC : ParentViewController

///required
@property (nonatomic, strong)NSString *isFirst;

@property (nonatomic, strong)NSString *feedID;//根据feedid可以获取反馈详情

@end
