//
//  ActivityModel.h
//  管车婆
//
//  Created by 李伟 on 17/1/9.
//  Copyright © 2017年 远恒网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityModel : NSObject

@property (nonatomic, strong)NSURL      *imgUrl;
@property (nonatomic, strong)NSString   *title;
@property (nonatomic, strong)NSString   *info;
@property (nonatomic, strong)NSString   *time;
@property (nonatomic, strong)NSString   *linkUrl;
@property (nonatomic, assign)int         aid;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
