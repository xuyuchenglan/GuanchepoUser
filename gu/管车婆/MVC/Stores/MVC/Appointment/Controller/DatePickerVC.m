//
//  DatePickerVC.m
//  管车婆
//
//  Created by 李伟 on 16/12/24.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import "DatePickerVC.h"

@interface DatePickerVC ()

@end

@implementation DatePickerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self setNavigationItemTitle:@"预约时间"];
    
    //设置datePickerView
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 200)];
    datePicker.datePickerMode = UIDatePickerModeDateAndTime;//选取不同的时间/日期选择模式
    [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:datePicker];
    
    //完成按钮
    UIButton *commitBtn = [[UIButton alloc] init];
    [commitBtn addTarget:self action:@selector(commitBtnAction) forControlEvents:UIControlEventTouchUpInside];
    commitBtn.layer.cornerRadius = 5.0*kRate;
    [commitBtn setTitle:@"完成" forState:UIControlStateNormal];
    commitBtn.backgroundColor = [UIColor colorWithRed:22/255.0 green:129/255.0 blue:252/255.0 alpha:1];
    [self.view addSubview:commitBtn];
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 100*kRate, 50*kRate));
        make.top.equalTo(datePicker.mas_bottom).with.offset(100*kRate);
        make.left.equalTo(self.view).with.offset(50*kRate);
    }];
    
    
}

//完成按钮Action
- (void)commitBtnAction
{
    [self.navigationController popViewControllerAnimated:NO];
}


//当时间改变的时候调用的方法
- (void)dateChanged:(id)sender
{
    UIDatePicker *control = (UIDatePicker *)sender;
    NSDate *currentDate = control.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    
    //给AppointOnLineView发送一个通知，改变预约时间栏的显示
    NSDictionary *dict =@{
                          @"dateStr":dateString
                          };
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateAppointmentDateLB" object:nil userInfo:dict];
    
}





@end
