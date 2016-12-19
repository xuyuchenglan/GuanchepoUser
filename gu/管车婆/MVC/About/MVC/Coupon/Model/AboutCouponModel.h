//
//  AboutCouponModel.h
//  管车婆
//
//  Created by 李伟 on 16/12/19.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AboutCouponModel : NSObject

@property (nonatomic, strong)NSString *sname;
@property (nonatomic, strong)NSString *supername;
@property (nonatomic, strong)NSString *overdate;
@property (nonatomic, strong)NSString *discount;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
