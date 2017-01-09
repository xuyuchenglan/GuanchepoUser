//
//  FeedbackModel.h
//  管车婆
//
//  Created by 李伟 on 17/1/7.
//  Copyright © 2017年 远恒网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedbackModel : NSObject

///是否为展开状态，默认为NO
@property (nonatomic, assign)BOOL      isShowMoreText;

@property (nonatomic, strong)NSString *iconStr;//图像图标

@property (nonatomic, strong)NSString *feedID;//根据feedid可以获取反馈详情
@property (nonatomic, strong)NSString *content;//反馈内容
@property (nonatomic, strong)NSString *uid;//sys代表是系统回复，其他的是mid(商户id)
@property (nonatomic, strong)NSString *optime;//反馈时间
@property (nonatomic, strong)NSString *relationID;//1代表是商户首先发起的反馈

- (instancetype)initWithDic:(NSDictionary *)dic;


@end
