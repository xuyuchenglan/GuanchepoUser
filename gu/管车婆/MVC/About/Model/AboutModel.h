//
//  AboutModel.h
//  管车婆
//
//  Created by 李伟 on 16/12/9.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AboutModel : NSObject

@property (nonatomic, strong) NSString *scores;//积分
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *balance;//余额

@property (nonatomic, strong) NSString *carNo;//车牌号


- (instancetype)initWithDic:(NSDictionary *)dic;

@end
