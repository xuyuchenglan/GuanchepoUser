//
//  MembershipServicesModel.h
//  管车婆
//
//  Created by 李伟 on 16/12/12.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MembershipServicesModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *count;
@property (nonatomic, strong) NSString *leftCount;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
