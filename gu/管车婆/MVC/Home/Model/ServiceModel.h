//
//  ServiceModel.h
//  管车婆
//
//  Created by 李伟 on 16/12/8.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceModel : NSObject

//service
@property (nonatomic, strong) NSString *serviceName;
@property (nonatomic, strong) NSString *serviceImg;
@property (nonatomic, assign) int       serviceId;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
