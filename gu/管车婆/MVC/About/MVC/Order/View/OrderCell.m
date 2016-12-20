//
//  OrderCell.m
//  管车婆
//
//  Created by 李伟 on 16/10/20.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "OrderCell.h"
#import "ItemAndCountView.h"
#import "OrderModel.h"

@interface OrderCell()
{
    UIImageView         *_headImgView;//门店快照
    UILabel             *_nameLB;//店名
    UILabel             *_stateLabel;//交易状态
    UIView              *_line1;//第一条分割线
    ItemAndCountView    *_itemAndCountView;//服务项目和数量
    UILabel             *_orderWay;//下单方式
    UIView              *_line2;//第二条分割线
    UILabel             *_addressLB;//地址
    UIButton            *_navBtn;//导航按钮
    UIButton            *_phoneBtn;//电话按钮
    UIButton            *_oneMoreOrderBtn;//再来一单按钮
    UIButton            *_commentBtn;//评论按钮
}
@end

@implementation OrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        //第一部分：头像、店名、交易状态、第一条分割线
        [self addFirstContent];
        
        //第二部分：服务项目、服务项目数量
        [self addSecondContent];
        
        //第三部分：下单方式、第二条分割线、地址、导航、电话、再来一单、评论
        [self addThirdContent];
        
    }
    
    return self;
}

//第一部分：头像、店名、交易状态、第一条分割线
- (void)addFirstContent
{
    _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10*kRate, 10*kRate, 50*kRate, 50*kRate)];
    _headImgView.layer.cornerRadius = 25*kRate;
    _headImgView.layer.masksToBounds = YES;
    [self.contentView addSubview:_headImgView];
    
    _line1 = [[UIView alloc] init];
    _line1.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
    [self.contentView addSubview:_line1];
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - CGRectGetMaxX(_headImgView.frame) + 5*kRate, 1*kRate));
        make.left.equalTo(_headImgView.mas_right).with.offset(5*kRate);
        make.top.equalTo(self.contentView).with.offset(10*kRate + 50*kRate/2);
    }];
    
    _nameLB = [[UILabel alloc] init];
    _nameLB.font = [UIFont systemFontOfSize:15.0*kRate];
    _nameLB.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_nameLB];
    [_nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200*kRate, 20*kRate));
        make.bottom.equalTo(_line1.mas_top).with.offset(-5*kRate);
        make.left.equalTo(_headImgView.mas_right).with.offset(6*kRate);
    }];
    
    _stateLabel = [[UILabel alloc] init];
    _stateLabel.font = [UIFont systemFontOfSize:13.0*kRate];
    _stateLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:_stateLabel];
    [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60*kRate, 20*kRate));
        make.right.equalTo(self.contentView).with.offset(-30*kRate);
        make.bottom.equalTo(_line1.mas_top).with.offset(-5*kRate);
    }];
}


//第二部分：服务项目、服务项目数量
- (void)addSecondContent
{
    //服务项目及其数量
    OrderModel *orderModel = [[OrderModel alloc] init];
    orderModel.itemStr = @"会员银卡&全方位洗车";
    orderModel.itemCount = @"x 1";
    
    NSArray *arr = [NSArray arrayWithObjects:orderModel, orderModel, orderModel, nil];
    
    _itemAndCountView = [[ItemAndCountView alloc] init];
    [self.contentView addSubview:_itemAndCountView];
    [_itemAndCountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 10*kRate - 50*kRate - 6*kRate - 30*kRate, 20*kRate * arr.count));
        make.top.equalTo(_line1.mas_bottom).with.offset(5*kRate);
        make.left.equalTo(_headImgView.mas_right).with.offset(6*kRate);
    }];
    _itemAndCountView.modelsArr = arr;
    
    //下单方式
    _orderWay = [[UILabel alloc] init];
    _orderWay.textAlignment = NSTextAlignmentRight;
    _orderWay.font = [UIFont systemFontOfSize:13.0*kRate];
    [self.contentView addSubview:_orderWay];
    [_orderWay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 10*kRate, 20*kRate));
        make.top.equalTo(_itemAndCountView.mas_bottom).with.offset(10*kRate);
        make.right.equalTo(self.contentView).with.offset(-10*kRate);
    }];
    
    
}


//第三部分：下单方式、第二条分割线、地址、导航、电话、再来一单、评论
- (void)addThirdContent
{
    _line2 = [[UILabel alloc] init];
    _line2.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
    [self.contentView addSubview:_line2];
    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 1*kRate));
        make.top.equalTo(_orderWay.mas_bottom).with.offset(5*kRate);
        
    }];
    
    _addressLB = [[UILabel alloc] init];
    _addressLB.font = [UIFont systemFontOfSize:12*kRate];
    _addressLB.adjustsFontSizeToFitWidth = YES;
    _addressLB.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    [self.contentView addSubview:_addressLB];
    [_addressLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(140*kRate, 22*kRate));
        make.left.equalTo(self.contentView).with.offset(15*kRate);
        make.top.equalTo(_line2.mas_bottom).with.offset(8*kRate);
    }];
    
    _navBtn = [[UIButton alloc] init];
    [_navBtn addTarget:self action:@selector(navBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_navBtn setImage:[UIImage imageNamed:@"about_order_nav"] forState:UIControlStateNormal];
    _navBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 33*kRate);
    [_navBtn setTitle:@"导航" forState:UIControlStateNormal];
    _navBtn.titleLabel.font = [UIFont systemFontOfSize:13.0*kRate];
    [_navBtn setTitleColor:[UIColor colorWithWhite:0.2 alpha:1] forState:UIControlStateNormal];
    _navBtn.titleEdgeInsets = UIEdgeInsetsMake(2*kRate, -_navBtn.titleLabel.bounds.size.width - 30*kRate, 0, 0);
    [self.contentView addSubview:_navBtn];
    [_navBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50*kRate, 22*kRate));
        make.left.equalTo(_addressLB.mas_right).with.offset(5*kRate);
        make.top.equalTo(_line2.mas_bottom).with.offset(8*kRate);
    }];
    
    _phoneBtn = [[UIButton alloc] init];
    [_phoneBtn addTarget:self action:@selector(phoneBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_phoneBtn setImage:[UIImage imageNamed:@"about_order_phone"] forState:UIControlStateNormal];
    [self.contentView addSubview:_phoneBtn];
    [_phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20*kRate, 22*kRate));
        make.left.equalTo(_navBtn.mas_right).with.offset(20*kRate);
        make.top.equalTo(_line2.mas_bottom).with.offset(8*kRate);
    }];
    
    _commentBtn = [[UIButton alloc] init];
    [_commentBtn addTarget:self action:@selector(commentBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_commentBtn setBackgroundImage:[UIImage imageNamed:@"about_order_comment"] forState:UIControlStateNormal];
    [_commentBtn setBackgroundImage:[UIImage imageNamed:@"about_order_comment_selected"] forState:UIControlStateHighlighted];
    [_commentBtn setTitle:@"评论" forState:UIControlStateNormal];
    _commentBtn.titleLabel.font = [UIFont systemFontOfSize:13.0*kRate];
    [_commentBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_commentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    _commentBtn.titleLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:_commentBtn];
    [_commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60*kRate, 22*kRate));
        make.right.equalTo(self.contentView).with.offset(-10*kRate);
        make.top.equalTo(_line2.mas_bottom).with.offset(8*kRate);
    }];
    
    _oneMoreOrderBtn = [[UIButton alloc] init];
    [_oneMoreOrderBtn addTarget:self action:@selector(oneMoreOrderBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_oneMoreOrderBtn setBackgroundImage:[UIImage imageNamed:@"about_order_oneMoreOrder"] forState:UIControlStateNormal];
    [_oneMoreOrderBtn setBackgroundImage:[UIImage imageNamed:@"about_order_oneMoreOrder_selected"] forState:UIControlStateHighlighted];
    [_oneMoreOrderBtn setTitle:@"再来一单" forState:UIControlStateNormal];
    _oneMoreOrderBtn.titleLabel.font = [UIFont systemFontOfSize:13.0*kRate];
    [_oneMoreOrderBtn setTitleColor:[UIColor colorWithWhite:0.3 alpha:1] forState:UIControlStateNormal];
    [_oneMoreOrderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.contentView addSubview:_oneMoreOrderBtn];
    [_oneMoreOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60*kRate, 22*kRate));
        make.right.equalTo(_commentBtn.mas_left).with.offset(-10*kRate);
        make.top.equalTo(_line2.mas_bottom).with.offset(8*kRate);
    }];
}

- (void)layoutSubviews
{
//    _headImgView.image = [UIImage imageNamed:@"about_order_head"];
    [_headImgView sd_setImageWithURL:self.orderModel.headImgUrl placeholderImage:[UIImage imageNamed:@"about_order_head"]];
//    _nameLB.text = @"德州市经济开发区小拇指汽修店";
    _nameLB.text = self.orderModel.nameStr;
    _stateLabel.text = @"交易成功";
    _orderWay.text = @"下单方式：扫码下单";
//    _addressLB.text = @"德州经济开发区体育中心对过";
    _addressLB.text = self.orderModel.addressStr;
    
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 10*kRate;
    
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

//再来一单
- (void)oneMoreOrderBtnAction
{
    NSLog(@"再来一单");
}

//评论
- (void)commentBtnAction
{
    NSLog(@"评论");
}

@end
