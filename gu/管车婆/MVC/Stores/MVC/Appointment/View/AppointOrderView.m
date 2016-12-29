//
//  AppointOrderView.m
//  管车婆
//
//  Created by 李伟 on 16/12/12.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import "AppointOrderView.h"
#import "NormanStarRateView.h"

@interface AppointOrderView()
{
    UILabel             *_titleLB;//车行名字
    NormanStarRateView  *_starRateView;//星星评分视图
    UILabel             *_scoreLB;//评分
    UIView              *_countView;//单数、评论数所在的视图
    UILabel             *_orderCountLB;//订单数
    UIButton            *_commentCountBtn;//评论数
    UILabel             *_descriptionLB;//描述
    UILabel             *_addressLB;//地址
    UIButton            *_phoneBtn;//电话
    UIButton            *_navBtn;//导航
    
}
@end

@implementation AppointOrderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        //车行名字
        _titleLB = [[UILabel alloc] init];
        _titleLB.adjustsFontSizeToFitWidth = YES;
        _titleLB.font = [UIFont systemFontOfSize:18.0*kRate];
        [self addSubview:_titleLB];
        [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(260*kRate, 20*kRate));
            make.top.equalTo(self).with.offset(15*kRate);
            make.left.equalTo(self).with.offset(15*kRate);
        }];
        
        //星星评分视图
        [self addStarRateView];
        
        //装载订单数、评论数的view
        [self addAccountView];

        //描述
        _descriptionLB = [[UILabel alloc] init];
        _descriptionLB.font = [UIFont systemFontOfSize:15.0*kRate];
        _descriptionLB.numberOfLines = 2;
        _descriptionLB.textColor = [UIColor colorWithWhite:0.4 alpha:1];
        [self addSubview:_descriptionLB];
        [_descriptionLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenWidth-30*kRate, 60*kRate));
            make.left.equalTo(self).with.offset(15*kRate);
            make.top.equalTo(_orderCountLB.mas_bottom).with.offset(0);
        }];
        
        //分割线
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenWidth, 1*kRate));
            make.left.equalTo(self).with.offset(0);
            make.top.equalTo(_descriptionLB.mas_bottom).with.offset(0);
        }];
        
        //地址
        _addressLB = [[UILabel alloc] init];
        _addressLB.font = [UIFont systemFontOfSize:13.0*kRate];
        _addressLB.textColor = [UIColor colorWithWhite:0.5 alpha:1];
        _addressLB.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_addressLB];
        [_addressLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200*kRate, 20*kRate));
            make.left.equalTo(self).with.offset(15*kRate);
            make.top.equalTo(line.mas_bottom).with.offset(5*kRate);
        }];
        
        //电话按钮
        [self addPhoneBtn];
        
        //导航按钮
        [self addNavBtn];
        
        
        
    }
    return self;
}

//星星评分视图
- (void)addStarRateView
{
    _starRateView = [[NormanStarRateView alloc] initWithFrame:CGRectMake(kScreenWidth-95*kRate, 10*kRate, 60*kRate, 20*kRate) numberOfStars:5];
    _starRateView.allowIncompleteStar = YES;//是否允许评分为小数
    _starRateView.allowTouch = NO;//是否允许点击星星视图
    _starRateView.hasAnimation = YES;
    [self addSubview:_starRateView];
    
    _scoreLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_starRateView.frame) + 2*kRate, 10*kRate, 20*kRate, 20*kRate)];
    _scoreLB.font = [UIFont systemFontOfSize:10*kRate];
    _scoreLB.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    [self addSubview:_scoreLB];
    
}

//装载订单数、评论数的view
- (void)addAccountView
{
    _countView = [UIView new];
    [self addSubview:_countView];
    [_countView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80*kRate, 20*kRate));
        make.right.equalTo(self).with.offset(-15*kRate);
        make.top.equalTo(_starRateView.mas_bottom).with.offset(0);
    }];
    
    _orderCountLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30*kRate, 20*kRate)];
    _orderCountLB.font = [UIFont systemFontOfSize:11*kRate];
    _orderCountLB.adjustsFontSizeToFitWidth = YES;
    _orderCountLB.textColor = [UIColor colorWithWhite:0.4 alpha:1];
    [_countView addSubview:_orderCountLB];
    
    _commentCountBtn = [[UIButton alloc] initWithFrame:CGRectMake(35*kRate, 0, 45*kRate, 20*kRate)];
    [_commentCountBtn addTarget:self action:@selector(commentBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_commentCountBtn setTitleColor:kRGBColor(22, 129, 252) forState:UIControlStateNormal];
    _commentCountBtn.titleLabel.font = [UIFont systemFontOfSize:11.0*kRate];
    _commentCountBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    _commentCountBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [_countView addSubview:_commentCountBtn];
    
}

//电话按钮
- (void)addPhoneBtn
{
    _phoneBtn = [[UIButton alloc] init];
    [_phoneBtn addTarget:self action:@selector(phoneBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_phoneBtn];
    [_phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50*kRate, 20*kRate));
        make.right.equalTo(@(-15*kRate));
        make.top.equalTo(_addressLB.mas_top).with.offset(0);
    }];
    
    [_phoneBtn setImage:[UIImage imageNamed:@"stores_telephone"] forState:UIControlStateNormal];
    _phoneBtn.imageEdgeInsets = UIEdgeInsetsMake(3*kRate, 0, 3*kRate, 38*kRate);
    
    [_phoneBtn setTitle:@"电话" forState:UIControlStateNormal];
    _phoneBtn.titleLabel.font = [UIFont systemFontOfSize:12*kRate];
    [_phoneBtn setTitleColor:[UIColor colorWithWhite:0.4 alpha:1] forState:UIControlStateNormal];
    _phoneBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -_phoneBtn.titleLabel.bounds.size.width - 15*kRate, 0, 0);
}

//导航按钮
- (void)addNavBtn
{
    _navBtn = [[UIButton alloc] init];
    [_navBtn addTarget:self action:@selector(navBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_navBtn];
    [_navBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50*kRate, 20*kRate));
//        make.right.equalTo(@(-15*kRate));
        make.right.equalTo(_phoneBtn.mas_left).with.offset(-20*kRate);
        make.top.equalTo(_addressLB.mas_top).with.offset(0);
    }];
    
    [_navBtn setImage:[UIImage imageNamed:@"stores_navigation"] forState:UIControlStateNormal];
    _navBtn.imageEdgeInsets = UIEdgeInsetsMake(3*kRate, 0, 3*kRate, 38*kRate);
    
    [_navBtn setTitle:@"导航" forState:UIControlStateNormal];
    _navBtn.titleLabel.font = [UIFont systemFontOfSize:12*kRate];
    [_navBtn setTitleColor:[UIColor colorWithWhite:0.4 alpha:1] forState:UIControlStateNormal];
    _navBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -_navBtn.titleLabel.bounds.size.width - 15*kRate, 0, 0);
}



#pragma mark ButtonAction
//评论
- (void)commentBtnAction
{
    NSLog(@"评论");
}

//导航
- (void)navBtnAction
{
    NSLog(@"导航");
}


//电话
- (void)phoneBtnAction
{
    NSLog(@"电话");
}

#pragma mark
- (void)layoutSubviews
{
    _titleLB.text = _storeModel.mname;
    _starRateView.scorePercent = _storeModel.starPercent;//设置初始评分(其实是个比例，范围是0-1)
    _scoreLB.text = _storeModel.starCount;
    _orderCountLB.text = [NSString stringWithFormat:@"%@单", _storeModel.orderCount];
    [_commentCountBtn setTitle:[NSString stringWithFormat:@"%@评论>", _storeModel.evaluateCount] forState:UIControlStateNormal];
    _descriptionLB.text = _storeModel.mdesc;
    _addressLB.text = _storeModel.maddress;
}
@end
