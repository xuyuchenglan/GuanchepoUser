//
//  CarOwnersCell.h
//  管车婆
//
//  Created by 李伟 on 16/10/11.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarOwnersModel.h"
#import "NewsModel.h"

@interface CarOwnersCell : UITableViewCell

@property (nonatomic, strong)CarOwnersModel *carOwnersModel;
@property (nonatomic, strong)NewsModel      *newsModel;

@end
