//
//  CouponCell.m
//  管车婆
//
//  Created by 李伟 on 16/10/24.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "CouponCell.h"
#import "WXApi.h"
//#import "WXApiObject.h"

@interface CouponCell()
{
    UILabel  *_titleLB;
    UILabel  *_subTitleLB;
    UILabel  *_chargeLB;
    UIButton *_payBtn;
}
@property (nonatomic, assign) BOOL isOnTradning;//当点击“购买”按钮的时候修改该值，以避免所有的cell都会响应AppDelegate.m发送过来的通知。
@end

@implementation CouponCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        _isOnTradning = NO;
        
        //接收 AppDelegate.m 在验证后台支付成功后发送过来的通知，以添加店铺券
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addDianpuquan) name:@"addDianpuquan.action" object:nil];
        
        _titleLB = [[UILabel alloc] initWithFrame:CGRectMake(20*kRate, 15*kRate, 200*kRate, 20*kRate)];
        _titleLB.font = [UIFont systemFontOfSize:15.0*kRate];
        _titleLB.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_titleLB];
        
        _chargeLB = [[UILabel alloc] init];
        _chargeLB.textAlignment = NSTextAlignmentRight;
        _chargeLB.textColor = [UIColor redColor];
        _chargeLB.font = [UIFont systemFontOfSize:15.0*kRate];
        [self.contentView addSubview:_chargeLB];
        [_chargeLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60*kRate, 20*kRate));
            make.right.equalTo(self.contentView).with.offset(-23*kRate);
            make.top.equalTo(self.contentView).with.offset(15*kRate);
        }];
        
        _subTitleLB = [[UILabel alloc] init];
        _subTitleLB.font = [UIFont systemFontOfSize:13.0*kRate];
        _subTitleLB.numberOfLines = 2;
        _subTitleLB.textColor = [UIColor colorWithWhite:0.3 alpha:1];
        [self.contentView addSubview:_subTitleLB];
        [_subTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200*kRate, 40*kRate));
            make.top.equalTo(_titleLB.mas_bottom).with.offset(5*kRate);
            make.left.equalTo(self.contentView).with.offset(20*kRate);
        }];
        
        _payBtn = [[UIButton alloc] init];
        [_payBtn setTitle:@"购买" forState:UIControlStateNormal];
        _payBtn.titleLabel.font = [UIFont systemFontOfSize:15.0*kRate];
        _payBtn.backgroundColor = kRGBColor(22, 129, 251);
        _payBtn.layer.cornerRadius = 6.0*kRate;
        [_payBtn addTarget:self action:@selector(payBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_payBtn];
        [_payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80*kRate, 35*kRate));
            make.right.equalTo(self.contentView).with.offset(-20*kRate);
            make.top.equalTo(_titleLB.mas_bottom).with.offset(10*kRate);
        }];
        
    }
    
    return self;
}

#pragma mark ButtonAction
- (void)payBtnAction
{
    NSLog(@"购买按钮");
    _isOnTradning = YES;//以确保只有当前这个单元格响应  AppDelegate.m发送过来的让它添加店铺券  的通知
    [self getInfoThatCallWXPay];
}

#pragma mark
#pragma mark 网络请求
#pragma mark --- 获取调起微信支付所需的参数
- (void)getInfoThatCallWXPay
{
    NSString *url_post = [NSString stringWithFormat:@"http://%@/zcar/wxCtl/unifiedorder.action", kIP];
    
    float chargeFloat = [_couponModel.charge floatValue];
    if (chargeFloat<=0) {
        chargeFloat = 0.01;
    }
    _couponModel.charge = [NSString stringWithFormat:@"%.2f", chargeFloat];
    NSDictionary *params = @{
                             @"openid":[[self getLocalDic] objectForKey:@"phone"],//传入电话号码或微信openid   (APP支付填入phone)
                             @"price":_couponModel.charge,//金额 单位元
                             @"pName":_couponModel.title,//产品名称
                             @"zfType":@"2",//支付类型    1-微信公众号支付   2-微信APP支付
                             @"attach":@""//附加数据  可为空
                             };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = responseSerializer;
    [manager POST:url_post parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //NSLog(@"获取调起微信支付所需的参数：%@", content);
        
        NSString *result = [content objectForKey:@"result"];
        if ([result isEqualToString:@"success"]) {
            
            //给 AppDelegate.m 中发送一个通知，把后台返回的 out_trade_no 传过去。
            NSDictionary *out_trade_no_Dic = @{
                                               @"out_trade_no":[content objectForKey:@"out_trade_no"]
                                               };
            [[NSNotificationCenter defaultCenter] postNotificationName:@"out_trade_no" object:self userInfo:out_trade_no_Dic];
            
            //调起支付(除了timeStamp之外，其他五个少传哪一个都是调不起来微信支付的)
            PayReq *request = [[PayReq alloc] init];
            request.partnerId = [content objectForKey:@"mchId"];//微信支付分配的商户号
            request.prepayId= [content objectForKey:@"prepayid"];//预支付交易会话ID
            request.package = @"Sign=WXPay";//扩展字段，暂填写固定值Sign=WXPay
            request.nonceStr= [content objectForKey:@"nonceStr"];//随机字符串
            request.timeStamp= [[content objectForKey:@"timeStamp"] intValue];//时间戳
            request.sign = [content objectForKey:@"paySign"];//签名
            //            request.sign= @"18";//签名
            [WXApi sendReq:request];
            
        }
        
    } failure:nil];
}

#pragma mark --- 添加店铺券接口
- (void)addDianpuquan
{
    if (_isOnTradning) {
        NSLog(@"添加店铺券接口");
        
        NSString *url_post = [NSString stringWithFormat:@"http://%@addDianpuquan.action", kHead];
        
        NSDictionary *params = @{
                                 @"uid":[[self getLocalDic] objectForKey:@"uid"],
                                 @"ewm":[self creatQRStrWithQid:[[NSString alloc] init]],
                                 @"mid":_storeModel.mid,
                                 @"pid":_couponModel.pid,
                                 @"sid":_couponModel.sid,
                                 @"sname":_couponModel.title,
                                 @"mname":_storeModel.mname,
                                 @"price":_couponModel.charge,
                                 @"qid":@""
                                 };
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer = responseSerializer;
        [manager POST:url_post parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"添加店铺券：%@", content);
            
        } failure:nil];

    }
}

    //生成用户二维码需要传入的字符串
- (NSString *)creatQRStrWithQid:(NSString *)qid
{
    NSString *head = @"jnzddevqrcode-com.gcp0534://";
    
    NSString *uid = [[self getLocalDic] objectForKey:@"uid"];
    
    NSString *superID = _couponModel.sid;
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    
    NSString *qrStr = [NSString stringWithFormat:@"%@%@,%@,%@,%@", head, uid, superID, dateString, qid];
    NSLog(@"%@", qrStr);
    
    return qrStr;
}

#pragma mark
- (void)layoutSubviews
{
//    _titleLB.text = @"普通洗车-5座轿车";
    _titleLB.text = _couponModel.title;
//    _chargeLB.text = @"66元";
    _chargeLB.text = [NSString stringWithFormat:@"%@元", _couponModel.charge];
    _subTitleLB.text = @"整车泡沫清洗， 轮胎轮毂冲洗，车内吸尘，内饰简单清洗";
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 10*kRate;
    [super setFrame:frame];
}

#pragma mark
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
