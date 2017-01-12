//
//  CarCouponCell.h
//  管车婆
//
//  Created by 李伟 on 16/11/3.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarCouponModel.h"

@interface CarCouponCell : UITableViewCell

@property (nonatomic, strong)NSString *type;
@property (nonatomic, strong)CarCouponModel *carCouponModel;

@end
