//
//  LWAppointmentCell.m
//  管车婆
//
//  Created by 李伟 on 16/12/27.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import "LWAppointmentCell.h"
#import "ItemAndCountView.h"

@interface LWAppointmentCell()
{
    UIImageView         *_headImgView;//门店快照
    UILabel             *_nameLB;//店名
    UILabel             *_stateLabel;//交易状态
    UIView              *_line1;//第一条分割线
    ItemAndCountView    *_itemAndCountView;//服务项目和数量
    UILabel             *_appointmentTime;//预约时间
    UIView              *_line2;//第二条分割线
    UILabel             *_addressLB;//地址
    UIButton            *_navBtn;//导航按钮
    UIButton            *_phoneBtn;//电话按钮
    UIButton            *_cancelBtn;//取消预约按钮
}
@end

@implementation LWAppointmentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        //第一部分：头像、店名、交易状态、第一条分割线
        [self addFirstContent];
        
        //第二部分：服务项目、服务项目数量、预约时间
        [self addSecondContent];
        
        //第三部分：第二条分割线、地址、导航、电话
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
    
    _itemAndCountView = [[ItemAndCountView alloc] init];
    [self.contentView addSubview:_itemAndCountView];
    
    
    //下单方式，或者预约时间
    _appointmentTime = [[UILabel alloc] init];
    _appointmentTime.textAlignment = NSTextAlignmentRight;
    _appointmentTime.font = [UIFont systemFontOfSize:13.0*kRate];
    [self.contentView addSubview:_appointmentTime];
    [_appointmentTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 10*kRate, 20*kRate));
        make.top.equalTo(_itemAndCountView.mas_bottom).with.offset(10*kRate);
        make.right.equalTo(self.contentView).with.offset(-10*kRate);
    }];
    
    
}


//第三部分：第二条分割线、地址、导航、电话、取消预约
- (void)addThirdContent
{
    _line2 = [[UILabel alloc] init];
    _line2.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
    [self.contentView addSubview:_line2];
    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 1*kRate));
        make.top.equalTo(_appointmentTime.mas_bottom).with.offset(5*kRate);
        
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
    
    _cancelBtn = [[UIButton alloc] init];
    [_cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_cancelBtn setTitle:@"取消预约" forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:12*kRate];
    [_cancelBtn setBackgroundColor:[UIColor grayColor]];
    _cancelBtn.layer.cornerRadius = 5.0*kRate;
    _cancelBtn.titleLabel.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    [self.contentView addSubview:_cancelBtn];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60*kRate, 22*kRate));
        make.right.equalTo(self.contentView).with.offset(-15*kRate);
        make.top.equalTo(_line2.mas_bottom).with.offset(8*kRate);
    }];
}


- (void)setOrderModel:(OrderModel *)orderModel
{
    _orderModel = orderModel;
    
    [_headImgView sd_setImageWithURL:self.orderModel.headImgUrl placeholderImage:[UIImage imageNamed:@"about_order_head"]];
    _nameLB.text = self.orderModel.nameStr;
    _stateLabel.text = self.orderModel.state;
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"预约时间：%@", self.orderModel.appointTime_start]];
    NSRange blueRange = NSMakeRange(4, [attributedStr string].length-4);
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:blueRange];
    [_appointmentTime setAttributedText:attributedStr];
    
    _addressLB.text = self.orderModel.addressStr;
    
    _itemAndCountView.items = _orderModel.items;
    [_itemAndCountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 10*kRate - 50*kRate - 6*kRate - 30*kRate, 20*kRate * _orderModel.items.count));
        make.top.equalTo(_line1.mas_bottom).with.offset(5*kRate);
        make.left.equalTo(_headImgView.mas_right).with.offset(6*kRate);
    }];
    
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

//取消预约
- (void)cancelBtnAction
{
    NSLog(@"取消预约");
    
    NSString *url_post = [NSString stringWithFormat:@"http://%@cancelOrder.action", kHead];
    
    NSDictionary *params = @{
                             @"oid"     :  _orderModel.orderID
                             };
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = responseSerializer;
    [manager POST:url_post parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@", content);
        
        NSString *result = [content objectForKey:@"result"];
        
        NSString *errCode = [content objectForKey:@"errCode"];
        NSString *errStr = [[NSString alloc] init];
        if ([errCode isEqualToString:@"o_404"]) {
            errStr = @"该订单不存在";
        } else if ([errCode isEqualToString:@"o_1"]) {
            errStr = @"该订单不是预约订单";
        }
        
        if ([result isEqualToString:@"success"]) {
            [self.vc showAlertViewWithTitle:@"取消预约成功" WithMessage:@"您的预约已取消"];
            
            //刷新UI
            [[NSNotificationCenter defaultCenter] postNotificationName:@"cancelAppointment" object:nil];//给“全部”和“已预约”两个页面发送通知，只刷新这两个页面
            
        } else {
            [self.vc showAlertViewWithTitle:@"取消预约失败" WithMessage:errStr];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败， 失败原因是：%@", error);
    }];

}
@end
