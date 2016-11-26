//
//  EnquiryIllegalVC.m
//  管车婆
//
//  Created by 李伟 on 16/10/8.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "EnquiryIllegalVC.h"
#import "IllegalResultVC.h"

@interface EnquiryIllegalVC ()<UITextFieldDelegate>
{
    UIView *_firstView;
    UIView *_secondView;
}
@end

@implementation EnquiryIllegalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:233/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    
    //设置导航栏
    [self addNavBar];

    //设置下面的内容
    [self addContentView];
}

#pragma mark *************   设置导航栏   *********************
- (void)addNavBar
{
    [self setNavigationItemTitle:@"违章查询"];
    
    [self setBackButtonWithImageName:@"back"];
}


#pragma mark ************   设置下面的内容   *************
- (void)addContentView
{
    //第一行，车标、车的类型
    [self addFirstView];
    
    //第二行，车牌号码、发动机号、车牌号
    [self addSecondView];
    
    //第三行，“立即查询”按钮
    UIButton *selectNowBtn = [[UIButton alloc] initWithFrame:CGRectMake(30*kRate, CGRectGetMaxY(_secondView.frame) + 50*kRate, kScreenWidth - 60*kRate, 40*kRate)];
    [selectNowBtn setBackgroundColor:[UIColor colorWithRed:22/255.0 green:129/255.0 blue:251/255.0 alpha:1]];
    selectNowBtn.titleLabel.font = [UIFont systemFontOfSize:18*kRate];
    selectNowBtn.layer.cornerRadius = 5.0*kRate;
    [selectNowBtn setTitle:@"立即查询" forState:UIControlStateNormal];
    [selectNowBtn addTarget:self action:@selector(selectNowBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectNowBtn];
}

- (void)addFirstView
{
    _firstView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40*kRate)];
    if (self.navigationController.navigationBar) {
        _firstView.frame = CGRectMake(0, 64, kScreenWidth, 40*kRate);
    } else {
        _firstView.frame = CGRectMake(0, 0, kScreenWidth, 40*kRate);
    }
    [self.view addSubview:_firstView];
    
    UIImageView *carImg = [[UIImageView alloc] initWithFrame:CGRectMake(20*kRate, 5*kRate, 35*kRate, 30*kRate)];
    carImg.image = [UIImage imageNamed:@"forth_illegal_car.jpg"];
    [_firstView addSubview:carImg];
    
    UILabel *carText = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(carImg.frame) + 10*kRate, 10*kRate, 100*kRate, 20*kRate)];
    carText.font = [UIFont systemFontOfSize:15*kRate];
    carText.text = @"宝马X5";
    [_firstView addSubview:carText];
    
}

//第二行，车牌号码、发动机号、车牌号
- (void)addSecondView
{
    _secondView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_firstView.frame), kScreenWidth, 150*kRate)];
    _secondView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_secondView];
    
    /***********   分割线   ****************/
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 49*kRate, kScreenWidth, 1*kRate)];
    lineView1.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [_secondView addSubview:lineView1];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 99*kRate, kScreenWidth, 1*kRate)];
    lineView2.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [_secondView addSubview:lineView2];
    /***********   分割线   ****************/
    
    //车牌号码
    UILabel *licensePlateLabel = [[UILabel alloc] initWithFrame:CGRectMake(30*kRate, 0, 80*kRate, 50*kRate)];
    licensePlateLabel.text = @"车牌号码";
    licensePlateLabel.font = [UIFont systemFontOfSize:16.0*kRate];
    [_secondView addSubview:licensePlateLabel];
    
    
    
    //发动机号
    UILabel *engineNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(30*kRate, 50*kRate, 80*kRate, 50*kRate)];
    engineNumberLabel.text = @"发动机号";
    engineNumberLabel.font = [UIFont systemFontOfSize:16.0*kRate];
    [_secondView addSubview:engineNumberLabel];
    
    UITextField *engineNumberTF = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth - 210*kRate, 60*kRate, 180*kRate, 40*kRate)];
    engineNumberTF.delegate = self;
    [engineNumberTF setBorderStyle:UITextBorderStyleNone];
    engineNumberTF.returnKeyType = UIReturnKeyDone;
    engineNumberTF.clearButtonMode = UITextFieldViewModeAlways;
    engineNumberTF.adjustsFontSizeToFitWidth = YES;
    
    NSMutableAttributedString *attrs = [[NSMutableAttributedString alloc] initWithString:@"请准确输入您的发动机号码"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSForegroundColorAttributeName] = [UIColor colorWithWhite:0.8 alpha:1];//placeHolder的文字颜色
    dic[NSFontAttributeName] = [UIFont systemFontOfSize:14*kRate];//文字大小
    [attrs setAttributes:dic range:NSMakeRange(0, attrs.length)];//range标识从第几个字符开始，长度是多少
    engineNumberTF.attributedPlaceholder = attrs;
    
    [_secondView addSubview:engineNumberTF];
    
    
    //车架号
    UILabel *chassisNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(30*kRate, 100*kRate, 80*kRate, 50*kRate)];
    chassisNumberLabel.text = @"车架号";
    chassisNumberLabel.font = [UIFont systemFontOfSize:16.0*kRate];
    [_secondView addSubview:chassisNumberLabel];
    
    UITextField *chassisNumberTF = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth - 210*kRate, 110*kRate, 180*kRate, 40*kRate)];
    chassisNumberTF.delegate = self;
    [chassisNumberTF setBorderStyle:UITextBorderStyleNone];
    chassisNumberTF.returnKeyType = UIReturnKeyDone;
    chassisNumberTF.clearButtonMode = UITextFieldViewModeAlways;
    chassisNumberTF.adjustsFontSizeToFitWidth = YES;
    
    NSMutableAttributedString *attrs1 = [[NSMutableAttributedString alloc] initWithString:@"请准确输入您的车架号码"];
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    dic1[NSForegroundColorAttributeName] = [UIColor colorWithWhite:0.8 alpha:1];//placeHolder的文字颜色
    dic1[NSFontAttributeName] = [UIFont systemFontOfSize:14*kRate];//文字大小
    [attrs1 setAttributes:dic1 range:NSMakeRange(0, attrs1.length)];//range标识从第几个字符开始，长度是多少
    chassisNumberTF.attributedPlaceholder = attrs1;
    
    [_secondView addSubview:chassisNumberTF];

}

#pragma mark --- 立即查询按钮Action
- (void)selectNowBtnAction
{
    NSLog(@"立即查询");
    
    
    IllegalResultVC *illegalResultVC = [[IllegalResultVC alloc] init];
    illegalResultVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:illegalResultVC animated:NO];
    illegalResultVC.hidesBottomBarWhenPushed = NO;
}

@end
