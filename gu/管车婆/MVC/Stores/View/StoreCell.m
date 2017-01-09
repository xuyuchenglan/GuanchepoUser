//
//  StoreCell.m
//  管车婆
//
//  Created by 李伟 on 16/9/29.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "StoreCell.h"
#import "NormanStarRateView.h"
#import "BuyCouponVC.h"
//#import "StoresViewController.h"
#import "LWOrderVC.h"
#import "LWAppointmentVc.h"

#define kHeadImgWidth kScreenWidth*2/7

@interface StoreCell()
{
    UIImageView         *_headImgView;//门店快照
    UILabel             *_nameLB;//店名
    NormanStarRateView  *_starRateView;//星星评分视图
    UILabel             *_scoreLB;//评分
    UILabel             *_addressLB;//地址
    UIButton            *_navbtn;//导航按钮
    UILabel             *_phoneNumberLB;//电话
    UIButton            *_phoneBtn;//电话按钮
    UIView              *_accountView;//单数、评论数所在的视图
    UILabel             *_orderAccountLB;//单数
    UILabel             *_commentAccountLB;//评论数
    UIView              *_btnView;//预约、下单、买券按钮所在的视图
    UIButton            *_appointBtn;//预约
    UIButton            *_orderBtn;//下单
    UIButton            *_buyCouponBtn;//买券
    
}
@end

@implementation StoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    //
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        _headImgView = [[UIImageView alloc] init];
        [self.contentView addSubview:_headImgView];
        [_headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kHeadImgWidth, kHeadImgWidth*0.85));
            make.top.mas_equalTo(@10);
            make.left.mas_equalTo(@15);
        }];
        
        _nameLB = [[UILabel alloc] init];
        _nameLB.font = [UIFont systemFontOfSize:12.5*kRate];
        _nameLB.textColor = [UIColor colorWithWhite:0.2 alpha:1];
        _nameLB.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_nameLB];
        [_nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(180*kRate, 20*kRate));
            make.left.equalTo(_headImgView.mas_right).with.offset(8*kRate);
            make.top.equalTo(@(15*kRate));
        }];
        
        //星星评分视图
        [self addStarRateView];
        
        //地址
        _addressLB = [[UILabel alloc] init];
        _addressLB.font = [UIFont systemFontOfSize:10*kRate];
        _addressLB.textColor = [UIColor colorWithWhite:0.4 alpha:1];
        [self.contentView addSubview:_addressLB];
        [_addressLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(180*kRate, 20*kRate));
            make.top.equalTo(_nameLB.mas_bottom).with.offset(10*kRate);
            make.left.equalTo(_headImgView.mas_right).with.offset(8*kRate);
        }];
        
        //导航按钮
        [self addNavBtn];
        
        _phoneNumberLB = [[UILabel alloc] init];
        _phoneNumberLB.font = [UIFont systemFontOfSize:10*kRate];
        _phoneNumberLB.textColor = [UIColor colorWithWhite:0.4 alpha:1];
        [self.contentView addSubview:_phoneNumberLB];
        [_phoneNumberLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(180*kRate, 20*kRate));
            make.left.equalTo(_headImgView.mas_right).with.offset(8*kRate);
            make.top.equalTo(_addressLB.mas_bottom).with.offset(0);
        }];
        
        //电话按钮
        [self addPhoneBtn];
        
        //装载订单数、评论数的view
        [self addAccountView];
        
        //装载预约、下单、买券按钮的View
        [self addBtnView];
        
    }
    
    return self;
}

//星星评分视图
- (void)addStarRateView
{
    _starRateView = [[NormanStarRateView alloc] initWithFrame:CGRectMake(kScreenWidth - 15*kRate - 50*kRate - 20*kRate, 15*kRate, 50*kRate, 20*kRate) numberOfStars:5];
    _starRateView.isEvaluating = NO;//不是正在评分，是展示评分
    _starRateView.allowIncompleteStar = YES;//是否允许评分为小数
    _starRateView.allowTouch = NO;//是否允许点击星星视图
    _starRateView.hasAnimation = NO;
    [self.contentView addSubview:_starRateView];
    
    _scoreLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_starRateView.frame) + 2*kRate, 15*kRate, 20*kRate, 20*kRate)];
    _scoreLB.font = [UIFont systemFontOfSize:10*kRate];
    _scoreLB.adjustsFontSizeToFitWidth = YES;
    _scoreLB.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    [self.contentView addSubview:_scoreLB];
    
}

//导航按钮
- (void)addNavBtn
{
    _navbtn = [[UIButton alloc] init];
    [_navbtn addTarget:self action:@selector(navBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_navbtn];
    [_navbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50*kRate, 20*kRate));
        make.right.equalTo(@(-15*kRate));
        make.top.equalTo(_nameLB.mas_bottom).with.offset(10*kRate);
    }];
    
    [_navbtn setImage:[UIImage imageNamed:@"stores_navigation"] forState:UIControlStateNormal];
    _navbtn.imageEdgeInsets = UIEdgeInsetsMake(3*kRate, 0, 3*kRate, 38*kRate);
    
    [_navbtn setTitle:@"导航" forState:UIControlStateNormal];
    _navbtn.titleLabel.font = [UIFont systemFontOfSize:12*kRate];
    [_navbtn setTitleColor:[UIColor colorWithWhite:0.4 alpha:1] forState:UIControlStateNormal];
    _navbtn.titleEdgeInsets = UIEdgeInsetsMake(0, -_navbtn.titleLabel.bounds.size.width - 15*kRate, 0, 0);
}

//电话按钮
- (void)addPhoneBtn
{
    _phoneBtn = [[UIButton alloc] init];
    [_phoneBtn addTarget:self action:@selector(phoneBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_phoneBtn];
    [_phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50*kRate, 20*kRate));
        make.right.equalTo(@(-15*kRate));
        make.top.equalTo(_addressLB.mas_bottom).with.offset(0);
    }];
    
    [_phoneBtn setImage:[UIImage imageNamed:@"stores_telephone"] forState:UIControlStateNormal];
    _phoneBtn.imageEdgeInsets = UIEdgeInsetsMake(3*kRate, 0, 3*kRate, 38*kRate);
    
    [_phoneBtn setTitle:@"电话" forState:UIControlStateNormal];
    _phoneBtn.titleLabel.font = [UIFont systemFontOfSize:12*kRate];
    [_phoneBtn setTitleColor:[UIColor colorWithWhite:0.4 alpha:1] forState:UIControlStateNormal];
    _phoneBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -_phoneBtn.titleLabel.bounds.size.width - 15*kRate, 0, 0);
}

//装载订单数、评论数的view
- (void)addAccountView
{
    _accountView = [UIView new];
    [self.contentView addSubview:_accountView];
    [_accountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(90*kRate, 20*kRate));
        make.left.equalTo(_headImgView.mas_right).with.offset(8*kRate);
        make.bottom.equalTo(@(-10*kRate));
    }];
    
    _orderAccountLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40*kRate, 20*kRate)];
    _orderAccountLB.font = [UIFont systemFontOfSize:10*kRate];
    _orderAccountLB.textColor = [UIColor colorWithWhite:0.4 alpha:1];
    [_accountView addSubview:_orderAccountLB];
    
    _commentAccountLB = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetMaxX(_orderAccountLB.frame))*kRate, 0, 40*kRate, 20*kRate)];
    _commentAccountLB.font = [UIFont systemFontOfSize:10*kRate];
    _commentAccountLB.textColor = [UIColor colorWithWhite:0.4 alpha:1];
    [_accountView addSubview:_commentAccountLB];
    
}

//装载预约、下单、买券按钮的View
- (void)addBtnView
{
    _btnView = [UIView new];
    [self.contentView addSubview:_btnView];
    [_btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(170*kRate, 20*kRate));
        make.right.equalTo(@(-15*kRate));
        make.bottom.equalTo(@(-10*kRate));
    }];
    
    _appointBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50*kRate, 20*kRate)];
    [_appointBtn addTarget:self action:@selector(appointBtnAction) forControlEvents:UIControlEventTouchUpInside];
    _appointBtn.backgroundColor = [UIColor redColor];
    [_appointBtn setTitle:@"预约" forState:UIControlStateNormal];
    _appointBtn.titleLabel.font = [UIFont systemFontOfSize:14.0*kRate];
    _appointBtn.layer.cornerRadius = 5*kRate;
    [_btnView addSubview:_appointBtn];
    
    _orderBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_appointBtn.frame) + 10*kRate, 0, 50*kRate, 20*kRate)];
    [_orderBtn addTarget:self action:@selector(orderBtnAction) forControlEvents:UIControlEventTouchUpInside];
    _orderBtn.backgroundColor = kRGBColor(22, 129, 251);
    [_orderBtn setTitle:@"下单" forState:UIControlStateNormal];
    _orderBtn.titleLabel.font = [UIFont systemFontOfSize:14.0*kRate];
    _orderBtn.layer.cornerRadius = 5*kRate;
    [_btnView addSubview:_orderBtn];
    
    _buyCouponBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_orderBtn.frame) + 10*kRate, 0, 50*kRate, 20*kRate)];
    [_buyCouponBtn addTarget:self action:@selector(buycouponBtnAction) forControlEvents:UIControlEventTouchUpInside];
    _buyCouponBtn.backgroundColor = kRGBColor(128, 129, 130);
    [_buyCouponBtn setTitle:@"买券" forState:UIControlStateNormal];
    _buyCouponBtn.titleLabel.font = [UIFont systemFontOfSize:14.0*kRate];
    _buyCouponBtn.layer.cornerRadius = 5*kRate;
    [_btnView addSubview:_buyCouponBtn];
}

- (void)layoutSubviews
{
    [_headImgView sd_setImageWithURL:_storeModel.headUrl placeholderImage:[UIImage imageNamed:@"stores_headImg"] options:SDWebImageRefreshCached];
    _nameLB.text = _storeModel.mname;
    _scoreLB.text = _storeModel.starCount;
    _addressLB.text = [NSString stringWithFormat:@"地址：%@", _storeModel.maddress];
    _phoneNumberLB.text = [NSString stringWithFormat:@"电话：%@", _storeModel.mphone];
    _starRateView.scorePercent = _storeModel.starPercent;//设置初始评分(其实是个比例，范围是0-1)
    _orderAccountLB.text = [NSString stringWithFormat:@"%@单", _storeModel.orderCount];
    _commentAccountLB.text = [NSString stringWithFormat:@"%@评论", _storeModel.evaluateCount];
    
}

//设置单元格上下左右都有边距~
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;//上下两个单元格的边距
    
    [super setFrame:frame];
}


#pragma mark ButtonAction
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

//预约
- (void)appointBtnAction
{
    NSLog(@"预约");
    
    NSString *cardno = [[self getLocalDic] objectForKey:@"cardno"];
    if (cardno.length > 0) {
        
        LWAppointmentVc *appointmentVC = [[LWAppointmentVc alloc] init];
        appointmentVC.storeModel = _storeModel;
        appointmentVC.sid = _sid;
        appointmentVC.hidesBottomBarWhenPushed = YES;
        [self.vc.navigationController pushViewController:appointmentVC animated:NO];
        
    } else {
        
        [self.vc showAlertViewWithTitle:nil WithMessage:@"您还不是管车婆的持卡会员，不能享受免费服务，您可以购买汽车券或者办理管车婆超值会员卡享受全年免费服务！"];
        
    }
    
}

//下单
- (void)orderBtnAction
{
    NSLog(@"下单");
    
    NSString *cardno = [[self getLocalDic] objectForKey:@"cardno"];
    if (cardno.length > 0) {
        
        LWOrderVC *orderVC = [[LWOrderVC alloc] init];
        orderVC.storeModel = _storeModel;
        orderVC.sid = _sid;
        orderVC.hidesBottomBarWhenPushed = YES;
        [self.vc.navigationController pushViewController:orderVC animated:NO];
        
    } else {
        
        [self.vc showAlertViewWithTitle:nil WithMessage:@"您还不是管车婆的持卡会员，不能享受免费服务，您可以购买汽车券或者办理管车婆超值会员卡享受全年免费服务！"];
        
    }
    
}

//买券
- (void)buycouponBtnAction
{
    NSLog(@"买券");
    
    BuyCouponVC *buyCouponVC = [[BuyCouponVC alloc] init];
    buyCouponVC.storeModel = _storeModel;
    buyCouponVC.hidesBottomBarWhenPushed = YES;
    [self.vc.navigationController pushViewController:buyCouponVC animated:NO];
}



@end
