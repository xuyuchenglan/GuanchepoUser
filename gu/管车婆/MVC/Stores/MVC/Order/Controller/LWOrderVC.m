//
//  LWOrderVC.m
//  管车婆
//
//  Created by 李伟 on 16/12/12.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import "LWOrderVC.h"
#import "AppointOrderView.h"

#define kEdgeWidth (kScreenWidth - 300)/4

@interface LWOrderVC ()
{
    AppointOrderView *_appointOrderView;
}
@property (nonatomic, strong)UIView          *qrView;//装载扫描生成二维码按钮的view

@end

@implementation LWOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    [self setNavigationItemTitle:@"下单"];
}

#pragma mark ******  设置下方的内容视图  ******
- (void)addContentView
{
    //店铺大头照
    UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 225*kRate)];
    headImgView.image = [UIImage imageNamed:@"stores_headImg"];
    [self.view addSubview:headImgView];
    
    //店铺各种详细信息
    _appointOrderView = [[AppointOrderView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headImgView.frame), kScreenWidth, 140)];
    [self.view addSubview:_appointOrderView];
    
    //二维码、验证码
    [self addQR];
    
    //注意事项
    [self addMettersNeedingAttention];

}

#pragma  mark --  二维码、验证码
- (void)addQR
{
    _qrView = [[UIView alloc] init];
    _qrView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_qrView];
    [_qrView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 100));
        make.left.equalTo(self.view).with.offset(0);
        make.top.equalTo(_appointOrderView.mas_bottom).with.offset(10);
    }];
    
    //扫描商家二维码
    [self scanQR];
    
    //生成客户二维码
    [self createQR];
    
    //发送手机验证码
    [self createYanzhengma];
}

//扫描商家二维码
- (void)scanQR
{
    UIButton *scanQRBtn = [[UIButton alloc] initWithFrame:CGRectMake(kEdgeWidth, 0, 100, 100)];
    [scanQRBtn addTarget:self action:@selector(scanQRBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [scanQRBtn setImage:[UIImage imageNamed:@"scanQR"] forState:UIControlStateNormal];
    scanQRBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 25, 40, 25);
    
    [scanQRBtn setTitle:@"扫描商家二维码" forState:UIControlStateNormal];
    scanQRBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    scanQRBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [scanQRBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    scanQRBtn.titleEdgeInsets = UIEdgeInsetsMake(70, -scanQRBtn.titleLabel.bounds.size.width - 130, 20, 0);
    
    [_qrView addSubview:scanQRBtn];
}

//生成客户二维码
- (void)createQR
{
    UIButton *createQRBtn = [[UIButton alloc] initWithFrame:CGRectMake(kEdgeWidth*2 + 100, 0, 100, 100)];
    [createQRBtn addTarget:self action:@selector(createQRBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [createQRBtn setImage:[UIImage imageNamed:@"createQR"] forState:UIControlStateNormal];
    createQRBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 25, 40, 25);
    
    [createQRBtn setTitle:@"生成客户二维码" forState:UIControlStateNormal];
    createQRBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    createQRBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [createQRBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    createQRBtn.titleEdgeInsets = UIEdgeInsetsMake(70, -createQRBtn.titleLabel.bounds.size.width - 145, 20, 0);
    
    [_qrView addSubview:createQRBtn];
    
}

//发送手机验证码
- (void)createYanzhengma
{
    UIButton *createYanzhengmaBtn = [[UIButton alloc] initWithFrame:CGRectMake(kEdgeWidth*3 + 200, 0, 100, 100)];
    [createYanzhengmaBtn addTarget:self action:@selector(createYanzhengmaBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [createYanzhengmaBtn setImage:[UIImage imageNamed:@"yanzhengma"] forState:UIControlStateNormal];
    createYanzhengmaBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 25, 40, 25);
    
    [createYanzhengmaBtn setTitle:@"发送手机验证码" forState:UIControlStateNormal];
    createYanzhengmaBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    createYanzhengmaBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [createYanzhengmaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    createYanzhengmaBtn.titleEdgeInsets = UIEdgeInsetsMake(70, -createYanzhengmaBtn.titleLabel.bounds.size.width - 150, 20, 0);
    
    [_qrView addSubview:createYanzhengmaBtn];
    
}

#pragma mark ------ <1>扫描客户二维码，并进行网络下单
//扫描客户二维码
- (void)scanQRBtnAction
{
    NSLog(@"扫描客户二维码");
}

#pragma mark ------ <2>生成二维码，改变二维码颜色~
//生成商家二维码
- (void)createQRBtnAction
{
    NSLog(@"生成商家二维码");
}


#pragma mark ------ <3>生成验证码~
//发送手机验证码
- (void)createYanzhengmaBtnAction
{
    NSLog(@"发送手机验证码");
}

#pragma  mark --  注意事项
- (void)addMettersNeedingAttention
{
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    [self.view addSubview:label];
    label.attributedText = [self getAttributedStringWithTitleOne:@"下单注意事项：" Desc1:@"1.下单生成的二维码或者扫描商户的二维码都需要在两个小时内完成，否则二维码失效；" Desc2:@"2.提成会记入您的余额当中，您可进行提现；" Desc3:@"3.提现金额3-5个工作日内打入您的账户。"];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-60, 120));
        make.left.equalTo(self.view).with.offset(30);
        make.top.equalTo(_qrView.mas_bottom).with.offset(10);
    }];
}

-(NSMutableAttributedString *)getAttributedStringWithTitleOne:(NSString *)title Desc1:(NSString *)desc1 Desc2:(NSString *)desc2 Desc3:(NSString *)desc3
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5.0];//调整行间距
    
    NSMutableAttributedString *mutaTitle = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",title] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor blackColor],NSParagraphStyleAttributeName:paragraphStyle}];
    
    NSMutableAttributedString *mutaDesc1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",desc1] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor colorWithWhite:0.4 alpha:1],NSParagraphStyleAttributeName:paragraphStyle}];
    
    NSMutableAttributedString *mutaDesc2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",desc2] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor colorWithWhite:0.4 alpha:1],NSParagraphStyleAttributeName:paragraphStyle}];
    
    NSMutableAttributedString *mutaDesc3 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",desc3] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor colorWithWhite:0.4 alpha:1],NSParagraphStyleAttributeName:paragraphStyle}];
    
    [mutaTitle appendAttributedString:mutaDesc1];
    [mutaTitle appendAttributedString:mutaDesc2];
    [mutaTitle appendAttributedString:mutaDesc3];
    
    return mutaTitle;
    
}

@end
