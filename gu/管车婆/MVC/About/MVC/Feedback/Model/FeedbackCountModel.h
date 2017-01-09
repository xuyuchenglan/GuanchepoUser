//
//  FeedbackCountModel.h
//  管车婆
//
//  Created by 李伟 on 17/1/7.
//  Copyright © 2017年 远恒网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedbackCountModel : NSObject

@property (nonatomic, strong)NSString *allCount;
@property (nonatomic, strong)NSString *hfCount;
@property (nonatomic, strong)NSString *nohfCount;

- (instancetype)initWithDic:(NSDictionary *)dic;


@end
