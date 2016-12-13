//
//  AboutModel.m
//  管车婆
//
//  Created by 李伟 on 16/12/9.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import "AboutModel.h"

@implementation AboutModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        self.scores = [NSString stringWithFormat:@"%@", [dic objectForKey:@"score"]];
        self.realName = [dic objectForKey:@"realname"];
        self.phoneNumber = [NSString stringWithFormat:@"%@", [dic objectForKey:@"phone"]];
        self.balance = [NSString stringWithFormat:@"%@", [dic objectForKey:@"status"]];
        
        self.carNo = [dic objectForKey:@"carno"];
    }
    
    return self;
}

@end
