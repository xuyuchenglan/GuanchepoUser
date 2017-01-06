//
//  ShareModel.m
//  管车婆
//
//  Created by 李伟 on 17/1/5.
//  Copyright © 2017年 远恒网络科技有限公司. All rights reserved.
//

#import "ShareModel.h"

@implementation ShareModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        self.shareTitle = [dic objectForKey:@"title"];//分享标题
        self.shareContent = [dic objectForKey:@"content"];//分享内容
        self.shareLink = [dic objectForKey:@"linkurl"];//分享链接
        
        NSString *shareImgUrlStr = [NSString stringWithFormat:@"http://%@%@", kIP, [dic objectForKey:@"logo"]];
        NSData *shareImgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:shareImgUrlStr]];
        self.shareImg = [UIImage imageWithData:shareImgData];//分享图片
        NSLog(@"图片:%@", self.shareImg);
    }
    
    return self;
}

@end
