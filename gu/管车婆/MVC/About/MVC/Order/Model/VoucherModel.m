//
//  VoucherModel.m
//  管车婆
//
//  Created by 李伟 on 16/12/23.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import "VoucherModel.h"

@implementation VoucherModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        self.voucherUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@%@", kIP, [dic objectForKey:@"picurl"]]];
        
    }
    
    return self;
}

@end
