//
//  OrderModel.m
//  管车婆
//
//  Created by 李伟 on 16/10/20.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        self.headImgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@%@", kIP, [dic objectForKey:@"mpic"]]];
        self.nameStr = [dic objectForKey:@"mname"];
        self.addressStr = [dic objectForKey:@"maddr"];
        self.cardName = [dic objectForKey:@"cardname"];
        self.serviceName = [dic objectForKey:@"servicename"];
        self.fee = [NSString stringWithFormat:@"%@", [dic objectForKey:@"fee"]];
        self.urealname = [dic objectForKey:@"urealname"];
        
        self.orderID = [dic objectForKey:@"oid"];
        self.ordeTime = [dic objectForKey:@"otime"];
        
        NSString *oWay = [NSString stringWithFormat:@"%@", [dic objectForKey:@"oway"]];
        if ([oWay isEqual:@"1"]) {
            self.orderWay = @"用户扫码下单";//下单方式
        } else if ([oWay isEqual:@"2"]) {
            self.orderWay = @"商户扫码下单";//下单方式
        } else if ([oWay isEqual:@"3"]) {
            self.orderWay = @"用户输入商户随机数下单";//下单方式
        }
        
        //评价状态
        NSString *pjStateStr = [NSString stringWithFormat:@"%@", [dic objectForKey:@"ispj"]];
        if ([pjStateStr isEqual:@"0"]) {
            self.pjState = @"未评价";
        } else if ([pjStateStr isEqual:@"1"]) {
            self.pjState = @"已评价";
        }
        
        //凭证是否已上传
        NSString *isVoucherUpStr = [NSString stringWithFormat:@"%@", [dic objectForKey:@"voucher_up"]];
        if ([isVoucherUpStr isEqual:@"0"]) {
            self.isVoucherUp = @"未上传";
        } else if ([isVoucherUpStr isEqual:@"1"]) {
            self.isVoucherUp = @"已上传";
        }
        
        self.voucher = [NSString stringWithFormat:@"%@", [dic objectForKey:@"voucher"]];//是否需要上传凭证
        
        //订单列表中显示的订单状态
        if ([self.voucher isEqual:@"0"]) {
            self.state = @"交易成功";
        } else if ([self.voucher isEqual:@"1"]) {
            if ([self.isVoucherUp isEqual:@"已上传"]) {
                self.state = @"交易成功";
            } else if ([self.isVoucherUp isEqual:@"未上传"]) {
                self.state = @"待传凭证";
            }
        }

    }
    
    return self;
}

@end
