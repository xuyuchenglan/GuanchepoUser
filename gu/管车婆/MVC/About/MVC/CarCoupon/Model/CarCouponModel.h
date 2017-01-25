//
//  CarCouponModel.h
//  管车婆
//
//  Created by 李伟 on 17/1/12.
//  Copyright © 2017年 远恒网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarCouponModel : NSObject

@property (nonatomic, strong)NSString *superType;

@property (nonatomic, strong)NSString *addtime;
@property (nonatomic, strong)NSString *ewm;
@property (nonatomic, strong)NSString *normanID;
@property (nonatomic, strong)NSString *introduce;
@property (nonatomic, strong)NSString *maddr;
@property (nonatomic, strong)NSString *mid;
@property (nonatomic, strong)NSString *mname;
@property (nonatomic, strong)NSString *money;
@property (nonatomic, strong)NSString *mphone;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *pid;
@property (nonatomic, strong)NSString *sid;
@property (nonatomic, strong)NSString *uid;
@property (nonatomic, assign)BOOL      isUsed;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
