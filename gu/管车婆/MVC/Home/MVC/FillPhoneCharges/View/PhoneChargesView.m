//
//  PhoneChargesView.m
//  管车婆
//
//  Created by 李伟 on 16/10/11.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "PhoneChargesView.h"

@interface PhoneChargesView()
{
    UIImageView  *bgView;
    UILabel      *originalPriceLB;
    UILabel      *discountedPriceLB;
}
@property (nonatomic, assign)BOOL isSelected;
@end

@implementation PhoneChargesView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _isSelected = NO;
        
        bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [bgView setImage:[UIImage imageNamed:@"home_forth_phonecharge.png"]];
        [self addSubview:bgView];
        
        originalPriceLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 5*kRate, kSelfWidth, kSelfHeight/2 - 5*kRate)];
        originalPriceLB.textAlignment = NSTextAlignmentCenter;
        originalPriceLB.font = [UIFont systemFontOfSize:22*kRate];
        originalPriceLB.textColor = kRGBColor(64, 129, 251);
        [self addSubview:originalPriceLB];
        
        discountedPriceLB = [[UILabel alloc] initWithFrame:CGRectMake(0, kSelfHeight/2, kSelfWidth, kSelfHeight/2 - 5*kRate)];
        discountedPriceLB.textAlignment = NSTextAlignmentCenter;
        discountedPriceLB.font = [UIFont systemFontOfSize:16.0*kRate];
        discountedPriceLB.textColor = kRGBColor(64, 129, 251);
        [self addSubview:discountedPriceLB];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [self addGestureRecognizer:tap];
        
    }
    
    return self;
}

- (void)tapAction
{
    NSLog(@"充值%@", _originalPrice);
    
    _isSelected = !_isSelected;
    
    if (_isSelected) {
        
        NSLog(@"选中");
        [bgView setImage:[UIImage imageNamed:@"home_forth_phoneCharge_selected"]];
        originalPriceLB.textColor = [UIColor whiteColor];
        discountedPriceLB.textColor = [UIColor whiteColor];
        
    } else {
        
        NSLog(@"未选中");
        [bgView setImage:[UIImage imageNamed:@"home_forth_phonecharge.png"]];
        originalPriceLB.textColor = kRGBColor(64, 129, 251);
        discountedPriceLB.textColor = kRGBColor(64, 129, 251);
        
    }
}

- (void)layoutSubviews
{
    originalPriceLB.text = _originalPrice;
    discountedPriceLB.text = _discountedPrice;

}


@end
