//
//  RegisterViewController.m
//  管车婆
//
//  Created by 李伟 on 16/9/29.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "RegisterViewController.h"
#import "ProtocolViewController.h"

@interface RegisterViewController ()<UITextFieldDelegate>
{
    UITextField *numberTF;
    UITextField *verificationCodeTF;
    UITextField *passwordTF;
    UIButton    *protocolBtn;
    UIButton    *registerBtn;//注册并登录按钮
    
    UIButton    *getVerCodeBtn;//获取验证码按钮
    NSInteger   _count;//记录获取验证码之后，到下一次点击还需要的时间
    
}
@property (nonatomic, strong)NSString *numberStr;//记录输入框中输入的手机号
@property (nonatomic, strong)NSString *verificationCodeStr;//记录验证码输入框中输入的验证码
@property (nonatomic, strong)NSString *passwordStr;//记录密码输入框中输入的密码

@end

@implementation RegisterViewController

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
    [self setNavigationItemTitle:@"注册"];
    
    [self setBackButtonWithIsText:NO withIsExit:NO WithText:nil WithImageName:@"back_blue"];
}


#pragma mark ****************  设置下面的内容  ******************
- (void)addContentView
{
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 65, kScreenWidth, kScreenHeight - 65)];
    contentView.backgroundColor = kRGBColor(249, 249, 249);
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
    numberTF.tag = 521;
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
    getVerCodeBtn.backgroundColor = kRGBColor(64, 129, 251);
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
    verificationCodeTF.tag = 420;
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
    passwordTF.tag = 909;
    [contentView addSubview:passwordTF];
    ///placeHolder
    NSMutableAttributedString *attrs2 = [[NSMutableAttributedString alloc] initWithString:@"密码由6-20位数字、字母组成"];
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    dic2[NSForegroundColorAttributeName] = [UIColor colorWithWhite:0.8 alpha:1];
    dic2[NSFontAttributeName] = [UIFont systemFontOfSize:18*kRate];//文字大小
    dic2[NSBaselineOffsetAttributeName] = @(-18*(1-kRate)/2);
    [attrs2 setAttributes:dic2 range:NSMakeRange(0, attrs2.length)];
    passwordTF.attributedPlaceholder = attrs2;
    
    
    //服务协议
    UILabel *protocolLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 250*kRate, CGRectGetMaxY(passwordTF.frame) + 10*kRate, 75*kRate, 20*kRate)];
    protocolLabel.text = @"注册代表同意";
    protocolLabel.font = [UIFont systemFontOfSize:12.0*kRate];
    [contentView addSubview:protocolLabel];
    
    protocolBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(protocolLabel.frame), CGRectGetMinY(protocolLabel.frame), 140*kRate, 20*kRate)];
    [protocolBtn setTitle:@"《管车婆用户服务协议》" forState:UIControlStateNormal];
    [protocolBtn setTitleColor:kRGBColor(61, 124, 255) forState:UIControlStateNormal];
    [protocolBtn setTitleColor:[UIColor colorWithWhite:0.5 alpha:1] forState:UIControlStateHighlighted];
    protocolBtn.titleLabel.font = [UIFont systemFontOfSize:12.0*kRate];
    [protocolBtn addTarget:self action:@selector(protocolBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:protocolBtn];
    
    
    
    //注册并登录按钮
    registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(40*kRate, CGRectGetMaxY(protocolBtn.frame) + 30*kRate, kScreenWidth - 80*kRate, 40*kRate)];
    [registerBtn setBackgroundColor:kRGBColor(64, 129, 251)];
    [registerBtn setTitle:@"注册并登录" forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:18.0*kRate];
    [registerBtn setTitleColor:[UIColor colorWithWhite:0.5 alpha:1] forState:UIControlStateHighlighted];
    [registerBtn addTarget:self action:@selector(loginBtnAction) forControlEvents:UIControlEventTouchUpInside];
    registerBtn.layer.cornerRadius = 6.0*kRate;
    [contentView addSubview:registerBtn];
    
}

#pragma mark ButtonAction

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
    if (_count !=1) {
        _count -=1;
        [getVerCodeBtn setTitle:[NSString stringWithFormat:@"%ld秒",_count] forState:UIControlStateDisabled];
    }
    else
    {
        [timer invalidate];
        getVerCodeBtn.enabled = YES;
        [getVerCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        getVerCodeBtn.backgroundColor = kRGBColor(64, 129, 251);
    }
}

- (void)protocolBtnAction
{
    NSLog(@"管车婆用户服务协议");
    
    ProtocolViewController *protocolVC = [[ProtocolViewController alloc] init];
    [self presentViewController:protocolVC animated:NO completion:nil];
}

- (void)loginBtnAction
{
    NSLog(@"注册并登录");
    
    [numberTF resignFirstResponder];//收起键盘
    [verificationCodeTF resignFirstResponder];
    [passwordTF resignFirstResponder];
    
    if (_numberStr.length!=0 && _verificationCodeStr.length!=0 && _passwordStr.length!=0) {
        if ([self.verificationCodePostStr isEqualToString:_verificationCodeStr]) {
            
            //在这里进行注册的网络请求
            [self registerPost];
            
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
    [passwordTF resignFirstResponder];
    
    return YES;
}

//当开始点击textField的时候会调用的方法
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag == 521) {
        _numberStr = textField.text;
    } else if (textField.tag == 420) {
        _verificationCodeStr = textField.text;
    } else if (textField.tag == 909) {
        _passwordStr = textField.text;
    }
    NSLog(@"手机号是:%@,验证码是:%@,密码是:%@", _numberStr, _verificationCodeStr, _passwordStr);
}

//当textField编辑结束时会调用的方法
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 521) {
        _numberStr = textField.text;
    } else if (textField.tag == 420) {
        _verificationCodeStr = textField.text;
    } else if (textField.tag == 909) {
        _passwordStr = textField.text;
    }
    NSLog(@"手机号是:%@,验证码是:%@,密码是:%@", _numberStr, _verificationCodeStr, _passwordStr);
}



#pragma mark 
#pragma mark --- 网络请求

//注册
- (void)registerPost
{
    NSString *url_post = [NSString stringWithFormat:@"http://%@regOrRestPwd.action", kHead];
    
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
            
            NSLog(@"注册成功");
            
            //登录，获取数据并保存到本地，然后页面跳转
            [self loginByNumber:_numberStr];
            
        } else {
            NSLog(@"注册失败");
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败， 失败原因是：%@", error);
    }];
}

@end
