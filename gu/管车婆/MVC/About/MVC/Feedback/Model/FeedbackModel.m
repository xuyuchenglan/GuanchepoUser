//
//  FeedbackModel.m
//  管车婆
//
//  Created by 李伟 on 17/1/7.
//  Copyright © 2017年 远恒网络科技有限公司. All rights reserved.
//

#import "FeedbackModel.h"

@implementation FeedbackModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        self.feedID = [dic objectForKey:@"feedid"];
        self.content = [dic objectForKey:@"content"];
        self.uid = [dic objectForKey:@"uid"];
        self.optime = [dic objectForKey:@"optime"];
        self.relationID = [dic objectForKey:@"relationid"];
        
        self.iconStr = @"000";
        
    }
    
    return self;
}


@end
