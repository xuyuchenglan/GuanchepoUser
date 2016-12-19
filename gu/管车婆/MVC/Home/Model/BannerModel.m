//
//  BannerModel.m
//  管车婆
//
//  Created by 李伟 on 16/12/7.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import "BannerModel.h"

@implementation BannerModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        //banner
        self.picUrl = [NSString stringWithFormat:@"http://%@%@", kIP, [dic objectForKey:@"pic"]];
        self.linkUrl = [dic objectForKey:@"linkurl"];
        self.bid = [[dic objectForKey:@"bid"] intValue];
        self.titleName = [dic objectForKey:@"name"];
        
    }
    
    return self;
}


@end
