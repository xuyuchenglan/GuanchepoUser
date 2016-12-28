//
//  OrderCell.h
//  管车婆
//
//  Created by 李伟 on 16/10/20.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

@interface OrderCell : UITableViewCell

@property (nonatomic, strong)OrderModel *orderModel;
@property (nonatomic, strong)UIViewController *vc;



@end
