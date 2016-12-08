//
//  HomeModel.h
//  管车婆
//
//  Created by 李伟 on 16/12/7.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BannerModel.h"

@interface HomeModel : NSObject

//banner
@property (nonatomic, strong) BannerModel *banner3Model;
@property (nonatomic, strong) BannerModel *banner2Model;


@property (nonatomic, strong) NSString *car;

//services
@property (nonatomic, copy) NSArray *services;


//weather
@property (nonatomic, strong) NSString *isSuitableForClean;


- (instancetype)initWithDic:(NSDictionary *)dic;

@end
