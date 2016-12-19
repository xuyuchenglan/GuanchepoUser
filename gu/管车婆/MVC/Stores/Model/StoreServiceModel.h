//
//  StoreServiceModel.h
//  管车婆
//
//  Created by 李伟 on 16/12/16.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreServiceModel : NSObject

@property(nonatomic, strong)NSString *name;
@property(nonatomic, strong)NSString *sid;
@property(nonatomic, strong)NSString *status;
@property(nonatomic, strong)NSString *type;
@property(nonatomic, strong)NSString *wxuimore_img;
@property(nonatomic, strong)NSString *wxuimore_row;
@property(nonatomic, strong)NSString *wxuimore_rowxh;
@property(nonatomic, strong)NSString *wxuimore_view;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
