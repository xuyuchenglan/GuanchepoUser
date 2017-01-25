//
//  CouponModel.m
//  管车婆
//
//  Created by 李伟 on 16/10/24.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "CouponModel.h"

@implementation CouponModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        self.title = [dic objectForKey:@"name"];
        self.charge = [dic objectForKey:@"price"];
        self.sid = [dic objectForKey:@"sid"];
        self.pid = [dic objectForKey:@"pid"];
    }
    
    return self;
}

@end
