//
//  WeathreModel.m
//  管车婆
//
//  Created by 李伟 on 16/10/9.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "WeathreModel.h"

@implementation WeathreModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        _bgImgStr = @"weather_sunny_bg";
        _weatherImgStr = @"weather_sunny";
        _isSuitableForWashing = @"适宜洗车";
        
        _dateStr = [dic objectForKey:@"date"];
        
        NSArray *dayArr = [[dic objectForKey:@"info"] objectForKey:@"day"];
        NSString *dayWeather = dayArr[1];
        NSString *dayTemperature = dayArr[2];
        
        
        NSArray *nightArr = [[dic objectForKey:@"info"] objectForKey:@"night"];
        NSString *nightWeather = nightArr[1];
        NSString *nightTemperature = nightArr[2];
        
        if ([dayWeather isEqualToString:nightWeather]) {
            _weatherStr = dayWeather;
        } else {
            _weatherStr = [NSString stringWithFormat:@"%@转%@", dayWeather, nightWeather];
        }
        
        _temperatureRangeStr = [NSString stringWithFormat:@"%@°C-%@°C", nightTemperature, dayTemperature];
        
//        if (<#condition#>) {
//            <#statements#>
//        }
        
    }
    
    return self;
}

@end
