//
//  NewsModel.m
//  管车婆
//
//  Created by 李伟 on 16/12/17.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        self.imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@%@", kIP, [dic objectForKey:@"imgurl"]]];
        self.timeStr = [dic objectForKey:@"time"];
        self.titleStr = [dic objectForKey:@"title"];
        self.contentStr = [dic objectForKey:@"content"];
        self.likeCount = [dic objectForKey:@"like"];
        self.evaluateCount = [dic objectForKey:@"evaluate"];
        self.readCount = [dic objectForKey:@"read"];
        self.linkUrl = [NSURL URLWithString:[dic objectForKey:@"link"]];
        
    }
    
    return self;
}

@end
