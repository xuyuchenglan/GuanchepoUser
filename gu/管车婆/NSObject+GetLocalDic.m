//
//  NSObject+GetLocalDic.m
//  管车婆
//
//  Created by 李伟 on 17/1/7.
//  Copyright © 2017年 远恒网络科技有限公司. All rights reserved.
//

#import "NSObject+GetLocalDic.h"

@implementation NSObject (GetLocalDic)

- (NSDictionary *)getLocalDic
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"my.plist"];
    
    NSDictionary *getDic = [NSDictionary dictionaryWithContentsOfFile:filename];
    
    return getDic;
}

@end
