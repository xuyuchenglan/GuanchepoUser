//
//  ForgotPasswordVC.m
//  管车婆
//
//  Created by 李伟 on 16/9/29.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "ForgotPasswordVC.h"
#import "MainViewController.h"
#import "ProtocolViewController.h"

@interface ForgotPasswordVC ()<UITextFieldDelegate>
{
    UITextField *numberTF;
    UITextField *verificationCodeTF;
    UITextField *passwordTF;
    UITextField *submitPwTF;
    UIButton    *protocolBtn;
    UIButton    *changePwdBtn;//修改密码按钮
    
    UIButton    *getVerCodeBtn;//获取验证码按钮
    NSInteger   _count;//记录获取验证码之后，到下一次点击还需要的时间
    
}
@property (nonatomic, strong)NSString *numberStr;//记录输入框中输入的账号
@property (nonatomic, strong)NSString *verificationCodeStr;//记录验证码输入框中输入的验证码
@property (nonatomic, strong)NSString *verificationCodePostStr;//记录网络获取到的验证码
@property (nonatomic, strong)NSString *passwordStr;//记录密码输入框中输入的密码
@property (nonatomic, strong)NSString *submitPwStr;//记录确认密码输入框中输入的密码

@end

@implementation ForgotPasswordVC

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
    [self setNavigationItemTitle:@"忘记密码"];
    
    [self setBackButtonWithIsText:NO withIsExit:NO WithText:nil WithImageName:@"back_blue"];
}

#pragma mark ****************  设置下面的内容  ******************
- (void)addContentView
{
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 65, kScreenWidth, kScreenHeight - 65)];
    contentView.backgroundColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1];
    [self.view addSubview:contentView];
    
    //手机号输入框
    numberTF = [[UITextField alloc] initWithFrame:CGRectMake(40*kRate, 30*kRate, kScreenWidth - 160*kRate, 40*kRate)];
    numberTF.delegate = self;
    numberTF.keyboardType = UIKeyboardTypeNumberPad;
    [numberTF setBorderStyle:UITextBorderStyleRoundedRect];//边框
    numberTF.secureTextEntry = NO;//密码状态
    numberTF.autocorrectionType = UITextAutocorrectionTypeNo;//不自动纠错
    numberTF.returnKeyType = UIReturnKeyDone;//“return”键的类型
    numberTF.clearButtonMode = UITextFieldViewModeWhileEditing;//清除按钮何时出现
    numberTF.adjustsFontSizeToFitWidth = YES;//字体大小自适应输入框宽度
    numberTF.tag = 123;
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
    verificationCodeTF.tag = 234;
    [contentView addSubview:verificationCodeTF];
    ///placeHolder
    NSMutableAttributedString *attrs1 = [[NSMutableAttributedString alloc] initWithString:@"请输入您的验证码"];
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    dic1[NSForegroundColorAttributeName] = [UIColor colorWithWhite:0.8 alpha:1];
    dic1[NSFontAttributeName] = [UIFont systemFontOfSize:18*kRate];//文字大小
    dic1[NSBaselineOffsetAttributeName] = @(-18*(1-kRate)/2);
    [attrs1 setAttributes:dic1 range:NSMakeRange(0, attrs1.length)];
    verificationCodeTF.attributedPlaceholder = attrs1;
    
    //密码输入框
    passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(40*kRate, CGRectGetMaxY(verificationCodeTF.frame) + 20*kRate, kScreenWidth - 80*kRate, 40*kRate)];
    passwordTF.delegate = self;
    [passwordTF setBorderStyle:UITextBorderStyleRoundedRect];//边框
    passwordTF.secureTextEntry = YES;//密码状态
    passwordTF.autocorrectionType = UITextAutocorrectionTypeNo;//不自动纠错
    passwordTF.returnKeyType = UIReturnKeyDone;//“return”键的类型
    passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;//清除按钮何时出现
    passwordTF.adjustsFontSizeToFitWidth = YES;//字体大小自适应输入框宽度
    passwordTF.tag = 345;
    [contentView addSubview:passwordTF];
    ///placeHolder
    NSMutableAttributedString *attrs2 = [[NSMutableAttributedString alloc] initWithString:@"请输入您的新密码"];
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    dic2[NSForegroundColorAttributeName] = [UIColor colorWithWhite:0.8 alpha:1];
    dic2[NSFontAttributeName] = [UIFont systemFontOfSize:18*kRate];//文字大小
    dic2[NSBaselineOffsetAttributeName] = @(-18*(1-kRate)/2);
    [attrs2 setAttributes:dic2 range:NSMakeRange(0, attrs2.length)];
    passwordTF.attributedPlaceholder = attrs2;
    
    //确认密码输入框
    submitPwTF = [[UITextField alloc] initWithFrame:CGRectMake(40*kRate, CGRectGetMaxY(passwordTF.frame) + 20*kRate, kScreenWidth - 80*kRate, 40*kRate)];
    submitPwTF.delegate = self;
    [submitPwTF setBorderStyle:UITextBorderStyleRoundedRect];//边框
    submitPwTF.secureTextEntry = YES;//密码状态
    submitPwTF.autocorrectionType = UITextAutocorrectionTypeNo;//不自动纠错
    submitPwTF.returnKeyType = UIReturnKeyDone;//“return”键的类型
    submitPwTF.clearButtonMode = UITextFieldViewModeWhileEditing;//清除按钮何时出现
    submitPwTF.adjustsFontSizeToFitWidth = YES;//字体大小自适应输入框宽度
    submitPwTF.tag = 456;
    [contentView addSubview:submitPwTF];
    ///placeHolder
    NSMutableAttributedString *attrs3 = [[NSMutableAttributedString alloc] initWithString:@"请再次输入您的新密码"];
    NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
    dic3[NSForegroundColorAttributeName] = [UIColor colorWithWhite:0.8 alpha:1];
    dic3[NSFontAttributeName] = [UIFont systemFontOfSize:18*kRate];//文字大小
    dic3[NSBaselineOffsetAttributeName] = @(-18*(1-kRate)/2);
    [attrs3 setAttributes:dic3 range:NSMakeRange(0, attrs3.length)];
    submitPwTF.attributedPlaceholder = attrs3;

    
    
    //服务协议
    UILabel *protocolLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 250*kRate, CGRectGetMaxY(submitPwTF.frame) + 10*kRate, 75*kRate, 20*kRate)];
    protocolLabel.text = @"注册代表同意";
    protocolLabel.font = [UIFont systemFontOfSize:12.0*kRate];
    [contentView addSubview:protocolLabel];
    
    protocolBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(protocolLabel.frame), CGRectGetMinY(protocolLabel.frame), 140*kRate, 20*kRate)];
    [protocolBtn setTitle:@"《管车婆用户服务协议》" forState:UIControlStateNormal];
    [protocolBtn setTitleColor:[UIColor colorWithRed:61/255.0 green:124/255.0 blue:1 alpha:1] forState:UIControlStateNormal];
    [protocolBtn setTitleColor:[UIColor colorWithWhite:0.5 alpha:1] forState:UIControlStateHighlighted];
    protocolBtn.titleLabel.font = [UIFont systemFontOfSize:12.0*kRate];
    [protocolBtn addTarget:self action:@selector(protocolBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:protocolBtn];
    
    
    
    //修改密码并登录按钮
    changePwdBtn = [[UIButton alloc] initWithFrame:CGRectMake(40*kRate, CGRectGetMaxY(protocolBtn.frame) + 30*kRate, kScreenWidth - 80*kRate, 40*kRate)];
    [changePwdBtn setBackgroundColor:[UIColor colorWithRed:64/255.0 green:129/255.0 blue:251/255.0 alpha:1]];
    changePwdBtn.layer.cornerRadius = 6.0*kRate;
    changePwdBtn.titleLabel.font = [UIFont systemFontOfSize:18.0*kRate];
    [changePwdBtn setTitle:@"修改并登录" forState:UIControlStateNormal];
    [changePwdBtn setTitleColor:[UIColor colorWithWhite:0.5 alpha:1] forState:UIControlStateHighlighted];
    [changePwdBtn addTarget:self action:@selector(changePwdBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:changePwdBtn];
    
    
}

#pragma mark ButtonAction

- (void)getVerificationCode
{
    NSLog(@"获取手机验证码");
    
    [numberTF resignFirstResponder];
    
    if (_numberStr.length == 11) {
        
        //获取手机验证码
        [self getVerificationCodePost];
        
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
    if (_count !=1) {
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

- (void)protocolBtnAction
{
    NSLog(@"管车婆用户服务协议");
    
    ProtocolViewController *protocolVC = [[ProtocolViewController alloc] init];
    [self presentViewController:protocolVC animated:NO completion:nil];
}

- (void)changePwdBtnAction
{
    NSLog(@"修改并登录");
    
    [numberTF resignFirstResponder];//收起键盘
    [verificationCodeTF resignFirstResponder];
    [passwordTF resignFirstResponder];
    [submitPwTF resignFirstResponder];
    
    if (_numberStr.length!=0 && _verificationCodeStr.length!=0 && _passwordStr.length!=0 && _submitPwStr!=0) {
        if ([_verificationCodePostStr isEqualToString:_verificationCodeStr]) {
            
            if ([_passwordStr isEqualToString:_submitPwStr]) {
                
                //在这里进行修改密码的网络请求
                [self changePwdPost];
                
            } else {
                
                [self showAlertViewWithTitle:@"提示" WithMessage:@"您的密码前后输入不一致，请重试！"];
                
            }
            
        } else {
            
            [self showAlertViewWithTitle:@"提示" WithMessage:@"您的验证码输入有误，请重试！"];
            
        }
        
    } else {
        
        [self showAlertViewWithTitle:@"提示" WithMessage:@"手机号/验证码/密码均不能为空，请重试！"];
    }
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
    if (textField.tag == 123) {
        _numberStr = textField.text;
    } else if (textField.tag == 234) {
        _verificationCodeStr = textField.text;
    } else if (textField.tag == 345) {
        _passwordStr = textField.text;
    }else if (textField.tag == 456) {
        _submitPwStr = textField.text;
    }
}

//当textField编辑结束时会调用的方法
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 123) {
        _numberStr = textField.text;
    } else if (textField.tag == 234) {
        _verificationCodeStr = textField.text;
    } else if (textField.tag == 345) {
        _passwordStr = textField.text;
    }else if (textField.tag == 456) {
        _submitPwStr = textField.text;
    }
}

#pragma mark
#pragma mark --- 网络请求
//获取手机验证码
- (void)getVerificationCodePost
{
    NSString *url_post = [NSString stringWithFormat:@"http://%@:8080/zcar/userapp/getSmsAlidayu.action", kIP];
    
    NSDictionary *params = @{
                             @"phone":_numberStr
                             };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = responseSerializer;
    
    [manager POST:url_post parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        _verificationCodePostStr = [NSString stringWithFormat:@"%@", [content objectForKey:@"sms_yzm"]];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败， 失败原因是：%@", error);
    }];
    
}

//修改密码
- (void)changePwdPost
{
    NSString *url_post = [NSString stringWithFormat:@"http://%@:8080/zcar/userapp/regOrRestPwd.action", kIP];
    
    NSDictionary *params = @{
                             @"phone":_numberStr,
                             @"pwd":_passwordStr
                             };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer = responseSerializer;
    
    [manager POST:url_post parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"手机验证码成功，请求下来的Json格式的数据是%@", content);
        
        NSString *resultStr = [content objectForKey:@"result"];
        
        if ([resultStr isEqualToString:@"success"]) {
            
            NSLog(@"登陆成功");
            
            //跳入到MainViewController
            [self presentViewController:[[MainViewController alloc] init] animated:NO completion:nil];
            
        } else {
            NSLog(@"登录失败");
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败， 失败原因是：%@", error);
    }];
}


@end
