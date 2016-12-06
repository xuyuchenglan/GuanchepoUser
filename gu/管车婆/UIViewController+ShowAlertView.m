//
//  UIViewController+ShowAlertView.m
//  管车婆
//
//  Created by 李伟 on 16/12/5.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import "UIViewController+ShowAlertView.h"

@implementation UIViewController (ShowAlertView)

//弹出提示框
- (void)showAlertViewWithTitle:(NSString *)title WithMessage:(NSString *)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];//上拉菜单样式
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];//好的按钮
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];//这种弹出方式会在原来视图的背景下弹出一个视图。
}

@end
