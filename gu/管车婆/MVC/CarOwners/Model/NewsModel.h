//
//  NewsModel.h
//  管车婆
//
//  Created by 李伟 on 16/12/17.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

@property (nonatomic, strong)NSURL    *imgUrl;
@property (nonatomic, strong)NSString *timeStr;
@property (nonatomic, strong)NSString *titleStr;
@property (nonatomic, strong)NSString *contentStr;
@property (nonatomic, strong)NSNumber *likeCount;
@property (nonatomic, strong)NSNumber *evaluateCount;
@property (nonatomic, strong)NSNumber *readCount;

@property (nonatomic, strong)NSURL    *linkUrl;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
