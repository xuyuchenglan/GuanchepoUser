//
//  CouponModel.h
//  管车婆
//
//  Created by 李伟 on 16/10/24.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CouponModel : NSObject

@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *subTitle;
@property (nonatomic, strong)NSString *sid;
@property (nonatomic, strong)NSString *charge;
@property (nonatomic, strong)NSString *pid;



@property (nonatomic, strong)NSString   *itemTitle;
@property (nonatomic, strong)NSString   *itemImg;
@property (nonatomic, strong)NSString   *itemCharge;
@property (nonatomic, strong)NSString   *itemCount;

- (instancetype) initWithDic:(NSDictionary *)dic;

@end
