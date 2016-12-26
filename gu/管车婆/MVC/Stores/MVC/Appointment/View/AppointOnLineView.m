//
//  AppointOnLineView.m
//  管车婆
//
//  Created by 李伟 on 16/12/13.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import "AppointOnLineView.h"
#import "AppointOnLineView+GetCurrentDate.h"

@interface AppointOnLineView() <UITextFieldDelegate>
{
    
}

@end

@implementation AppointOnLineView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        //添加通知观察者，监听DatePickerVC发送过来的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateAppointmentDateLB:) name:@"updateAppointmentDateLB" object:nil];
        
        //第一行
        [self addFirstLine];
        
        //第二行
        [self addSecondLine];
        
        //第三行
        [self addThirdLine];
        
    }
    return self;
}

    //第一行
- (void)addFirstLine
{
    UILabel *timeLB = [[UILabel alloc] init];
    timeLB.text = @"预约时间";
    timeLB.adjustsFontSizeToFitWidth = YES;
    timeLB.textAlignment = NSTextAlignmentCenter;
    timeLB.font = [UIFont systemFontOfSize:15*kRate];
    [self addSubview:timeLB];
    [timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70*kRate, 40*kRate));
        make.left.equalTo(self).with.offset(20*kRate);
        make.top.equalTo(self).with.offset(0);
    }];
    
    _timeBtn = [[UIButton alloc] init];
    [_timeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _timeBtn.titleLabel.font = [UIFont systemFontOfSize:15*kRate];
    [_timeBtn setTitle:[self getCurrentDate] forState:UIControlStateNormal];
    [_timeBtn addTarget:self action:@selector(timeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_timeBtn];
    [_timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(250*kRate, 40*kRate));
        make.left.equalTo(timeLB.mas_right).with.offset(20*kRate);
        make.top.equalTo(self).with.offset(0);
    }];
    
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 40*kRate, kScreenWidth, 0.5*kRate)];
    line1.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
    [self addSubview:line1];
}



    //第二行
- (void)addSecondLine
{
    UILabel *nameLB = [[UILabel alloc] init];
    nameLB.text = @"联 系 人";
    nameLB.adjustsFontSizeToFitWidth = YES;
    nameLB.textAlignment = NSTextAlignmentCenter;
    nameLB.font = [UIFont systemFontOfSize:15*kRate];
    [self addSubview:nameLB];
    [nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70*kRate, 39*kRate));
        make.left.equalTo(self).with.offset(20*kRate);
        make.top.equalTo(self).with.offset(41*kRate);
    }];
    
    _nameTF = [[UITextField alloc] init];
    _nameTF.delegate = self;
    _nameTF.tag = 923521;
    _nameTF.textAlignment = NSTextAlignmentCenter;
    [_nameTF setBorderStyle:UITextBorderStyleNone];
    _nameTF.returnKeyType = UIReturnKeyDone;
    _nameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _nameTF.text = [[self getLocalDic] objectForKey:@"realname"];
    _nameTF.font = [UIFont systemFontOfSize:15.0*kRate];
    _nameTF.keyboardType = UIKeyboardTypeDefault;
    [self addSubview:_nameTF];
    [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(250*kRate, 39*kRate));
        make.left.equalTo(nameLB.mas_right).with.offset(20*kRate);
        make.top.equalTo(self).with.offset(41*kRate);
    }];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 80*kRate, kScreenWidth, 0.5*kRate)];
    line2.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
    [self addSubview:line2];
}


    //第三行
- (void)addThirdLine
{
    UILabel *phoneLB = [[UILabel alloc] init];
    phoneLB.text = @"联系电话";
    phoneLB.adjustsFontSizeToFitWidth = YES;
    phoneLB.textAlignment = NSTextAlignmentCenter;
    phoneLB.font = [UIFont systemFontOfSize:15*kRate];
    [self addSubview:phoneLB];
    [phoneLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70*kRate, 39*kRate));
        make.left.equalTo(self).with.offset(20*kRate);
        make.top.equalTo(self).with.offset(81*kRate);
    }];
    
    _phoneTF = [[UITextField alloc] init];
    _phoneTF.delegate = self;
    _phoneTF.tag = 923520;
    _phoneTF.textAlignment = NSTextAlignmentCenter;
    [_phoneTF setBorderStyle:UITextBorderStyleNone];
    _phoneTF.returnKeyType = UIReturnKeyDone;
    _phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneTF.text = [[self getLocalDic] objectForKey:@"phone"];
    _phoneTF.font = [UIFont systemFontOfSize:15.0*kRate];
    _phoneTF.keyboardType = UIKeyboardTypePhonePad;
    [self addSubview:_phoneTF];
    [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(250*kRate, 39*kRate));
        make.left.equalTo(phoneLB.mas_right).with.offset(20*kRate);
        make.top.equalTo(self).with.offset(81*kRate);
    }];
}

#pragma mark --- UITextFieldDelegate 
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
//    [textField resignFirstResponder];
    [self endEditing:YES];//令键盘消失
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

#pragma mark --- ButtonAction
- (void)timeBtnAction
{
    if (self.myBlock != nil) {
        self.myBlock();
    }
}

- (void)dateBtnActionWithBlock:(MyBlock)block
{
    self.myBlock = block;
}

#pragma mark 接收到通知之后采取的具体操作
- (void)updateAppointmentDateLB:(NSNotification *)info
{
    NSString *date = info.userInfo[@"dateStr"];
    [_timeBtn setTitle:date forState:UIControlStateNormal];
}


#pragma mark 复写deallock方法移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
