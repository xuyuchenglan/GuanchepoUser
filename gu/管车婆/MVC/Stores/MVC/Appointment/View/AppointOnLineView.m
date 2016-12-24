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
    UIButton *_timeBtn;
}
@end

@implementation AppointOnLineView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
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
    timeLB.font = [UIFont systemFontOfSize:15];
    [self addSubview:timeLB];
    [timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 40));
        make.left.equalTo(self).with.offset(20);
        make.top.equalTo(self).with.offset(0);
    }];
    
    _timeBtn = [[UIButton alloc] init];
    _timeBtn.backgroundColor = [UIColor orangeColor];
    [_timeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _timeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_timeBtn setTitle:[self getCurrentDate] forState:UIControlStateNormal];
    [_timeBtn addTarget:self action:@selector(timeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_timeBtn];
    [_timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150, 40));
        make.left.equalTo(timeLB.mas_right).with.offset(20);
        make.top.equalTo(self).with.offset(0);
    }];
    
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, 0.5)];
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
    nameLB.font = [UIFont systemFontOfSize:15];
    [self addSubview:nameLB];
    [nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 39));
        make.left.equalTo(self).with.offset(20);
        make.top.equalTo(self).with.offset(41);
    }];
    
    UITextField *nameTF = [[UITextField alloc] init];
    nameTF.delegate = self;
    nameTF.tag = 923521;
    [nameTF setBorderStyle:UITextBorderStyleNone];
    nameTF.returnKeyType = UIReturnKeyDone;
    nameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    nameTF.text = [[self getLocalDic] objectForKey:@"realname"];
    nameTF.font = [UIFont systemFontOfSize:15.0];
    nameTF.keyboardType = UIKeyboardTypeDefault;
    [self addSubview:nameTF];
    [nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(250, 39));
        make.left.equalTo(nameLB.mas_right).with.offset(20);
        make.top.equalTo(self).with.offset(41);
    }];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 80, kScreenWidth, 0.5)];
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
    phoneLB.font = [UIFont systemFontOfSize:15];
    [self addSubview:phoneLB];
    [phoneLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 39));
        make.left.equalTo(self).with.offset(20);
        make.top.equalTo(self).with.offset(81);
    }];
    
    UITextField *phoneTF = [[UITextField alloc] init];
    phoneTF.delegate = self;
    phoneTF.tag = 923520;
    [phoneTF setBorderStyle:UITextBorderStyleNone];
    phoneTF.returnKeyType = UIReturnKeyDone;
    phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneTF.text = [[self getLocalDic] objectForKey:@"phone"];
    phoneTF.font = [UIFont systemFontOfSize:15.0];
    phoneTF.keyboardType = UIKeyboardTypePhonePad;
    [self addSubview:phoneTF];
    [phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(250, 39));
        make.left.equalTo(phoneLB.mas_right).with.offset(20);
        make.top.equalTo(self).with.offset(81);
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

@end
