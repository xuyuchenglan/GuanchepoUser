//
//  AddFuelCardVC.m
//  管车婆
//
//  Created by 李伟 on 16/10/28.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "AddFuelCardVC.h"
#import "CompanyCardView.h"

#define kFirstViewHeight 100*kRate

@interface AddFuelCardVC ()<UITextFieldDelegate>
{
    UIView *_firstView;
    UIView *_infoView;
    UIView *infoContentView;
    UIView *line1;
    UIView *line2;
}
@end

@implementation AddFuelCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kRGBColor(233, 239, 239);
    
    //设置导航栏
    [self addNavBar];
    
    //设置下面的视图
    [self addContentView];
}


#pragma mark ****** 设置导航栏 ******
- (void)addNavBar
{
    [self setNavigationItemTitle:@"添加加油卡"];
    [self setBackButtonWithImageName:@"back"];
}

#pragma mark ****** 设置下面的视图 ******
- (void)addContentView
{
    //中石油还是中石化
    [self addFirstView];
    
    //填写信息
    [self addInfoView];
    
    //“添加加油卡”按钮
    [self addBtn];
}

#pragma mark --- <一>中石油还是中石化
- (void)addFirstView
{
    _firstView = [[UIView alloc] init];
    _firstView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_firstView];
    [_firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, kFirstViewHeight));
        make.top.equalTo(self.view).with.offset(64+10*kRate);
        make.left.equalTo(self.view).with.offset(0);
    }];
    
    CompanyCardView *zhongshiyouCardView = [[CompanyCardView alloc] init];
    zhongshiyouCardView.cardType = @"中石油";
    [_firstView addSubview:zhongshiyouCardView];
    [zhongshiyouCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth/2, kFirstViewHeight));
        make.left.equalTo(_firstView).with.offset(0);
        make.top.equalTo(_firstView).with.offset(0);
    }];
    
    CompanyCardView *zhongshihuaCardView = [[CompanyCardView alloc] init];
    zhongshihuaCardView.cardType = @"中石化";
    [_firstView addSubview:zhongshihuaCardView];
    [zhongshihuaCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth/2, kFirstViewHeight));
        make.left.equalTo(_firstView).with.offset(kScreenWidth/2);
        make.top.equalTo(_firstView).with.offset(0);
    }];
}


#pragma mark --- <二>填写信息
- (void)addInfoView
{
    _infoView = [[UIView alloc] init];
    [self.view addSubview:_infoView];
    [_infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 160*kRate));
        make.top.equalTo(_firstView.mas_bottom).with.offset(0);
    }];
    
    //title
    UILabel *titleLB = [[UILabel alloc] init];
    titleLB.text = @"填写信息";
    titleLB.font = [UIFont systemFontOfSize:15.0*kRate];
    [_infoView addSubview:titleLB];
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(65*kRate, 20*kRate));
        make.top.equalTo(_infoView).with.offset(10*kRate);
        make.left.equalTo(_infoView).with.offset(30*kRate);
    }];
    
    
    //姓名、手机号、加油卡号
    [self addInfoContentView];
}

//姓名、手机号、加油卡号
- (void)addInfoContentView
{
    infoContentView = [[UIView alloc] init];
    infoContentView.backgroundColor = [UIColor whiteColor];
    [_infoView addSubview:infoContentView];
    [infoContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 120*kRate));
        make.top.equalTo(_infoView).with.offset(40*kRate);
    }];
    
    /*** 分割线 ***/
    line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 40*kRate, kScreenWidth, 1*kRate)];
    line1.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    [infoContentView addSubview:line1];
    
    line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 80*kRate, kScreenWidth, 1*kRate)];
    line2.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    [infoContentView addSubview:line2];
    /*** 分割线 ***/
    
    //姓名
    [self addName];
    
    //手机号
    [self addPhoneNumber];
    
    //加油卡号
    [self addCardNumber];
    
    
    
}

//姓名
- (void)addName
{
    UILabel *nameLB = [[UILabel alloc] init];
    nameLB.text = @"姓        名";
    nameLB.textColor = [UIColor colorWithWhite:0.4 alpha:1];
    nameLB.font = [UIFont systemFontOfSize:15.0*kRate];
    nameLB.textAlignment = NSTextAlignmentRight;
    [infoContentView addSubview:nameLB];
    [nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(65*kRate, 40*kRate));
        make.left.equalTo(infoContentView).with.offset(30*kRate);
        make.top.equalTo(infoContentView).with.offset(0);
    }];
    
    UITextField *nameTF = [[UITextField alloc] init];
    nameTF.delegate = self;
    nameTF.returnKeyType = UIReturnKeyDone;
    nameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    nameTF.textAlignment = NSTextAlignmentLeft;
    nameTF.adjustsFontSizeToFitWidth = YES;
    [nameTF setBorderStyle:UITextBorderStyleNone];
    [infoContentView addSubview:nameTF];
    [nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200*kRate, 40*kRate));
        make.left.equalTo(nameLB.mas_right).with.offset(50*kRate);
        make.top.equalTo(infoContentView).with.offset(0);
    }];
    
    NSMutableAttributedString *attrs = [[NSMutableAttributedString alloc] initWithString:@"请输入您的姓名"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSForegroundColorAttributeName] = [UIColor colorWithWhite:0.7 alpha:1];//placeHolder的文字颜色
    dic[NSFontAttributeName] = [UIFont systemFontOfSize:14.0*kRate];//文字大小
    [attrs setAttributes:dic range:NSMakeRange(0, attrs.length)];//range标识从第几个字符开始，长度是多少
    nameTF.attributedPlaceholder = attrs;
}

//手机号
- (void)addPhoneNumber
{
    UILabel *phoneNumberLB = [[UILabel alloc] init];
    phoneNumberLB.text = @"手  机  号";
    phoneNumberLB.textColor = [UIColor colorWithWhite:0.4 alpha:1];
    phoneNumberLB.font = [UIFont systemFontOfSize:15.0*kRate];
    phoneNumberLB.textAlignment = NSTextAlignmentRight;
    [infoContentView addSubview:phoneNumberLB];
    [phoneNumberLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(65*kRate, 39*kRate));
        make.left.equalTo(infoContentView).with.offset(30*kRate);
        make.top.equalTo(line1.mas_bottom).with.offset(0);
    }];
    
    UITextField *phoneNumberTF = [[UITextField alloc] init];
    phoneNumberTF.delegate = self;
    phoneNumberTF.returnKeyType = UIReturnKeyDone;
    phoneNumberTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneNumberTF.textAlignment = NSTextAlignmentLeft;
    phoneNumberTF.adjustsFontSizeToFitWidth = YES;
    [phoneNumberTF setBorderStyle:UITextBorderStyleNone];
    phoneNumberTF.keyboardType = UIKeyboardTypeNumberPad;
    [infoContentView addSubview:phoneNumberTF];
    [phoneNumberTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200*kRate, 39*kRate));
        make.left.equalTo(phoneNumberLB.mas_right).with.offset(50*kRate);
        make.top.equalTo(line1.mas_bottom).with.offset(0);
    }];
    
    NSMutableAttributedString *attrs = [[NSMutableAttributedString alloc] initWithString:@"请输入您的手机号"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSForegroundColorAttributeName] = [UIColor colorWithWhite:0.7 alpha:1];//placeHolder的文字颜色
    dic[NSFontAttributeName] = [UIFont systemFontOfSize:14.0*kRate];//文字大小
    [attrs setAttributes:dic range:NSMakeRange(0, attrs.length)];//range标识从第几个字符开始，长度是多少
    phoneNumberTF.attributedPlaceholder = attrs;
}


//加油卡号
- (void)addCardNumber
{
    UILabel *fuelCardNumberLB = [[UILabel alloc] init];
    fuelCardNumberLB.text = @"加油卡号";
    fuelCardNumberLB.textColor = [UIColor colorWithWhite:0.4 alpha:1];
    fuelCardNumberLB.font = [UIFont systemFontOfSize:15.0*kRate];
    fuelCardNumberLB.textAlignment = NSTextAlignmentRight;
    [infoContentView addSubview:fuelCardNumberLB];
    [fuelCardNumberLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(65*kRate, 39*kRate));
        make.left.equalTo(infoContentView).with.offset(30*kRate);
        make.top.equalTo(line2.mas_bottom).with.offset(0);
    }];
    
    UITextField *fuelCardNumberTF = [[UITextField alloc] init];
    fuelCardNumberTF.delegate = self;
    fuelCardNumberTF.returnKeyType = UIReturnKeyDone;
    fuelCardNumberTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    fuelCardNumberTF.textAlignment = NSTextAlignmentLeft;
    fuelCardNumberTF.adjustsFontSizeToFitWidth = YES;
    [fuelCardNumberTF setBorderStyle:UITextBorderStyleNone];
    [infoContentView addSubview:fuelCardNumberTF];
    [fuelCardNumberTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200*kRate, 39*kRate));
        make.left.equalTo(fuelCardNumberLB.mas_right).with.offset(50*kRate);
        make.top.equalTo(line2.mas_bottom).with.offset(0);
    }];
    
    NSMutableAttributedString *attrs = [[NSMutableAttributedString alloc] initWithString:@"请准确输入您的加油卡号"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSForegroundColorAttributeName] = [UIColor colorWithWhite:0.7 alpha:1];//placeHolder的文字颜色
    dic[NSFontAttributeName] = [UIFont systemFontOfSize:14.0*kRate];//文字大小
    [attrs setAttributes:dic range:NSMakeRange(0, attrs.length)];//range标识从第几个字符开始，长度是多少
    fuelCardNumberTF.attributedPlaceholder = attrs;

}

#pragma mark --------- UITextFieldDelegate
//点击“Return”键的时候调用的方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];//收起键盘
    return YES;
}

  

#pragma mark --- <三>“添加加油卡”按钮
- (void)addBtn
{
    UIButton *addFuelCardBtn = [[UIButton alloc] init];
    [addFuelCardBtn setTitle:@"添 加 加 油 卡" forState:UIControlStateNormal];
    addFuelCardBtn.titleLabel.font = [UIFont systemFontOfSize:18.0*kRate];
    addFuelCardBtn.backgroundColor = kRGBColor(22, 130, 251);
    addFuelCardBtn.layer.cornerRadius = 5.0*kRate;
    [self.view addSubview:addFuelCardBtn];
    [addFuelCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 60*kRate, 50*kRate));
        make.left.equalTo(self.view).with.offset(30*kRate);
        make.top.equalTo(_infoView.mas_bottom).with.offset(30*kRate);
    }];
}
@end
