//
//  FillPhoneChargesVC.m
//  管车婆
//
//  Created by 李伟 on 16/10/8.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "FillPhoneChargesVC.h"
#import "PhoneChargesView.h"

#define kSecondViewWidth (kScreenWidth - 40*kRate)
#define kSecondViewHeight 180*kRate

@interface FillPhoneChargesVC ()<UITextFieldDelegate>
{
    UITextField *_numberTF;//手机号码输入框
    UIButton    *_changeNumberBtn;//更换手机号码按钮
    UIView      *_secondView;//承载各个充值面值的View
    UIButton    *_submitBtn;//确定充值按钮
}
@end

@implementation FillPhoneChargesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:233/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    
    //设置导航栏
    [self addNavBar];
    
    //设置下面的内容视图
    [self addContentView];
}

#pragma mark *************   设置导航栏   *********************
- (void)addNavBar
{
    [self setNavigationItemTitle:@"充话费"];
    
    [self setBackButtonWithImageName:@"back"];
}


#pragma mark *************   设置下面的内容视图   *********************
- (void)addContentView
{
    //第一块：手机号码输入框、更改手机号码按钮
    [self addFirstContent];
    
    //第二块：需要充值多少钱
    [self addSecondContent];
    
    //“确定充值”按钮
    [self addSubmitBtn];
}

//第一块：手机号码输入框、更改手机号码按钮
- (void)addFirstContent
{
    //手机号输入框
    _numberTF = [[UITextField alloc] initWithFrame:CGRectMake(20*kRate, 100*kRate, kScreenWidth - 120*kRate, 40*kRate)];
    _numberTF.delegate = self;
    [_numberTF setBorderStyle:UITextBorderStyleRoundedRect];//边框
    _numberTF.secureTextEntry = NO;//密码状态
    _numberTF.autocorrectionType = UITextAutocorrectionTypeNo;//不自动纠错
    _numberTF.returnKeyType = UIReturnKeyDone;//“return”键的类型
    _numberTF.clearButtonMode = UITextFieldViewModeWhileEditing;//清除按钮何时出现
    _numberTF.adjustsFontSizeToFitWidth = YES;//字体大小自适应输入框宽度
    [self.view addSubview:_numberTF];
    ///placeHolder
    NSMutableAttributedString *attrs = [[NSMutableAttributedString alloc] initWithString:@"请输入您的手机号"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSForegroundColorAttributeName] = [UIColor colorWithWhite:0.8 alpha:1];
    [attrs setAttributes:dic range:NSMakeRange(0, attrs.length)];
    _numberTF.attributedPlaceholder = attrs;
    
    //更换号码按钮
    _changeNumberBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_numberTF.frame) + 10*kRate, CGRectGetMinY(_numberTF.frame), 70*kRate, 40*kRate)];
    _changeNumberBtn.backgroundColor = [UIColor colorWithRed:64/255.0 green:129/255.0 blue:251/255.0 alpha:1];
    _changeNumberBtn.layer.cornerRadius = 8.0*kRate;
    [_changeNumberBtn setTitle:@"更换号码" forState:UIControlStateNormal];
    _changeNumberBtn.titleLabel.font = [UIFont systemFontOfSize:13.0*kRate];
    [_changeNumberBtn addTarget:self action:@selector(changePhoneNumber) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_changeNumberBtn];

}

//第二块：需要充值多少钱
- (void)addSecondContent
{
    _secondView = [[UIView alloc] initWithFrame:CGRectMake(20*kRate, CGRectGetMaxY(_numberTF.frame) + 20*kRate, kSecondViewWidth, kSecondViewHeight)];
    [self.view addSubview:_secondView];
    
    //20元
    PhoneChargesView *phoneChargeView20 = [[PhoneChargesView alloc] initWithFrame:CGRectMake(0, 0, (kSecondViewWidth-40*kRate)/3, kSecondViewHeight/2 - 20*kRate)];
    phoneChargeView20.originalPrice = @"20元";
    phoneChargeView20.discountedPrice = @"售价19.8元";
    [_secondView addSubview:phoneChargeView20];
    
    //30元
    PhoneChargesView *phoneChargeView30 = [[PhoneChargesView alloc] initWithFrame:CGRectMake((kSecondViewWidth-40*kRate)/3 + 20*kRate, 0, (kSecondViewWidth-40*kRate)/3, kSecondViewHeight/2 - 20)];
    phoneChargeView30.originalPrice = @"30元";
    phoneChargeView30.discountedPrice = @"售价29.8元";
    [_secondView addSubview:phoneChargeView30];

    //50元
    PhoneChargesView *phoneChargeView50 = [[PhoneChargesView alloc] initWithFrame:CGRectMake((kSecondViewWidth-40*kRate)/3 * 2 + 20*kRate * 2, 0, (kSecondViewWidth-40*kRate)/3, kSecondViewHeight/2 - 20*kRate)];
    phoneChargeView50.originalPrice = @"50元";
    phoneChargeView50.discountedPrice = @"售价49.8元";
    [_secondView addSubview:phoneChargeView50];

    //100元
    PhoneChargesView *phoneChargeView100 = [[PhoneChargesView alloc] initWithFrame:CGRectMake(0, kSecondViewHeight/2, (kSecondViewWidth-40*kRate)/3, kSecondViewHeight/2 - 20*kRate)];
    phoneChargeView100.originalPrice = @"100元";
    phoneChargeView100.discountedPrice = @"售价99.8元";
    [_secondView addSubview:phoneChargeView100];

    //200元
    PhoneChargesView *phoneChargeView200 = [[PhoneChargesView alloc] initWithFrame:CGRectMake((kSecondViewWidth-40*kRate)/3 + 20*kRate, kSecondViewHeight/2, (kSecondViewWidth-40*kRate)/3, kSecondViewHeight/2 - 20*kRate)];
    phoneChargeView200.originalPrice = @"200元";
    phoneChargeView200.discountedPrice = @"售价299.8元";
    [_secondView addSubview:phoneChargeView200];

    //500元
    PhoneChargesView *phoneChargeView500 = [[PhoneChargesView alloc] initWithFrame:CGRectMake((kSecondViewWidth-40*kRate)/3 * 2 + 20*kRate * 2, kSecondViewHeight/2, (kSecondViewWidth-40*kRate)/3, kSecondViewHeight/2 - 20*kRate)];
    phoneChargeView500.originalPrice = @"500元";
    phoneChargeView500.discountedPrice = @"售价499.8元";
    [_secondView addSubview:phoneChargeView500];

    
}

//“确定充值”按钮
- (void)addSubmitBtn
{
    _submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(20*kRate, CGRectGetMaxY(_secondView.frame) + 20*kRate, kScreenWidth - 40*kRate, 40*kRate)];
    _submitBtn.backgroundColor = [UIColor colorWithRed:64/255.0 green:129/255.0 blue:251/255.0 alpha:1];
    _submitBtn.layer.cornerRadius = 8.0*kRate;
    [_submitBtn setTitle:@"确定充值" forState:UIControlStateNormal];
    _submitBtn.titleLabel.font = [UIFont systemFontOfSize:14.0*kRate];
    [_submitBtn addTarget:self action:@selector(submitBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_submitBtn];
}



#pragma mark --- ButtonAction
- (void)changePhoneNumber
{
    NSLog(@"更换手机号码");
    
    
}

- (void)submitBtnAction
{
    NSLog(@"确 定 充 值");
}

#pragma mark --- UITextFieldDelegate
//点击“Return”键的时候调用的方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_numberTF resignFirstResponder];//收起键盘
    
    return YES;
}

@end
