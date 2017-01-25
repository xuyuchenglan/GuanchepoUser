//
//  PayForOpeningCard.m
//  管车婆
//
//  Created by 李伟 on 16/11/8.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "PayForOpeningCard.h"
#import "Way4PaymentOfOpencardView.h"
#import "ServiceItemsView.h"
#import "MembershipServicesModel.h"
#import "WXApi.h"

#define kThirdHeight 50*kRate
#define kMembershipWidth (kScreenWidth-40*kRate*2)

@interface PayForOpeningCard ()<UITextFieldDelegate>
{
    UIImageView           *_firstImgView;
    ServiceItemsView      *_secondView;
    UIView                *_thirdView;
    UIView                *_forthView;
    UIButton              *_openCardBtn;
    UITextField           *_valueTF_recommandCode;
}
@property (nonatomic, strong)UIScrollView   *scrollView;
@property (nonatomic, strong)NSMutableArray *membershipServiceModels;
@property (nonatomic, strong)NSString       *payWay;
@end

@implementation PayForOpeningCard

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //添加通知中心监听，当键盘弹出或者消失时收到消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    
    
    _membershipServiceModels = [NSMutableArray array];
    _payWay = [[NSString alloc] init];
    
    //监测Way4PaymentOfOpencardView中发送过来的通知，以实时改变支付方式payWay
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changePayWay:) name:@"changePayWay" object:nil];
    //监听 AppDelegate.m 在验证后台支付成功后发送过来的通知，以添加会员卡
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addCard) name:@"addCard.action" object:nil];
    
    //设置导航栏
    [self addNavBar];
    
    //设置下面的内容视图
    [self addContentView];
    
    //网络请求卡片详情数据
    [self getCardInfo];
}
#pragma mark
#pragma mark ****** 设置导航栏 ******
- (void)addNavBar
{
    [self setNavigationItemTitle:@"办卡支付"];
    [self setBackButtonWithImageName:@"back"];
}

#pragma mark ****** 设置下面的内容视图 ******
- (void)addContentView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight)];
    _scrollView.backgroundColor = kRGBColor(233, 239, 239);
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight+30*kRate*_membershipServiceModels.count);
    [self.view addSubview:_scrollView];
    
    //第一部分：卡片名称、金额
    [self addFirst];
    
    //第二部分：服务项目、详细
    [self addSecond];
    
    //第三部分：推荐人推荐码
    [self addThird];
    
    //第四部分：支付方式
    [self addForth];
    
    //第五部分：立即开卡
    [self addFifth];
    
}

//第一部分：卡片名称、金额
- (void)addFirst
{
    _firstImgView = [[UIImageView alloc] init];
    _firstImgView.image = [UIImage imageNamed:@"home_third_membership_pay_bg"];
    [_scrollView addSubview:_firstImgView];
    [_firstImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 250*kRate));
        make.top.equalTo(_scrollView).with.offset(8*kRate);
        make.left.equalTo(_scrollView).with.offset(0);
    }];
    
    UIImageView *membershipImgView = [[UIImageView alloc] init];
    membershipImgView.layer.cornerRadius = 6.0*kRate;
    membershipImgView.layer.masksToBounds = YES;
    [membershipImgView sd_setImageWithURL:_openCardModel.picUrl placeholderImage:[UIImage imageNamed:@"home_third_membership_card"] options:SDWebImageRefreshCached];
    [_firstImgView addSubview:membershipImgView];
    [membershipImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kMembershipWidth, kMembershipWidth*0.58));
        make.left.equalTo(_firstImgView).with.offset(40*kRate);
        make.top.equalTo(_firstImgView).with.offset(10*kRate);
    }];
    
    UIImageView *cardImgView = [[UIImageView alloc] init];
    cardImgView.image = [UIImage imageNamed:@"home_third_membership_pay_head"];
    [_firstImgView addSubview:cardImgView];
    [cardImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20*kRate, 20*kRate*0.71));
        make.left.equalTo(_firstImgView).with.offset(50*kRate);
        make.top.equalTo(membershipImgView.mas_bottom).with.offset(15*kRate);
    }];
    
    UILabel *cardNameLB = [[UILabel alloc] init];
    cardNameLB.text = _openCardModel.name;
    cardNameLB.font = [UIFont systemFontOfSize:15*kRate];
    [_firstImgView addSubview:cardNameLB];
    [cardNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*kRate, 20*kRate));
        make.left.equalTo(cardImgView.mas_right).with.offset(5*kRate);
        make.centerY.equalTo(cardImgView.mas_centerY).with.offset(0);
    }];
    
    UILabel *moneyLB = [[UILabel alloc] init];
    moneyLB.text = [NSString stringWithFormat:@"%@ 元", _openCardModel.price];
    moneyLB.textAlignment = NSTextAlignmentRight;
    moneyLB.font = [UIFont systemFontOfSize:13.0*kRate];
    moneyLB.textColor = [UIColor redColor];
    [_firstImgView addSubview:moneyLB];
    [moneyLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*kRate, 20*kRate));
        make.right.equalTo(_firstImgView).with.offset(-50*kRate);
        make.centerY.equalTo(cardImgView.mas_centerY).with.offset(0);
    }];
}

//第二部分：服务项目、详细
- (void)addSecond
{
    _secondView = [[ServiceItemsView alloc] init];
    _secondView.membershipServiceModels = _membershipServiceModels;
    _secondView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_secondView];
    [_secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, (40+10+30*_membershipServiceModels.count)*kRate));
        make.top.equalTo(_firstImgView.mas_bottom).with.offset(8*kRate);
        make.left.equalTo(_scrollView).with.offset(0);
    }];
}

//第三部分：推荐人推荐码
- (void)addThird
{
    _thirdView = [[UIView alloc] init];
    _thirdView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_thirdView];
    [_thirdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, kThirdHeight));
        make.top.equalTo(_secondView.mas_bottom).with.offset(8*kRate);
        make.left.equalTo(_scrollView).with.offset(0);
    }];
    
    UILabel *titleLB = [[UILabel alloc] init];
    titleLB.text = @"推荐人推荐码";
    titleLB.textColor = kRGBColor(22, 129, 251);
    titleLB.font = [UIFont systemFontOfSize:13.5*kRate];
    [_thirdView addSubview:titleLB];
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*kRate, kThirdHeight));
        make.left.equalTo(_thirdView).with.offset(30*kRate);
        make.top.equalTo(_thirdView).with.offset(0);
    }];
    
    _valueTF_recommandCode = [[UITextField alloc] init];
    _valueTF_recommandCode.delegate = self;
    _valueTF_recommandCode.borderStyle = UITextBorderStyleNone;
    _valueTF_recommandCode.returnKeyType = UIReturnKeyDone;
    _valueTF_recommandCode.font = [UIFont systemFontOfSize:13.5*kRate];
    _valueTF_recommandCode.adjustsFontSizeToFitWidth = YES;
    _valueTF_recommandCode.placeholder = @"可选";
    _valueTF_recommandCode.keyboardType = UIKeyboardTypeNumberPad;
    [_thirdView addSubview:_valueTF_recommandCode];
    [_valueTF_recommandCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150*kRate, kThirdHeight));
        make.left.equalTo(titleLB.mas_right).with.offset(10*kRate);
        make.top.equalTo(_thirdView).with.offset(0);
    }];

}

//第四部分：支付方式
- (void)addForth
{
    _forthView = [[UIView alloc] init];
    _forthView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_forthView];
    [_forthView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 120*kRate));
        make.top.equalTo(_thirdView.mas_bottom).with.offset(8*kRate);
        make.left.equalTo(_scrollView).with.offset(0);
    }];
    
    /*** 分割线 ***/
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    [_forthView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 1*kRate));
        make.top.equalTo(_forthView).with.offset(40*kRate);
        make.left.equalTo(_forthView).with.offset(0);
    }];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    [_forthView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 1*kRate));
        make.top.equalTo(_forthView).with.offset(80*kRate);
        make.left.equalTo(_forthView).with.offset(0);
    }];
    /*** 分割线 ***/
    
    //支付方式
    UILabel *titleLB = [[UILabel alloc] init];
    titleLB.text = @"支付方式";
    titleLB.font = [UIFont systemFontOfSize:15.5*kRate weight:0.11];
    [_forthView addSubview:titleLB];
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*kRate, 20*kRate));
        make.left.equalTo(_forthView).with.offset(30*kRate);
        make.top.equalTo(_forthView).with.offset(10*kRate);
    }];
    
    //微信支付
    Way4PaymentOfOpencardView *wechatView = [[Way4PaymentOfOpencardView alloc] init];
    wechatView.type = @"wechat";
    [_forthView addSubview:wechatView];
    [wechatView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 39*kRate));
        make.left.equalTo(_forthView).with.offset(0);
        make.top.equalTo(line1.mas_bottom).with.offset(0);
    }];
    
    //支付宝支付
    Way4PaymentOfOpencardView *alipayView = [[Way4PaymentOfOpencardView alloc] init];
    alipayView.type = @"alipay";
    [_forthView addSubview:alipayView];
    [alipayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 39*kRate));
        make.left.equalTo(_forthView).with.offset(0);
        make.top.equalTo(line2.mas_bottom).with.offset(0);
    }];
}

//第五部分：立即开卡
- (void)addFifth
{
    _openCardBtn = [[UIButton alloc] init];
    [_openCardBtn addTarget:self action:@selector(openCardBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_openCardBtn setTitle:@"立 即 开 卡" forState:UIControlStateNormal];
    [_openCardBtn setBackgroundColor:kRGBColor(22, 129, 251)];
    _openCardBtn.titleLabel.font = [UIFont systemFontOfSize:20.0*kRate];
    _openCardBtn.layer.cornerRadius = 5.0*kRate;
    [_scrollView addSubview:_openCardBtn];
    [_openCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-60*kRate, 50*kRate));
        make.left.equalTo(_scrollView).with.offset(30*kRate);
        make.top.equalTo(_forthView.mas_bottom).with.offset(12*kRate);
    }];
}

- (void)openCardBtnAction
{
    NSLog(@"立即开卡");
    [self.view endEditing:YES];
    
    if (_payWay.length > 0) {
        
        //付款
        [self getInfoThatCallWXPay];
        
    } else {
        
        [self showAlertViewWithTitle:@"提示" WithMessage:@"请选择支付方式"];
        
    }
}

#pragma mark
#pragma mark 弹出键盘时视图上移,键盘收起时视图恢复
//键盘显示
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSLog(@"键盘显示");
    
    //1，取得键盘最后的frame
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat height = keyboardFrame.size.height;
    //2，计算控制器的View需要移动的距离
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationBeginsFromCurrentState:YES];
    ///移动（带有动画）
    CGRect frame = self.view.frame;
    frame.origin.y = -height ;
    self.view.frame = frame;
    [UIView commitAnimations];
    
    
}


//键盘隐藏
- (void)keyboardWillHide:(NSNotification *)notification
{
    NSLog(@"键盘隐藏");
    
    //键盘消失时，试图恢复原样
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationBeginsFromCurrentState:YES];
    ///移动（带有动画）
    CGRect frame = self.view.frame;
    frame.origin.y = 0;
    self.view.frame = frame;
    [UIView commitAnimations];
    
}



#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}


#pragma mark 
#pragma mark 网络请求卡片详情数据
- (void)getCardInfo
{
    NSString *url_post = [NSString stringWithFormat:@"http://%@getCardTypeDetails.action", kHead];
    
    NSDictionary *params = @{
                             @"cid":_openCardModel.cid
                             };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = responseSerializer;
    [manager POST:url_post parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *jsondataArr = [content objectForKey:@"jsondata"];
        for (NSDictionary *dic in jsondataArr) {
            MembershipServicesModel *model = [[MembershipServicesModel alloc] initWithDic:dic];
            [_membershipServiceModels addObject:model];
        }
        
        //刷新视图
        [_scrollView removeFromSuperview];
        [self addContentView];
        
    } failure:nil];

}

#pragma mark --- 获取调起微信支付所需的参数
- (void)getInfoThatCallWXPay
{
    NSString *url_post = [NSString stringWithFormat:@"http://%@/zcar/wxCtl/unifiedorder.action", kIP];

    NSDictionary *params = @{
                             @"openid":[[self getLocalDic] objectForKey:@"phone"],//传入电话号码或微信openid   (APP支付填入phone)
                             @"price":@"0.01",//金额 单位元
                             @"pName":_openCardModel.name,//产品名称
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

#pragma mark 添加会员卡接口
- (void)addCard
{
    NSLog(@"添加店铺券接口");
    
    NSString *url_post = [NSString stringWithFormat:@"http://%@addCard.action", kHead];
    
    NSDictionary *params = @{
                             @"prefixNo":_openCardModel.prefixNo,
                             @"openid":[[self getLocalDic] objectForKey:@"phone"],
                             @"cardTypeId":_openCardModel.cid,
                             @"recommendCode":_valueTF_recommandCode.text
                             };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = responseSerializer;
    [manager POST:url_post parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"添加会员卡：%@", content);
        
        
        
        
    } failure:nil];
    
}


#pragma mark
#pragma mark 通知相关
//接收到通知后的操作，修改payWay的值
- (void)changePayWay:(NSNotification *)notification
{
    NSDictionary *dic = notification.userInfo;
    
    _payWay = [dic objectForKey:@"payWay"];
    
}

//移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
