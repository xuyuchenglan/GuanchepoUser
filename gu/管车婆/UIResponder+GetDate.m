//
//  UIResponder+GetDate.m
//  管车婆
//
//  Created by 李伟 on 16/12/30.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import "UIResponder+GetDate.h"

@implementation UIResponder (GetDate)

- (NSString *)getDate:(BOOL)getdate getTime:(BOOL)gettime WithTimeDateStr:(NSString *)timeAnddateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[formatter dateFromString:timeAnddateStr];
    
    if (date) {
        
        // 获取代表公历的NSCalendar对象
        NSCalendar *gregorian = [[NSCalendar alloc]
                                 initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        
        // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
        NSInteger unitFlags = NSCalendarUnitYear |
        NSCalendarUnitMonth |  NSCalendarUnitDay |
        NSCalendarUnitHour |  NSCalendarUnitMinute |
        NSCalendarUnitSecond | NSCalendarUnitWeekday;
        
        // 获取不同时间字段的信息
        NSDateComponents* comp = [gregorian components: unitFlags
                                              fromDate:date];
        
        if (getdate == YES && gettime == NO) {
            //获取日期
            NSString *dateStr = [NSString stringWithFormat:@"%02ld-%02ld-%02ld", (long)comp.year, (long)comp.month, (long)comp.day];
            return dateStr;
            
        } else if (getdate == NO && gettime == YES) {
            //获取时间
            NSString *timeStr = [NSString stringWithFormat:@"%02ld: %02ld", (long)comp.hour, (long)comp.minute];
            return timeStr;
        }
        
    }
    return nil;
    
}

@end
