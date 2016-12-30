//
//  UIResponder+GetDate.h
//  管车婆
//
//  Created by 李伟 on 16/12/30.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (GetDate)

- (NSString *)getDate:(BOOL)getdate getTime:(BOOL)gettime WithTimeDateStr:(NSString *)timeAnddateStr;

@end
