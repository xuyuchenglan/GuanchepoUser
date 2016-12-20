//
//  OrderModel.m
//  管车婆
//
//  Created by 李伟 on 16/10/20.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        self.headImgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@%@", kIP, [dic objectForKey:@"mpic"]]];
        self.nameStr = [dic objectForKey:@"mname"];
        self.addressStr = [dic objectForKey:@"maddr"];
        self.cardName = [dic objectForKey:@"cardname"];
        self.serviceName = [dic objectForKey:@"servicename"];
        self.fee = [NSString stringWithFormat:@"%@", [dic objectForKey:@"fee"]];
        self.urealname = [dic objectForKey:@"urealname"];
        
        self.orderID = [dic objectForKey:@"oid"];
        self.orderWay = [dic objectForKey:@"oway"];
        self.ordeTime = [dic objectForKey:@"otime"];
    }
    
    return self;
}

@end
