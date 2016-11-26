//
//  UIControlFlagView.h
//  自定义点赞控件
//
//  Created by 李伟 on 16/11/16.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarOwnersModel.h"


@interface UIControlFlagView : UIControl

@property (nonatomic, strong) UIImage *noStateImg;
@property (nonatomic, strong) UIImage *yesStateImg;
@property (nonatomic, strong) UIImage *defaultStateImg;

@property (nonatomic, assign) UIControlFlagMode flag;

- (void)setFlag:(UIControlFlagMode)flag withAnimation:(BOOL)animation;

@end
