//
//  CarCouponModel.m
//  管车婆
//
//  Created by 李伟 on 17/1/12.
//  Copyright © 2017年 远恒网络科技有限公司. All rights reserved.
//

#import "CarCouponModel.h"

@implementation CarCouponModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        self.addtime = [dic objectForKey:@"addtime"];
        self.ewm = [dic objectForKey:@"ewm"];
        self.normanID = [dic objectForKey:@"id"];
        self.introduce = [dic objectForKey:@"introduce"];
        self.maddr = [dic objectForKey:@"maddr"];
        self.mid = [dic objectForKey:@"mid"];
        self.mname = [dic objectForKey:@"mname"];
        self.money = [dic objectForKey:@"money"];
        self.mphone = [dic objectForKey:@"mphone"];
        self.name = [dic objectForKey:@"name"];
        self.pid = [dic objectForKey:@"pid"];
        self.sid = [dic objectForKey:@"sid"];
        self.uid = [dic objectForKey:@"uid"];
        
        
        NSString *used = [dic objectForKey:@"used"];
        if ([used isEqualToString:@"0"]) {
            self.isUsed = NO;
        } else {
            self.isUsed = YES;
        }
        
    }
    
    return self;
}

@end
