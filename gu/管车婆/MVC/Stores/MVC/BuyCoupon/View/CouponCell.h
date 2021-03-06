//
//  CouponCell.h
//  管车婆
//
//  Created by 李伟 on 16/10/24.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponModel.h"
#import "StoreModel.h"

@interface CouponCell : UITableViewCell

@property (nonatomic, strong)CouponModel *couponModel;
@property (nonatomic, strong)StoreModel *storeModel;

@end
