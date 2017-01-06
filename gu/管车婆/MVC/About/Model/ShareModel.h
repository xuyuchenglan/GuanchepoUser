//
//  ShareModel.h
//  管车婆
//
//  Created by 李伟 on 17/1/5.
//  Copyright © 2017年 远恒网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareModel : NSObject

@property (nonatomic, strong)NSString *shareTitle;//分享标题
@property (nonatomic, strong)NSString *shareContent;//分享内容
@property (nonatomic, strong)UIImage *shareImg;//分享图片
@property (nonatomic, strong)NSString *shareLink;//分享链接

- (instancetype)initWithDic:(NSDictionary *)dic;


@end
