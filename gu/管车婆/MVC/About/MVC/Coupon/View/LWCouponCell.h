//
//  LWCouponCell.h
//  管车婆
//
//  Created by 李伟 on 16/11/10.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AboutCouponModel;
@interface LWCouponCell : UITableViewCell

@property (nonatomic, strong)NSString *type;

@property(nonatomic, strong)AboutCouponModel *aboutCouponModel;

@end
