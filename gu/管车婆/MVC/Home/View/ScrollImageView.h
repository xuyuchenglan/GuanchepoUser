//
//  ScrollImageView.h
//  ScrollView实现图片轮播
//
//  Created by 李伟 on 16/8/9.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScrollImageView;
@protocol ScrollImageViewDelegate <NSObject>
-(void)scrollImageView:(ScrollImageView *)srollImageView didTapImageView:(UIImageView *)image atIndex:(NSInteger)index;
@end

@interface ScrollImageView : UIView

@property (nonatomic, unsafe_unretained)id<ScrollImageViewDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame andPictureUrls:(NSArray *)urls andPlaceHolderImages:(NSArray *)images;

@end
