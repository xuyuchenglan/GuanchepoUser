//
//  StoreModel.h
//  管车婆
//
//  Created by 李伟 on 16/9/29.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreModel : NSObject

@property(nonatomic, strong) NSURL    *headUrl;
@property(nonatomic, strong) NSString *mname;
@property(nonatomic, strong) NSString *maddress;
@property(nonatomic, strong) NSString *mdesc;
@property(nonatomic, strong) NSString *mphone;
@property(nonatomic, strong) NSString *orderCount;
@property(nonatomic, strong) NSString *evaluateCount;

@property(nonatomic, assign) float     starPercent;
@property(nonatomic, strong) NSString *starCount;



- (instancetype)initWithDic:(NSDictionary *)dic;

@end
