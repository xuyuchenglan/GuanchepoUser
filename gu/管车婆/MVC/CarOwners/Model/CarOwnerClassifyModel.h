//
//  CarOwnerClassifyModel.h
//  管车婆
//
//  Created by 李伟 on 16/12/16.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarOwnerClassifyModel : NSObject

@property (nonatomic, strong)NSString *classifyid;
@property (nonatomic, strong)NSString *classifyname;
@property (nonatomic, strong)NSString *status;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
