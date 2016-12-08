//
//  BannerModel.h
//  管车婆
//
//  Created by 李伟 on 16/12/7.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BannerModel : NSObject

@property (nonatomic, assign) int       bid;
@property (nonatomic, strong) NSString *picUrl;
@property (nonatomic, strong) NSString *linkUrl;
@property (nonatomic, strong) NSString *titleName;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
