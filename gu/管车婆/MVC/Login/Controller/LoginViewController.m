//
//  LoginViewController.m
//  管车婆
//
//  Created by 李伟 on 16/9/29.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "LoginViewController.h"
#import "VerificationCodeLoginVC.h"
#import "RegisterViewController.h"
#import "ForgotPasswordVC.h"
#import "MainViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
{
    UIButton    *verificationCodeBtn;
    UIImageView *logoImgView;
    UITextField *accountTF;
    UITextField *passwordTF;
    UIButton    *loginBtn;//登录按钮
    UIButton    *retrievePasswordBtn;//找回密码按钮
    UIButton    *registerAccountBtn;//注册账号按钮
}
@property (nonatomic, strong)NSString *accountStr;//记录输入框中输入的账号
@property (nonatomic, strong)NSString *passwordStr;//记录密码输入框中输入的密码
@end

@implementation LoginViewController

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
    
    [self setBackButtonWithIsText:NO withIsExit:YES WithText:nil WithImageName:@"back_blue"];
}


#pragma mark ****************  设置下面的内容  ******************
- (void)addContentView
{
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 65*kRate, kScreenWidth, kScreenHeight - 65*kRate)];
    contentView.backgroundColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1];
    [self.view addSubview:contentView];
    
    //手机验证码登录
    verificationCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 130*kRate, 10*kRate, 110*kRate, 25*kRate)];
    [verificationCodeBtn setTitle:@"手机验证码登录>" forState:UIControlStateNormal];
    [verificationCodeBtn setTitleColor:[UIColor colorWithRed:0 green:126/255.0 blue:1 alpha:1] forState:UIControlStateNormal];
    verificationCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14.0*kRate];
    [verificationCodeBtn addTarget:self action:@selector(verificationCodeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:verificationCodeBtn];
    
    //logo图标
    logoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 80*kRate, 50*kRate, 160*kRate, 50*kRate)];
    logoImgView.image = [UIImage imageNamed:@"login_logo"];
    [contentView addSubview:logoImgView];
    
    //账号输入框
    accountTF = [[UITextField alloc] initWithFrame:CGRectMake(40*kRate, CGRectGetMaxY(logoImgView.frame) + 30*kRate, kScreenWidth - 80*kRate, 40*kRate)];
    accountTF.delegate = self;
    [accountTF setBorderStyle:UITextBorderStyleRoundedRect];//边框
    accountTF.secureTextEntry = NO;//密码状态
    accountTF.autocorrectionType = UITextAutocorrectionTypeNo;//不自动纠错
    accountTF.returnKeyType = UIReturnKeyDone;//“return”键的类型
    accountTF.clearButtonMode = UITextFieldViewModeWhileEditing;//清除按钮何时出现
    accountTF.adjustsFontSizeToFitWidth = YES;//字体大小自适应输入框宽度
    accountTF.tag = 666;
    [contentView addSubview:accountTF];
    ///placeHolder
    NSMutableAttributedString *attrs = [[NSMutableAttributedString alloc] initWithString:@"请输入您的手机号/用户名"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSForegroundColorAttributeName] = [UIColor colorWithWhite:0.8 alpha:1];
    dic[NSFontAttributeName] = [UIFont systemFontOfSize:18*kRate];//文字大小
    dic[NSBaselineOffsetAttributeName] = @(-18*(1-kRate)/2);
    [attrs setAttributes:dic range:NSMakeRange(0, attrs.length)];
    accountTF.attributedPlaceholder = attrs; 
    
    //密码输入框
    passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(40*kRate, CGRectGetMaxY(accountTF.frame) + 20*kRate, kScreenWidth - 80*kRate, 40*kRate)];
    passwordTF.delegate = self;
    [passwordTF setBorderStyle:UITextBorderStyleRoundedRect];//边框
    passwordTF.secureTextEntry = YES;//密码状态
    passwordTF.autocorrectionType = UITextAutocorrectionTypeNo;//不自动纠错
    passwordTF.returnKeyType = UIReturnKeyDone;//“return”键的类型
    passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;//清除按钮何时出现
    passwordTF.adjustsFontSizeToFitWidth = YES;//字体大小自适应输入框宽度
    passwordTF.tag = 888;
    [contentView addSubview:passwordTF];
    ///placeHolder
    NSMutableAttributedString *attrs1 = [[NSMutableAttributedString alloc] initWithString:@"请输入您的密码"];
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    dic1[NSForegroundColorAttributeName] = [UIColor colorWithWhite:0.8 alpha:1];
    dic1[NSFontAttributeName] = [UIFont systemFontOfSize:18*kRate];//文字大小
    dic1[NSBaselineOffsetAttributeName] = @(-18*(1-kRate)/2);
    [attrs1 setAttributes:dic1 range:NSMakeRange(0, attrs1.length)];
    passwordTF.attributedPlaceholder = attrs1;
    
    
    //登录按钮
    loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(40*kRate, CGRectGetMaxY(passwordTF.frame) + 30*kRate, kScreenWidth - 80*kRate, 40*kRate)];
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
- (void)verificationCodeBtnAction
{
    NSLog(@"账号密码登录");
    
    VerificationCodeLoginVC *verCodeLoginVC = [[VerificationCodeLoginVC alloc] init];
    [self presentViewController:verCodeLoginVC animated:NO completion:nil];
}

- (void)loginBtnAction
{
    NSLog(@"登录");
    
    [accountTF resignFirstResponder];//收起键盘
    [passwordTF resignFirstResponder];
    
    if (_accountStr.length!=0 && _passwordStr.length!=0) {
        //账号密码登录
        [self loginByPhoneAndPwd];
        
    } else {
        NSLog(@"您的账户名或密码输入有误，请重试！");
        [self showAlertViewWithTitle:@"提示" WithMessage:@"您的账户名或密码输入有误，请重试！"];
    }

    
    
//    MainViewController *mainVC = [[MainViewController alloc] init];
//    [self presentViewController:mainVC animated:NO completion:nil];
    
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
//    [self.navigationController pushViewController:registerVC animated:NO];
}

#pragma mark UITextFieldDelegate
//点击“Return”键的时候调用的方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [accountTF resignFirstResponder];//收起键盘
    [passwordTF resignFirstResponder];
    return YES;
}

//当开始点击textField的时候会调用的方法
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag == 666) {
        _accountStr = textField.text;
    } else if (textField.tag == 888) {
        _passwordStr = textField.text;
    }
    NSLog(@"账号是:%@,密码是:%@", _accountStr, _passwordStr);
}

//当textField编辑结束时会调用的方法
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 666) {
        _accountStr = textField.text;
    } else if (textField.tag == 888) {
        _passwordStr = textField.text;
    }
    NSLog(@"账号是:%@,密码是:%@", _accountStr, _passwordStr);
}


#pragma mark
#pragma mark --- 网络请求
- (void)loginByPhoneAndPwd
{
    NSString *url_post = [NSString stringWithFormat:@"http://%@:8080/zcar/userapp/loginByPhoneAndPwd.action", kIP];
    
    NSDictionary *params = @{
                             @"phone":_accountStr,
                             @"pwd":_passwordStr
                             };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];

    manager.responseSerializer = responseSerializer;
    
    [manager POST:url_post parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"账号密码登录请求数据成功，请求下来的Json格式的数据是%@", content);
        
        NSDictionary *jsondataDic = [content objectForKey:@"jsondata"];
        NSString *resultStr = [content objectForKey:@"result"];
        
        if ([resultStr isEqualToString:@"success"]  && ![jsondataDic  isEqual: @""]) {
            
            NSLog(@"登陆成功");
            
            //保存个人数据,将获取到的jsondata对应的数组中的uid等数据存储到本地plist文件中
            [self saveDataToPlistWithDic:jsondataDic];
            
            //跳入到MainViewController
            [self presentViewController:[[MainViewController alloc] init] animated:NO completion:nil];
            
        } else {
            NSLog(@"账号密码验证失败");
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败， 失败原因是：%@", error);
    }];

}





@end
