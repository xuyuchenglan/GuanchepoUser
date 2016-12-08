//
//  ServiceModel.m
//  管车婆
//
//  Created by 李伟 on 16/12/8.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import "ServiceModel.h"

@implementation ServiceModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        //service
        self.serviceImg = [NSString stringWithFormat:@"http://%@:8080%@", kIP, [dic objectForKey:@"wxuimore_img"]];
        self.serviceName = [dic objectForKey:@"name"];
        self.serviceId = [[dic objectForKey:@"id"] intValue];
        
    }
    
    return self;
}


@end
