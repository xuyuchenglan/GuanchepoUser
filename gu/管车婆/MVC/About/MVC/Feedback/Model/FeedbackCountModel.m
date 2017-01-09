//
//  FeedbackCountModel.m
//  管车婆
//
//  Created by 李伟 on 17/1/7.
//  Copyright © 2017年 远恒网络科技有限公司. All rights reserved.
//

#import "FeedbackCountModel.h"

@implementation FeedbackCountModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        self.allCount = [NSString stringWithFormat:@"%@条", [dic objectForKey:@"allcount"]];
        self.hfCount = [NSString stringWithFormat:@"%@条", [dic objectForKey:@"hfcount"]];
        self.nohfCount = [NSString stringWithFormat:@"%@条", [dic objectForKey:@"nohfcount"]];
        
    }
    
    return self;
}

@end
