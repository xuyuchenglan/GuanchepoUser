//
//  LWAppointmentVc.m
//  管车婆
//
//  Created by 李伟 on 16/12/12.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import "LWAppointmentVc.h"
#import "AppointOrderView.h"
#import "AppointOnLineView.h"

@interface LWAppointmentVc ()
{
    AppointOrderView *_appointOrderView;
}
@end

@implementation LWAppointmentVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加通知中心监听，当键盘弹出或者消失时收到消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    //设置导航栏
    [self addNavBar];
    
    //设置下方的内容视图
    [self addContentView];
}

#pragma mark ******  设置导航栏  ******
- (void)addNavBar
{
    self.view.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    
    [self setBackButtonWithImageName:@"back"];
    [self setNavigationItemTitle:@"预约"];
}

#pragma mark ******  设置下方的内容视图  ******
- (void)addContentView
{
    //店铺大头照
    UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 225*kRate)];
//    headImgView.image = [UIImage imageNamed:@"stores_headImg"];
    [headImgView sd_setImageWithURL:_storeModel.headUrl placeholderImage:[UIImage imageNamed:@"stores_headImg"] options:SDWebImageRefreshCached];
    [self.view addSubview:headImgView];
    
    //店铺各种详细信息
    _appointOrderView = [[AppointOrderView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headImgView.frame), kScreenWidth, 140)];
    _appointOrderView.storeModel = _storeModel;
    [self.view addSubview:_appointOrderView];
    
    //“在线预约”
    [self appointOnLine];
    
    //下面的两个按钮
    [self addBtn];
}

//“在线预约”
- (void)appointOnLine
{
    UILabel *titleLB = [[UILabel alloc] init];
    titleLB.text = @"在线预约";
    titleLB.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:titleLB];
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.left.equalTo(self.view).with.offset(15);
        make.top.equalTo(_appointOrderView.mas_bottom).with.offset(0);
    }];
    
    AppointOnLineView *appointOnLineView = [[AppointOnLineView alloc] init];
    [self.view addSubview:appointOnLineView];
    [appointOnLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 120));
        make.left.equalTo(self.view).with.offset(0);
        make.top.equalTo(titleLB.mas_bottom).with.offset(0);
    }];
    [appointOnLineView dateBtnActionWithBlock:^{
        
    }];
}




    //下面的两个按钮
- (void)addBtn
{
    UIButton *appointImmediatelyBtn = [[UIButton alloc] init];
    [appointImmediatelyBtn setTitle:@"立即预约" forState:UIControlStateNormal];
    [appointImmediatelyBtn addTarget:self action:@selector(appointImmediatelyBtnAction) forControlEvents:UIControlEventTouchUpInside];
    appointImmediatelyBtn.titleLabel.font = [UIFont systemFontOfSize:24.0];
    appointImmediatelyBtn.backgroundColor = [UIColor colorWithRed:33/255.0 green:105/255.0 blue:250/255.0 alpha:1];
    [self.view addSubview:appointImmediatelyBtn];
    [appointImmediatelyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth*0.6, 50));
        make.left.equalTo(self.view).with.offset(0);
        make.bottom.equalTo(self.view).with.offset(0);
    }];
    
    UIButton *myAppointmentBtn = [[UIButton alloc] init];
    [myAppointmentBtn setTitle:@"我的预约" forState:UIControlStateNormal];
    [myAppointmentBtn addTarget:self action:@selector(myAppointmentBtnAction) forControlEvents:UIControlEventTouchUpInside];
    myAppointmentBtn.titleLabel.font = [UIFont systemFontOfSize:24.0];
    myAppointmentBtn.backgroundColor = [UIColor colorWithRed:249/255.0 green:14/255.0 blue:27/255.0 alpha:1];
    [self.view addSubview:myAppointmentBtn];
    [myAppointmentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth*0.4, 50));
        make.right.equalTo(self.view).with.offset(0);
        make.bottom.equalTo(self.view).with.offset(0);
    }];
}

#pragma mark --- ButtonAction
- (void)appointImmediatelyBtnAction
{
    NSLog(@"立即预约");
    [self.view endEditing:YES];//令键盘消失
}

- (void)myAppointmentBtnAction
{
    NSLog(@"我的预约");
}

#pragma mark
#pragma mark 收到键盘显示或者隐藏的消息时调用的操作
//键盘显示
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSLog(@"键盘显示");
    
//    //键盘出现时，让视图上升
//    [UIView beginAnimations:@"animation" context:nil];
//    [UIView setAnimationDuration:0.2];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - 250, self.view.frame.size.width, self.view.frame.size.height);
//    [UIView commitAnimations];
//    
    //1，取得键盘最后的frame
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat height = keyboardFrame.size.height;
    //2，计算控制器的View需要移动的距离
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationBeginsFromCurrentState:YES];
       ///移动（带有动画）
    CGRect frame = self.view.frame;
    frame.origin.y = -height ;
    self.view.frame = frame;
    [UIView commitAnimations];
    
    
}


//键盘隐藏
- (void)keyboardWillHide:(NSNotification *)notification
{
    NSLog(@"键盘隐藏");
    
    //键盘消失时，试图恢复原样
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationBeginsFromCurrentState:YES];
       ///移动（带有动画）
    CGRect frame = self.view.frame;
    frame.origin.y = 0;
    self.view.frame = frame;
    [UIView commitAnimations];

}

#pragma mark
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
