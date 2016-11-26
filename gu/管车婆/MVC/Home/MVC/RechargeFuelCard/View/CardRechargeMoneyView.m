//
//  CardRechargeMoneyView.m
//  管车婆
//
//  Created by 李伟 on 16/10/27.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "CardRechargeMoneyView.h"

#define kCardRechargeMoneyViewWidth (kScreenWidth-30*kRate*4)/3

@interface CardRechargeMoneyView()
{
    UIImageView *_bgImgView;
    UILabel     *_moneyLB;
}
@property (nonatomic, assign)BOOL isSelected;
@end

@implementation CardRechargeMoneyView


- (void)setMoney:(NSString *)money
{
    _isSelected = NO;
    
    _bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kCardRechargeMoneyViewWidth, 50*kRate)];
    _bgImgView.image = [UIImage imageNamed:@"home_forth_rechargeFuelcard_money_unselected"];
    _bgImgView.userInteractionEnabled = YES;
    [self addSubview:_bgImgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [_bgImgView addGestureRecognizer:tap];
    
    
    _moneyLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kCardRechargeMoneyViewWidth          , 50*kRate)];
    _moneyLB.textAlignment = NSTextAlignmentCenter;
    _moneyLB.text = money;
    _moneyLB.font = [UIFont systemFontOfSize:16.0*kRate];
    [_bgImgView addSubview:_moneyLB];
    
}

- (void)tapAction
{
    _isSelected = !_isSelected;
    
    if (_isSelected) {
        
        _bgImgView.image = [UIImage imageNamed:@"home_forth_rechargeFuelcard_money_selected"];
        _moneyLB.textColor = [UIColor whiteColor];
        
    } else {
        
        _bgImgView.image = [UIImage imageNamed:@"home_forth_rechargeFuelcard_money_unselected"];
        _moneyLB.textColor = [UIColor blackColor];
        
    }
}

@end
