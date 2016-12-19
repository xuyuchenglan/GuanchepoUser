//
//  StoreCell.h
//  管车婆
//
//  Created by 李伟 on 16/9/29.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreModel.h"

@interface StoreCell : UITableViewCell

@property (nonatomic, strong)StoreModel *storeModel;

@property (nonatomic, weak)UIViewController *vc;

@end
