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
#import "DatePickerVC.h"

@interface LWAppointmentVc ()
{
    AppointOrderView *_appointOrderView;
    AppointOnLineView *_appointOnLineView;
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
    [headImgView sd_setImageWithURL:_storeModel.headUrl placeholderImage:[UIImage imageNamed:@"stores_headImg"] options:SDWebImageRefreshCached];
    [self.view addSubview:headImgView];
    
    //店铺各种详细信息
    _appointOrderView = [[AppointOrderView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headImgView.frame), kScreenWidth, 140*kRate)];
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
    titleLB.font = [UIFont systemFontOfSize:17*kRate];
    [self.view addSubview:titleLB];
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*kRate, 40*kRate));
        make.left.equalTo(self.view).with.offset(15*kRate);
        make.top.equalTo(_appointOrderView.mas_bottom).with.offset(0);
    }];
    
    _appointOnLineView = [[AppointOnLineView alloc] init];
    [self.view addSubview:_appointOnLineView];
    [_appointOnLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 120*kRate));
        make.left.equalTo(self.view).with.offset(0);
        make.top.equalTo(titleLB.mas_bottom).with.offset(0);
    }];
    [_appointOnLineView dateBtnActionWithBlock:^{
        
        NSLog(@"跳入datePickerVC");
        DatePickerVC *datePickerVC = [[DatePickerVC alloc] init];
        [self.navigationController pushViewController:datePickerVC animated:NO];
        
    }];
}




    //下面的两个按钮
- (void)addBtn
{
    UIButton *appointImmediatelyBtn = [[UIButton alloc] init];
    [appointImmediatelyBtn setTitle:@"立即预约" forState:UIControlStateNormal];
    [appointImmediatelyBtn addTarget:self action:@selector(appointImmediatelyBtnAction) forControlEvents:UIControlEventTouchUpInside];
    appointImmediatelyBtn.titleLabel.font = [UIFont systemFontOfSize:24.0*kRate];
    appointImmediatelyBtn.backgroundColor = [UIColor colorWithRed:33/255.0 green:105/255.0 blue:250/255.0 alpha:1];
    [self.view addSubview:appointImmediatelyBtn];
    [appointImmediatelyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth*0.6, 50*kRate));
        make.left.equalTo(self.view).with.offset(0);
        make.bottom.equalTo(self.view).with.offset(0);
    }];
    
    UIButton *myAppointmentBtn = [[UIButton alloc] init];
    [myAppointmentBtn setTitle:@"我的预约" forState:UIControlStateNormal];
    [myAppointmentBtn addTarget:self action:@selector(myAppointmentBtnAction) forControlEvents:UIControlEventTouchUpInside];
    myAppointmentBtn.titleLabel.font = [UIFont systemFontOfSize:24.0*kRate];
    myAppointmentBtn.backgroundColor = [UIColor colorWithRed:249/255.0 green:14/255.0 blue:27/255.0 alpha:1];
    [self.view addSubview:myAppointmentBtn];
    [myAppointmentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth*0.4, 50*kRate));
        make.right.equalTo(self.view).with.offset(0);
        make.bottom.equalTo(self.view).with.offset(0);
    }];
}

#pragma mark --- ButtonAction
- (void)appointImmediatelyBtnAction
{
    [self.view endEditing:YES];//令键盘消失
    
    NSLog(@"“立即预约”按钮的响应");
    
    //立即预约的网络请求
    NSString *url_post = [NSString stringWithFormat:@"http://%@createOrderyy.action", kHead];
    
    NSDictionary *params = @{
                             @"uid":[[self getLocalDic] objectForKey:@"uid"],
                             @"mid":_storeModel.mid,
                             @"superid":_sid,
                             @"urealname":_appointOnLineView.nameTF.text,
                             @"uphone":_appointOnLineView.phoneTF.text,
                             @"yy_start":_appointOnLineView.timeBtn.titleLabel.text
                             };
    NSLog(@"%@?uid=%@&mid=%@&superid=%@&urealname=%@&uphone=%@&yy_start=%@",url_post, [[self getLocalDic] objectForKey:@"uid"], _storeModel.mid, _sid, _appointOnLineView.nameTF.text, _appointOnLineView.phoneTF.text, _appointOnLineView.timeBtn.titleLabel.text);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = responseSerializer;
    [manager POST:url_post parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSString *result = [content objectForKey:@"result"];
        if ([result isEqual:@"success"]) {
            
            //提示下单成功
            [self showAlertViewWithTitle:@"预约成功" WithMessage:@"请在您预约的时间到店进行消费~你可以在“我的”页面查看你的订单信息"];
            
        } else if ([result isEqual:@"fail"]) {
            
            //提示下单失败，将errormsg显示出来
            NSString *errMsg = [content objectForKey:@"errormsg"];
            [self showAlertViewWithTitle:@"预约失败" WithMessage:errMsg];
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败， 失败原因是：%@", error);
    }];

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
