//
//  VoucherModel.h
//  管车婆
//
//  Created by 李伟 on 16/12/23.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VoucherModel : NSObject

@property(nonatomic, strong)NSURL *voucherUrl;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
