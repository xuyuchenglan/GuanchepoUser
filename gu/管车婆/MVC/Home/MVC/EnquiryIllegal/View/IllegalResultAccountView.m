//
//  IllegalResultAccountView.m
//  管车婆
//
//  Created by 李伟 on 16/10/15.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "IllegalResultAccountView.h"

@interface IllegalResultAccountView()
{
    UILabel *_accountLB;
    UILabel *_titleLB;
}
@end

@implementation IllegalResultAccountView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _accountLB = [[UILabel alloc] initWithFrame:CGRectMake(0, kSelfHeight/4 + 3*kRate, kSelfWidth, kSelfHeight/4)];
        _accountLB.textAlignment = NSTextAlignmentCenter;
        _accountLB.font = [UIFont systemFontOfSize:14.0*kRate];
        _accountLB.textColor = kRGBColor(22, 129, 251);
        [self addSubview:_accountLB];
        
        _titleLB = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_accountLB.frame) + 5, kSelfWidth, kSelfHeight/4)];
        _titleLB.textAlignment = NSTextAlignmentCenter;
        _titleLB.font = [UIFont systemFontOfSize:13.0*kRate];
        [self addSubview:_titleLB];
        
    }
    
    return self;
}

- (void)layoutSubviews
{
    _accountLB.text = _account;
    _titleLB.text = _title;
}

@end
