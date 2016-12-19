//
//  OpenCardModel.m
//  管车婆
//
//  Created by 李伟 on 16/12/9.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import "OpenCardModel.h"

@implementation OpenCardModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        self.picUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@%@", kIP, [dic objectForKey:@"cpic"]]];
        
        self.name = [dic objectForKey:@"cname"];
        
        self.price = [NSString stringWithFormat:@"%@", [dic objectForKey:@"cprice"]];
        
        self.desc = [NSString stringWithFormat:@"%@", [dic objectForKey:@"cdesc"]];
        
    }
    
    return self;
}

@end
