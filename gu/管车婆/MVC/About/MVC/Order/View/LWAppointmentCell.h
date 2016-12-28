//
//  LWAppointmentCell.h
//  管车婆
//
//  Created by 李伟 on 16/12/27.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

@interface LWAppointmentCell : UITableViewCell

@property (nonatomic, strong)OrderModel *orderModel;
@property (nonatomic, strong)UIViewController *vc;

@end
