//
//  AboutCouponModel.m
//  管车婆
//
//  Created by 李伟 on 16/12/19.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import "AboutCouponModel.h"

@implementation AboutCouponModel

- (instancetype) initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        self.sname = [dic objectForKey:@"sname"];
        self.supername = [dic objectForKey:@"supername"];
        self.overdate = [dic objectForKey:@"overdate"];
        self.discount = [dic objectForKey:@"discount"];
        
    }
    
    return self;
}

@end
