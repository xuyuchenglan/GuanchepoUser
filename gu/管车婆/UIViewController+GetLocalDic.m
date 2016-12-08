//
//  UIViewController+GetLocalDic.m
//  管车婆
//
//  Created by 李伟 on 16/12/7.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import "UIViewController+GetLocalDic.h"

@implementation UIViewController (GetLocalDic)

- (NSDictionary *)getLocalDic
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"my.plist"];
    
    NSDictionary *getDic = [NSDictionary dictionaryWithContentsOfFile:filename];
    
    return getDic;
}

@end
