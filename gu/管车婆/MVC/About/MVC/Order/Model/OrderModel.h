//
//  OrderModel.h
//  管车婆
//
//  Created by 李伟 on 16/10/20.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject

@property (nonatomic, strong)NSString       *headImgStr;
@property (nonatomic, strong)NSString       *nameStr;
@property (nonatomic, strong)NSString       *stateStr;
@property (nonatomic, copy)  NSArray        *itemArr;


@property (nonatomic, strong)NSString *itemStr;
@property (nonatomic, strong)NSString *itemCount;

@end
