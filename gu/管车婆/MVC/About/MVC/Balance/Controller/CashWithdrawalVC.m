//
//  CashWithdrawalVC.m
//  管车婆
//
//  Created by 李伟 on 16/11/11.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "CashWithdrawalVC.h"

@interface CashWithdrawalVC ()<UITextFieldDelegate>
{
    UILabel *_maxCashWithdrawalLB;
    UIView  *_alipayView;
    UIView  *_dateView;
}
@end

@implementation CashWithdrawalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kRGBColor(233, 239, 239);
    
    //设置导航栏
    [self addNavBar];
    
    //设置下面的视图
    [self addContentView];
    
}

# pragma mark ****** 设置导航栏 ******
- (void)addNavBar
{
    [self setNavigationItemTitle:@"余额提现"];
    [self setBackButtonWithImageName:@"back"];
}

# pragma mark ****** 设置下面的视图 ******
- (void)addContentView
{
    //最大提现金额
    _maxCashWithdrawalLB = [[UILabel alloc] init];
    _maxCashWithdrawalLB.text = @"最大提现金额：250元";
    _maxCashWithdrawalLB.font = [UIFont systemFontOfSize:15.0*kRate];
    [self.view addSubview:_maxCashWithdrawalLB];
    [_maxCashWithdrawalLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200*kRate, 20*kRate));
        make.top.equalTo(self.view).with.offset(64+15*kRate);
        make.left.equalTo(self.view).with.offset(30*kRate);
    }];
    
    //提现金额、支付宝账号、支付名
    [self addAlipayView];
    
    //提现日期
    [self addDateView];
    
    //确认提现按钮
    UIButton *submitBtn = [[UIButton alloc] init];
    [submitBtn setBackgroundColor:kRGBColor(22, 129, 251)];
    submitBtn.layer.cornerRadius = 5.0*kRate;
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:20.0*kRate weight:0];
    [submitBtn setTitle:@"确认提现" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-20*kRate*2, 50*kRate));
        make.left.equalTo(self.view).with.offset(20*kRate);
        make.top.equalTo(_dateView.mas_bottom).with.offset(30*kRate);
    }];
    
    //温馨提示
    UILabel *warmTipsLB = [[UILabel alloc] init];
    warmTipsLB.numberOfLines = 0;
    [self.view addSubview:warmTipsLB];
    warmTipsLB.attributedText = [self getAttributedStringWithTitleOne:@"温馨提示：" Desc1:@"1.提款免手续费，每天最多可申请2次提现，提现只能提款到支付宝，暂不支持银行卡、微信提现；" Desc2:@"2.一般提现申请时间为每天9：00-18：00，当日18：00前提现当天处理，18：00后提现次日处理；" Desc3:@"3.提现到账时间为3-5个工作日。"];
    [warmTipsLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-60*kRate, 120*kRate));
        make.left.equalTo(self.view).with.offset(30*kRate);
        make.top.equalTo(submitBtn.mas_bottom).with.offset(20*kRate);
    }];
    
}

   //提现金额、支付宝账号、支付名
- (void)addAlipayView
{
    _alipayView = [[UIView alloc] init];
    _alipayView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_alipayView];
    [_alipayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 150*kRate));
        make.left.equalTo(self.view).with.offset(0);
        make.top.equalTo(_maxCashWithdrawalLB.mas_bottom).with.offset(15*kRate);
    }];
    
    /***********   分割线   ****************/
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 50*kRate, kScreenWidth, 1*kRate)];
    lineView1.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [_alipayView addSubview:lineView1];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 100*kRate, kScreenWidth, 1*kRate)];
    lineView2.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [_alipayView addSubview:lineView2];
    /***********   分割线   ****************/
    
    //提现金额
    UILabel *licensePlateLabel = [[UILabel alloc] initWithFrame:CGRectMake(30*kRate, 0, 80*kRate, 50*kRate)];
    licensePlateLabel.text = @"提现金额";
    licensePlateLabel.font = [UIFont systemFontOfSize:15.0*kRate];
    [_alipayView addSubview:licensePlateLabel];
    
    
    
    //支付宝账号
    UILabel *alipayAccountLB = [[UILabel alloc] initWithFrame:CGRectMake(30*kRate, 50*kRate, 80*kRate, 50*kRate)];
    alipayAccountLB.text = @"支付宝账号";
    alipayAccountLB.font = [UIFont systemFontOfSize:15.0*kRate];
    [_alipayView addSubview:alipayAccountLB];
    
    UITextField *alipayAccountTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(alipayAccountLB.frame)+30*kRate, 60*kRate, 180*kRate, 40*kRate)];
    alipayAccountTF.delegate = self;
    [alipayAccountTF setBorderStyle:UITextBorderStyleNone];
    alipayAccountTF.returnKeyType = UIReturnKeyDone;
    alipayAccountTF.clearButtonMode = UITextFieldViewModeAlways;
    alipayAccountTF.adjustsFontSizeToFitWidth = YES;
    
    NSMutableAttributedString *attrs = [[NSMutableAttributedString alloc] initWithString:@"请准确输入您的支付宝账号"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSForegroundColorAttributeName] = [UIColor colorWithWhite:0.6 alpha:1];//placeHolder的文字颜色
    dic[NSFontAttributeName] = [UIFont systemFontOfSize:14*kRate];//文字大小
    [attrs setAttributes:dic range:NSMakeRange(0, attrs.length)];//range标识从第几个字符开始，长度是多少
    alipayAccountTF.attributedPlaceholder = attrs;
    
    [_alipayView addSubview:alipayAccountTF];
    
    
    //支付名
    UILabel *nameLB = [[UILabel alloc] initWithFrame:CGRectMake(30*kRate, 100*kRate, 80*kRate, 50*kRate)];
    nameLB.text = @"支付名";
    nameLB.font = [UIFont systemFontOfSize:15.0*kRate];
    [_alipayView addSubview:nameLB];
    
    UITextField *nameTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nameLB.frame)+30*kRate, 110*kRate, 180*kRate, 40*kRate)];
    nameTF.delegate = self;
    [nameTF setBorderStyle:UITextBorderStyleNone];
    nameTF.returnKeyType = UIReturnKeyDone;
    nameTF.clearButtonMode = UITextFieldViewModeAlways;
    nameTF.adjustsFontSizeToFitWidth = YES;
    
    NSMutableAttributedString *attrs1 = [[NSMutableAttributedString alloc] initWithString:@"请准确输入您的支付名"];
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    dic1[NSForegroundColorAttributeName] = [UIColor colorWithWhite:0.6 alpha:1];//placeHolder的文字颜色
    dic1[NSFontAttributeName] = [UIFont systemFontOfSize:14*kRate];//文字大小
    [attrs1 setAttributes:dic1 range:NSMakeRange(0, attrs1.length)];//range标识从第几个字符开始，长度是多少
    nameTF.attributedPlaceholder = attrs1;
    
    [_alipayView addSubview:nameTF];
}

   //提现日期
- (void)addDateView
{
    _dateView = [[UIView alloc] init];
    _dateView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_dateView];
    [_dateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 50*kRate));
        make.left.equalTo(self.view).with.offset(0);
        make.top.equalTo(_alipayView.mas_bottom).with.offset(10*kRate);
    }];
    
    UILabel *titleLB = [[UILabel alloc] init];
    titleLB.text = @"提现日期";
    titleLB.font = [UIFont systemFontOfSize:15.0*kRate];
    [_dateView addSubview:titleLB];
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*kRate, 50*kRate));
        make.left.equalTo(_dateView).with.offset(30*kRate);
        make.top.equalTo(_dateView).with.offset(0);
    }];
    
    UILabel *valueLB = [[UILabel alloc] init];
    valueLB.text = @"2016-08-31";
    valueLB.textAlignment = NSTextAlignmentRight;
    valueLB.font = [UIFont systemFontOfSize:15.0*kRate];
    [_dateView addSubview:valueLB];
    [valueLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*kRate, 50*kRate));
        make.right.equalTo(_dateView).with.offset(-30*kRate);
        make.top.equalTo(_dateView).with.offset(0);
    }];
}

-(NSMutableAttributedString *)getAttributedStringWithTitleOne:(NSString *)title Desc1:(NSString *)desc1 Desc2:(NSString *)desc2 Desc3:(NSString *)desc3
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5.0*kRate];//调整行间距
    
    NSMutableAttributedString *mutaTitle = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",title] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13*kRate],NSForegroundColorAttributeName:[UIColor blackColor],NSParagraphStyleAttributeName:paragraphStyle}];
    
    NSMutableAttributedString *mutaDesc1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",desc1] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13*kRate],NSForegroundColorAttributeName:[UIColor colorWithWhite:0.4 alpha:1],NSParagraphStyleAttributeName:paragraphStyle}];
    
    NSMutableAttributedString *mutaDesc2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",desc2] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13*kRate],NSForegroundColorAttributeName:[UIColor colorWithWhite:0.4 alpha:1],NSParagraphStyleAttributeName:paragraphStyle}];
    
    NSMutableAttributedString *mutaDesc3 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",desc3] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13*kRate],NSForegroundColorAttributeName:[UIColor colorWithWhite:0.4 alpha:1],NSParagraphStyleAttributeName:paragraphStyle}];
    
    [mutaTitle appendAttributedString:mutaDesc1];
    [mutaTitle appendAttributedString:mutaDesc2];
    [mutaTitle appendAttributedString:mutaDesc3];
    
    return mutaTitle;
    
}


#pragma mark --- UIButtonAction
- (void)submitBtnAction
{
    NSLog(@"确认提现");

}



@end
