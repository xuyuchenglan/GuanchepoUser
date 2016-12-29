//
//  CouponItemView.m
//  管车婆
//
//  Created by 李伟 on 16/10/25.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "CouponItemView.h"

@interface CouponItemView()
{
    UIImageView *imgView;
    UILabel *titleLB;
    UILabel *chargeLB;
    UILabel *countLB;
    UIButton *changeBtn;
    UIButton *deleteBtn;
}
@end

@implementation CouponItemView

- (void)setCouponModel:(CouponModel *)couponModel
{
    imgView = [[UIImageView alloc] init];
    imgView.image = [UIImage imageNamed:couponModel.itemImg];
    [self addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(55*kRate, 55*kRate));
        make.left.equalTo(self).with.offset(20*kRate);
        make.top.equalTo(self).with.offset(10*kRate);
    }];
    
    titleLB = [[UILabel alloc] init];
    titleLB.text = couponModel.itemTitle;
    titleLB.font = [UIFont systemFontOfSize:14.0*kRate];
    [self addSubview:titleLB];
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150*kRate, 20*kRate));
        make.left.equalTo(imgView.mas_right).with.offset(5*kRate);
        make.top.equalTo(self).with.offset(10*kRate);
    }];
    
    chargeLB = [[UILabel alloc] init];
    chargeLB.text = couponModel.itemCharge;
    chargeLB.textColor = [UIColor redColor];
    chargeLB.font = [UIFont systemFontOfSize:14.0*kRate];
    [self addSubview:chargeLB];
    [chargeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*kRate, 20*kRate));
        make.left.equalTo(imgView.mas_right).with.offset(5*kRate);
        make.top.equalTo(titleLB.mas_bottom).with.offset(15*kRate);
    }];
    
    countLB = [[UILabel alloc] init];
    countLB.text = couponModel.itemCount;
    countLB.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    countLB.font = [UIFont systemFontOfSize:14.0*kRate];
    [self addSubview:countLB];
    [countLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50*kRate, 20*kRate));
        make.right.equalTo(self).with.offset(-20*kRate);
        make.top.equalTo(titleLB.mas_bottom).with.offset(15*kRate);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handing) name:@"editBtn" object:nil];
}

- (void)handing
{
    NSLog(@"编辑");
    NSLog(@"%@", changeBtn);
    
    if (changeBtn.superview) {
        
        NSLog(@"删除");
        [changeBtn removeFromSuperview];
        [deleteBtn removeFromSuperview];
        
    } else {
        
        NSLog(@"增加");
        //更换按钮
        changeBtn = [[UIButton alloc] init];
        [changeBtn setBackgroundImage:[UIImage imageNamed:@"stores_btnBorder_red"] forState:UIControlStateNormal];
        [changeBtn setTitle:@"更换" forState:UIControlStateNormal];
        [changeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        changeBtn.titleLabel.font = [UIFont systemFontOfSize:15.0*kRate];
        [changeBtn addTarget:self action:@selector(changeBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:changeBtn];
        [changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60*kRate, 30*kRate));
            make.right.equalTo(self).with.offset(-20*kRate);
            make.top.equalTo(self).with.offset(10*kRate);
        }];
        
        
        //删除按钮
        deleteBtn = [[UIButton alloc] init];
        [deleteBtn setBackgroundImage:[UIImage imageNamed:@"stores_btnBorder_blue"] forState:UIControlStateNormal];
        [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [deleteBtn setTitleColor:kRGBColor(22, 129, 251) forState:UIControlStateNormal];
        deleteBtn.titleLabel.font = [UIFont systemFontOfSize:15.0*kRate];
        [deleteBtn addTarget:self action:@selector(deleteBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteBtn];
        [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60*kRate, 30*kRate));
            make.right.equalTo(changeBtn.mas_left).with.offset(-20*kRate);
            make.top.equalTo(self).with.offset(10*kRate);
        }];

        
    }
    
    
    
}

#pragma mark ButtonAction
- (void)deleteBtnAction
{
    NSLog(@"删除");
}

- (void)changeBtnAction
{
    NSLog(@"更换");
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
