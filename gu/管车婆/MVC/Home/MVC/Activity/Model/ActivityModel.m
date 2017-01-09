//
//  ActivityModel.m
//  管车婆
//
//  Created by 李伟 on 17/1/9.
//  Copyright © 2017年 远恒网络科技有限公司. All rights reserved.
//

#import "ActivityModel.h"

@implementation ActivityModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        NSString *urlStr = [NSString stringWithFormat:@"http://%@%@", kIP, [dic objectForKey:@"pic"]];
        self.imgUrl = [NSURL URLWithString:urlStr];
        
        NSString *enddate = [dic objectForKey:@"enddate"];
        NSLog(@"enddate:%@", enddate);
        //        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        //        [format setDateFormat:@"yyyy-MM-dd"];
        //        NSDate *date = [format dateFromString:enddate];
        //        NSLog(@"date:%@", date);
        //
        //        NSString *dateStr = [format stringFromDate:date];
        //        NSLog(@"dateStr:%@", dateStr);
        self.time = enddate;
        //NSLog(@"self.time:%@", self.time);
        
        self.linkUrl = [dic objectForKey:@"linkurl"];
        self.info = [dic objectForKey:@"content"];
        self.title = [dic objectForKey:@"title"];
        self.aid = [[dic objectForKey:@"aid"] intValue];
        
    }
    return self;
}


@end
