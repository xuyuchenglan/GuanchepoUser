//
//  NormanStarRateView.h
//  星星视图
//
//  Created by 李伟 on 16/8/4.
//  Copyright © 2016年 李伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NormanStarRateView;
@protocol NormanStarRateViewDelegate <NSObject>
@optional
- (void)starRateView:(NormanStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent;
@end

@interface NormanStarRateView : UIView

//required
@property (nonatomic, assign) BOOL isEvaluating;//yes表示正在评分，no表示展示评分

@property (nonatomic, assign) CGFloat scorePercent;//得分值，范围为0--1，默认为1
@property (nonatomic, assign) BOOL hasAnimation;//是否允许动画，默认为NO
@property (nonatomic, assign) BOOL allowIncompleteStar;//评分时是否允许不是整星，默认为NO
@property (nonatomic, assign) BOOL allowTouch;//是否允许点击，默认为yes  

@property (nonatomic, weak) id<NormanStarRateViewDelegate>delegate;

//初始化星星视图
- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars;


@end
