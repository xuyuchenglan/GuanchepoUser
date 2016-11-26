//
//  WeathreModel.h
//  管车婆
//
//  Created by 李伟 on 16/10/9.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeathreModel : NSObject

@property (nonatomic, strong)NSString *bgImgStr;
@property (nonatomic, strong)NSString *dateStr;
@property (nonatomic, strong)NSString *weatherStr;
@property (nonatomic, strong)NSString *temperatureRangeStr;
@property (nonatomic, strong)NSString *isSuitableForWashing;
@property (nonatomic, strong)NSString *weatherImgStr;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
