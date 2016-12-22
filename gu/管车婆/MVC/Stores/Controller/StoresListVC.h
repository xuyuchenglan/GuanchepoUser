//
//  StoresListVC.h
//  管车婆
//
//  Created by 李伟 on 16/9/28.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoresListVC : UIViewController

@property (nonatomic, strong)NSString *type;//区分storeListVC，以确保在点击选择细分服务后，只有相应的页面会收到通知，而不是所有的storeListVC都会收到通知

@property (nonatomic, strong)NSString *name;//二级细分服务名字
@property (nonatomic, strong)NSString *sid;//二级细分服务id

@property (nonatomic, weak)UIViewController *vc;

@end
