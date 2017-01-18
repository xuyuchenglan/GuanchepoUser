//
//  HomeModel.m
//  管车婆
//
//  Created by 李伟 on 16/12/7.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import "HomeModel.h"
#import "ServiceModel.h"

@implementation HomeModel


- (instancetype) initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        NSArray *banner1Arr = [dic objectForKey:@"banner1"];
        NSMutableArray *banner1ModelsMu = [NSMutableArray array];
        for (NSDictionary *banner1Dic in banner1Arr) {
            BannerModel *bannerModel = [[BannerModel alloc] initWithDic:banner1Dic];
            [banner1ModelsMu addObject:bannerModel];
        }
        self.banner1Models = banner1ModelsMu;
        
        NSDictionary *banner2Dic = [dic objectForKey:@"banner2"];
        self.banner2Model = [[BannerModel alloc] initWithDic:banner2Dic];
        
        NSDictionary *banner3Dic = [dic objectForKey:@"banner3"];
        self.banner3Model = [[BannerModel alloc] initWithDic:banner3Dic];
        
        self.car = [dic objectForKey:@"car"];
        
        NSDictionary *weatherDic = [dic objectForKey:@"weather"];
        self.weatherImgStr = [weatherDic objectForKey:@"img"];
        self.isSuitableForClean = [weatherDic objectForKey:@"info"];
        
        NSMutableArray *servicesMutable = [NSMutableArray array];
        NSArray *servicesArr = [dic objectForKey:@"services"];
        for (NSDictionary *serviceDic in servicesArr) {
            ServiceModel *serviceModel = [[ServiceModel alloc] initWithDic:serviceDic];
            [servicesMutable addObject:serviceModel];
        }
        self.services = servicesMutable;
        
    }
    
    return self;
}

@end
