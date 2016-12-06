//
//  VerificationCodeLoginVC.m
//  管车婆
//
//  Created by 李伟 on 16/9/29.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "VerificationCodeLoginVC.h"
#import "RegisterViewController.h"
#import "ForgotPasswordVC.h"

@interface VerificationCodeLoginVC ()<UITextFieldDelegate>
{
    UIButton    *accountPWBtn;
    UIImageView *logoImgView;
    UITextField *numberTF;
    UITextField *verificationCodeTF;
    UIButton    *loginBtn;//登录按钮
    UIButton    *retrievePasswordBtn;//找回密码按钮
    UIButton    *registerAccountBtn;//注册账号按钮
    
    UIButton    *getVerCodeBtn;//获取验证码按钮
    NSInteger   _count;//记录获取验证码之后，到下一次点击还需要的时间

}
@property (nonatomic, strong)NSString *numberStr;//记录输入框中输入的手机号
@property (nonatomic, strong)NSString *verificationCodeStr;//记录验证码输入框中输入的验证码
@end

@implementation VerificationCodeLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self addNavigationBar];
    
    //下面的内容
    [self addContentView];
    
}

#pragma mark ****************  设置导航栏  ******************
- (void)addNavigationBar
{
    [self setNavigationItemTitle:@"登录"];
    
    [self setBackButtonWithIsText:NO withIsExit:NO WithText:nil WithImageName:@"back_blue"];
}


#pragma mark ****************  设置下面的内容  ******************
- (void)addContentView
{
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 65, kScreenWidth, kScreenHeight - 65)];
    contentView.backgroundColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1];
    [self.view addSubview:contentView];
    
    //账号密码登录
    accountPWBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 130*kRate, 10*kRate, 100*kRate, 25*kRate)];
    [accountPWBtn setTitle:@"账号密码登录>" forState:UIControlStateNormal];
    [accountPWBtn setTitleColor:[UIColor colorWithRed:0 green:126/255.0 blue:1 alpha:1] forState:UIControlStateNormal];
    accountPWBtn.titleLabel.font = [UIFont systemFontOfSize:14.0*kRate];
    [accountPWBtn addTarget:self action:@selector(accountPSBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:accountPWBtn];
    
    //logo图标
    logoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 80*kRate, 50*kRate, 160*kRate, 50*kRate)];
    logoImgView.image = [UIImage imageNamed:@"login_logo"];
    [contentView addSubview:logoImgView];
    
    //手机号输入框
    numberTF = [[UITextField alloc] initWithFrame:CGRectMake(40*kRate, CGRectGetMaxY(logoImgView.frame) + 30*kRate, kScreenWidth - 160*kRate, 40*kRate)];
    numberTF.delegate = self;
    numberTF.keyboardType = UIKeyboardTypeNumberPad;//键盘类型（数字）
    [numberTF setBorderStyle:UITextBorderStyleRoundedRect];//边框
    numberTF.secureTextEntry = NO;//密码状态
    numberTF.autocorrectionType = UITextAutocorrectionTypeNo;//不自动纠错
    numberTF.returnKeyType = UIReturnKeyDone;//“return”键的类型
    numberTF.clearButtonMode = UITextFieldViewModeWhileEditing;//清除按钮何时出现
    numberTF.adjustsFontSizeToFitWidth = YES;//字体大小自适应输入框宽度
    numberTF.tag = 923;
    [contentView addSubview:numberTF];
    ///placeHolder
    NSMutableAttributedString *attrs = [[NSMutableAttributedString alloc] initWithString:@"请输入您的手机号"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSForegroundColorAttributeName] = [UIColor colorWithWhite:0.8 alpha:1];
    dic[NSFontAttributeName] = [UIFont systemFontOfSize:18*kRate];//文字大小
    dic[NSBaselineOffsetAttributeName] = @(-18*(1-kRate)/2);
    [attrs setAttributes:dic range:NSMakeRange(0, attrs.length)];
    numberTF.attributedPlaceholder = attrs;
    
    //发送验证码按钮
    getVerCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(numberTF.frame) + 10*kRate, CGRectGetMinY(numberTF.frame), 70*kRate, 40*kRate)];
    getVerCodeBtn.backgroundColor = [UIColor colorWithRed:64/255.0 green:129/255.0 blue:251/255.0 alpha:1];
    getVerCodeBtn.layer.cornerRadius = 6.0*kRate;
    [getVerCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    getVerCodeBtn.titleLabel.font = [UIFont systemFontOfSize:13.0*kRate];
    [getVerCodeBtn addTarget:self action:@selector(getVerificationCode) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:getVerCodeBtn];
    
    //验证码输入框
    verificationCodeTF = [[UITextField alloc] initWithFrame:CGRectMake(40*kRate, CGRectGetMaxY(numberTF.frame) + 20*kRate, kScreenWidth - 80*kRate, 40*kRate)];
    verificationCodeTF.delegate = self;
    [verificationCodeTF setBorderStyle:UITextBorderStyleRoundedRect];//边框
    verificationCodeTF.secureTextEntry = YES;//密码状态
    verificationCodeTF.autocorrectionType = UITextAutocorrectionTypeNo;//不自动纠错
    verificationCodeTF.returnKeyType = UIReturnKeyDone;//“return”键的类型
    verificationCodeTF.clearButtonMode = UITextFieldViewModeWhileEditing;//清除按钮何时出现
    verificationCodeTF.adjustsFontSizeToFitWidth = YES;//字体大小自适应输入框宽度
    verificationCodeTF.tag = 803;
    [contentView addSubview:verificationCodeTF];
    ///placeHolder
    NSMutableAttributedString *attrs1 = [[NSMutableAttributedString alloc] initWithString:@"请输入您的验证码"];
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    dic1[NSForegroundColorAttributeName] = [UIColor colorWithWhite:0.8 alpha:1];
    dic1[NSFontAttributeName] = [UIFont systemFontOfSize:18*kRate];//文字大小
    dic1[NSBaselineOffsetAttributeName] = @(-18*(1-kRate)/2);
    [attrs1 setAttributes:dic1 range:NSMakeRange(0, attrs1.length)];
    verificationCodeTF.attributedPlaceholder = attrs1;
    
    
    //登录按钮
    loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(40*kRate, CGRectGetMaxY(verificationCodeTF.frame) + 30*kRate, kScreenWidth - 80*kRate, 40*kRate)];
    [loginBtn setBackgroundColor:[UIColor colorWithRed:64/255.0 green:129/255.0 blue:251/255.0 alpha:1]];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:18.0*kRate];
    loginBtn.layer.cornerRadius = 6.0*kRate;
    [loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor colorWithWhite:0.5 alpha:1] forState:UIControlStateHighlighted];
    [loginBtn addTarget:self action:@selector(loginBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:loginBtn];
    
    
    //注册账号按钮
    registerAccountBtn = [[UIButton alloc] initWithFrame:CGRectMake(40*kRate, CGRectGetMaxY(loginBtn.frame) + 10*kRate, kScreenWidth/2 - 40*kRate, 20*kRate)];
    [registerAccountBtn setTitle:@"注册账号" forState:UIControlStateNormal];
    registerAccountBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;//按钮的titleLabel设置为左对齐
    registerAccountBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10*kRate);//按钮的titleLabel距离右边10个像素
    registerAccountBtn.titleLabel.font = [UIFont systemFontOfSize:14.0*kRate];
    [registerAccountBtn setTitleColor:[UIColor colorWithWhite:0 alpha:1] forState:UIControlStateNormal];
    [registerAccountBtn setTitleColor:[UIColor colorWithWhite:0.5 alpha:1] forState:UIControlStateHighlighted];
    [registerAccountBtn addTarget:self action:@selector(registerAccountBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:registerAccountBtn];
    
    //找回密码按钮
    retrievePasswordBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2, CGRectGetMaxY(loginBtn.frame) + 10*kRate, kScreenWidth/2 - 40*kRate, 20*kRate)];
    [retrievePasswordBtn setTitle:@"找回密码" forState:UIControlStateNormal];
    retrievePasswordBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;//按钮的titleLabel设置为右对齐
    retrievePasswordBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10*kRate, 0, 0);//按钮的titleLabel距离左边10个像素
    retrievePasswordBtn.titleLabel.font = [UIFont systemFontOfSize:14.0*kRate];
    [retrievePasswordBtn setTitleColor:[UIColor colorWithWhite:0 alpha:1] forState:UIControlStateNormal];
    [retrievePasswordBtn setTitleColor:[UIColor colorWithWhite:0.5 alpha:1] forState:UIControlStateHighlighted];
    [retrievePasswordBtn addTarget:self action:@selector(retrievePasswordBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:retrievePasswordBtn];
    
    
}

#pragma mark ButtonAction
- (void)accountPSBtnAction
{
    NSLog(@"账号密码登录");
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)getVerificationCode
{
    NSLog(@"获取手机验证码");
    
    [numberTF resignFirstResponder];//收起键盘
    
    if (_numberStr.length == 11) {
        
        //获取手机验证码
        [self getVerificationCodePostWithNumber:_numberStr];
        
        //当点击“获取验证码”按钮后，按钮进行倒计时
        getVerCodeBtn.enabled = NO;
        _count = 60;
        [getVerCodeBtn setTitle:@"60秒" forState:UIControlStateDisabled];
        getVerCodeBtn.backgroundColor = [UIColor grayColor];
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    
    } else {
        
        [self showAlertViewWithTitle:@"提示" WithMessage:@"您的手机号码输入有误，请重试！"];

    }
    
}

-(void)timerFired:(NSTimer *)timer
{
    if (_count !=1)
    {
        _count -=1;
        [getVerCodeBtn setTitle:[NSString stringWithFormat:@"%ld秒",_count] forState:UIControlStateDisabled];
    }
    else
    {
        [timer invalidate];
        getVerCodeBtn.enabled = YES;
        [getVerCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        getVerCodeBtn.backgroundColor = [UIColor colorWithRed:64/255.0 green:129/255.0 blue:251/255.0 alpha:1];
    }
}

- (void)loginBtnAction
{
    NSLog(@"手机验证码登录按钮");
    
    [numberTF resignFirstResponder];//收起键盘
    [verificationCodeTF resignFirstResponder];
    
    if (_numberStr.length!=0 && _verificationCodeStr.length!=0) {
        
        if ([self.verificationCodePostStr isEqualToString:_verificationCodeStr]) {
            
            //在这里进行手机验证码登录的网络请求
            [self loginByNumber:_numberStr];
            
        } else {
            
            [self showAlertViewWithTitle:@"提示" WithMessage:@"您的验证码输入有误，请重试！"];
            
        }
        
    } else {

        [self showAlertViewWithTitle:@"提示" WithMessage:@"您的手机号或验证码均不能为空，请重试！"];
    }
}

- (void)retrievePasswordBtnAction
{
    NSLog(@"找回密码");
    
    ForgotPasswordVC *findBackPwVC = [[ForgotPasswordVC alloc] init];
    [self presentViewController:findBackPwVC animated:NO completion:nil];
}

- (void)registerAccountBtnAction
{
    NSLog(@"注册账号");
    
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self presentViewController:registerVC animated:NO completion:nil];
}

#pragma mark UITextFieldDelegate
//点击“Return”键的时候调用的方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [numberTF resignFirstResponder];//收起键盘
    [verificationCodeTF resignFirstResponder];
    return YES;
}

//当开始点击textField的时候会调用的方法
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag == 923) {
        _numberStr = textField.text;
    } else if (textField.tag == 803) {
        _verificationCodeStr = textField.text;
    }
    NSLog(@"手机号是:%@,验证码是:%@", _numberStr, _verificationCodeStr);
}

//当textField编辑结束时会调用的方法
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 923) {
        _numberStr = textField.text;
    } else if (textField.tag == 803) {
        _verificationCodeStr = textField.text;
    }
    NSLog(@"手机号是:%@,验证码是:%@", _numberStr, _verificationCodeStr);
}

@end
