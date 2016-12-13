//
//  AppointOnLineView.m
//  管车婆
//
//  Created by 李伟 on 16/12/13.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import "AppointOnLineView.h"

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
    nameTF.keyboardType = UIKeyboardTypePhonePad;
    [self addSubview:nameTF];
    [nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150, 39));
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
        make.size.mas_equalTo(CGSizeMake(150, 39));
        make.left.equalTo(phoneLB.mas_right).with.offset(20);
        make.top.equalTo(self).with.offset(81);
    }];
}

#pragma mark --- UITextFieldDelegate 
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //键盘出现时，让视图上升
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y - 250, self.frame.size.width, self.frame.size.height);
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    //键盘消失时，试图恢复原样
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + 250, self.frame.size.width, self.frame.size.height);
    [UIView commitAnimations];
}

@end
