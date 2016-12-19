//
//  StoreServiceModel.m
//  管车婆
//
//  Created by 李伟 on 16/12/16.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import "StoreServiceModel.h"

@implementation StoreServiceModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        self.name = [NSString stringWithFormat:@"%@", [dic objectForKey:@"name"]];
        self.sid = [NSString stringWithFormat:@"%@", [dic objectForKey:@"sid"]];
        self.status = [NSString stringWithFormat:@"%@", [dic objectForKey:@"status"]];
        self.type = [NSString stringWithFormat:@"%@", [dic objectForKey:@"type"]];
        self.wxuimore_img = [NSString stringWithFormat:@"%@", [dic objectForKey:@"wxuimore_img"]];
        self.wxuimore_row = [NSString stringWithFormat:@"%@", [dic objectForKey:@"wxuimore_row"]];
        self.wxuimore_rowxh = [NSString stringWithFormat:@"%@", [dic objectForKey:@"wxuimore_rowxh"]];
        self.wxuimore_view = [NSString stringWithFormat:@"%@", [dic objectForKey:@"wxuimore_view"]];
    }
    
    return self;
}

@end
