//
//  StoreModel.m
//  管车婆
//
//  Created by 李伟 on 16/9/29.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "StoreModel.h"

@implementation StoreModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        self.headUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@%@", kIP, [dic objectForKey:@"mpic"]]];
        self.mname = [dic objectForKey:@"mname"];
        self.maddress = [dic objectForKey:@"maddr"];
        self.mdesc = [dic objectForKey:@"mdesc"];
        self.mphone = [dic objectForKey:@"mphone"];
        self.orderCount = [dic objectForKey:@"ordercount"];
        self.evaluateCount = [dic objectForKey:@"pj_count"];
        self.mid = [dic objectForKey:@"mid"];
        
        float pj_avg = [[dic objectForKey:@"pj_avg"] floatValue];
        self.starPercent = pj_avg / 5;
        self.starCount = [NSString stringWithFormat:@"%.1f", pj_avg];
        
    }
    
    return self;
}

@end
