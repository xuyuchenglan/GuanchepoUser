//
//  OrderModel.h
//  管车婆
//
//  Created by 李伟 on 16/10/20.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject

@property (nonatomic, strong)NSURL          *headImgUrl;//车行头像URL
@property (nonatomic, strong)NSString       *nameStr;//车行名字
@property (nonatomic, strong)NSString       *stateStr;//
@property (nonatomic, copy)  NSArray        *itemArr;//
@property (nonatomic, strong)NSString       *addressStr;//车行地址
@property (nonatomic, strong)NSString       *cardName;//用户开的卡的名称
@property (nonatomic, strong)NSString       *serviceName;//服务项目
@property (nonatomic, strong)NSString       *fee;//费用
@property (nonatomic, strong)NSString       *urealname;//用户的姓名

@property (nonatomic, strong)NSString       *orderID;//订单号
@property (nonatomic, strong)NSString       *ordeTime;//下单时间
@property (nonatomic, strong)NSString       *appointTime;//下单时间
@property (nonatomic, strong)NSString       *orderWay;//下单方式


@property (nonatomic, strong)NSString       *pjState;//评论状态
@property (nonatomic, strong)NSString       *voucher;//是否需要上传凭证，0代表不需要，1代表需要
@property (nonatomic, strong)NSString       *isVoucherUp;//凭证是否已上传

@property (nonatomic, strong)NSString       *state;//交易状态

@property (nonatomic, strong)NSString *itemStr;//
@property (nonatomic, strong)NSString *itemCount;//


#pragma mark --- 以下属性是订单详情中使用的
@property (nonatomic, strong)NSString       *merchantname;//商户名字
@property (nonatomic, strong)NSURL          *merchantUrl;//车行头像URL



- (instancetype)initWithDic:(NSDictionary *)dic;

@end
