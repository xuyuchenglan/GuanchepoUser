//
//  CarOwnersModel.h
//  管车婆
//
//  Created by 李伟 on 16/11/16.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, UIControlFlagMode) {
    FlagModelNO,
    FlagModelYES,
    FlagModelDefalt
};

@interface CarOwnersModel : NSObject

@property (nonatomic, assign) UIControlFlagMode flag;
@property (nonatomic, assign) int               likedCount;

@end
