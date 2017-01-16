//
//  OpenCardModel.h
//  管车婆
//
//  Created by 李伟 on 16/12/9.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OpenCardModel : NSObject

@property (nonatomic, strong)NSURL    *picUrl;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *price;
@property (nonatomic, strong)NSString *desc;
@property (nonatomic, strong)NSString *cid;
@property (nonatomic, strong)NSString *prefixNo;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
