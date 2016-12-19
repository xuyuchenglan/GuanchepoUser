//
//  CarOwnerClassifyModel.m
//  管车婆
//
//  Created by 李伟 on 16/12/16.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import "CarOwnerClassifyModel.h"

@implementation CarOwnerClassifyModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        self.classifyid = [NSString stringWithFormat:@"%@", [dic objectForKey:@"classifyid"]];
        self.classifyname = [dic objectForKey:@"classifyname"];
        self.status = [NSString stringWithFormat:@"%@", [dic objectForKey:@"status"]];
        
    }
    return self;
}

@end
