//
//  MembershipServicesModel.m
//  管车婆
//
//  Created by 李伟 on 16/12/12.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import "MembershipServicesModel.h"

@implementation MembershipServicesModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        self.name = [dic objectForKey:@"sname"];
        
        NSString *countNum = [NSString stringWithFormat:@"%@", [dic objectForKey:@"scount"]];
        if ([countNum  isEqual: @"-1"]) {
            self.count = @"无限次";
        } else {
            self.count = countNum;
        }
        
        
        NSString *leftCountNum = [NSString stringWithFormat:@"%@", [dic objectForKey:@"leftcount"]];
        if ([leftCountNum isEqual:@"-1"]) {
            self.leftCount = @"无限次";
        } else {
            self.leftCount = leftCountNum;
        }
        
    }
    
    return self;
}

@end
