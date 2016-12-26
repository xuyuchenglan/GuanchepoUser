//
//  AppointOnLineView+GetCurrentDate.m
//  管车婆
//
//  Created by 李伟 on 16/12/13.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import "AppointOnLineView+GetCurrentDate.h"

@implementation AppointOnLineView (GetCurrentDate)

- (NSString *)getCurrentDate
{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    
    return dateString;
}

@end
