//
//  LoginParentVC.h
//  管车婆
//
//  Created by 李伟 on 16/9/29.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginParentVC : UIViewController

- (void)setNavigationItemTitle:(NSString *)title;//导航栏标题(文字)

- (void)setBackButtonWithIsText:(BOOL)isText_noImage withIsExit:(BOOL)isExit WithText:(NSString *)text WithImageName:(NSString *)imageName;//设置返回按钮

- (void)saveDataToPlistWithDic:(NSDictionary *)contentDic;//保存数据到本地
@end
