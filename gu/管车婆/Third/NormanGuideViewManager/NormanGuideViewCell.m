//
//  NormanGuideViewCell.m
//  引导页
//
//  Created by 李伟 on 16/8/4.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "NormanGuideViewCell.h"
#import "NormanGuideView.h"


@implementation NormanGuideViewCell

- (instancetype)init {
    if (self = [super init]) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.layer.masksToBounds = YES;
    self.imageView = [[UIImageView alloc]initWithFrame:kNormanGuideViewBounds];
    self.imageView.center = CGPointMake(kNormanGuideViewBounds.size.width / 2, kNormanGuideViewBounds.size.height / 2);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.hidden = YES;
    [button setFrame:CGRectMake(0, 0, 200, 44)];
    [button setTitle:@"立即体验" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button.layer setCornerRadius:5];
    [button.layer setBorderColor:[UIColor grayColor].CGColor];
    [button.layer setBorderWidth:1.0f];
    [button setBackgroundColor:[UIColor whiteColor]];
    
    self.button = button;
    
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.button];
    
    [self.button setCenter:CGPointMake(kNormanGuideViewBounds.size.width / 2, kNormanGuideViewBounds.size.height - 100)];
}


@end
