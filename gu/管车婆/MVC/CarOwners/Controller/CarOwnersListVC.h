//
//  CarOwnersListVC.h
//  管车婆
//
//  Created by 李伟 on 16/9/28.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarOwnersListVC : UIViewController

@property (nonatomic, strong)NSString *type;

@property (nonatomic, weak)UIViewController *vc;//目的在于找到能够执行push页面跳转的响应者

@end
