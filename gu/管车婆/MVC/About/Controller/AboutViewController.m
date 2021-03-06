//
//  AboutViewController.m
//  管车婆
//
//  Created by 李伟 on 16/9/27.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "AboutViewController.h"
#import "CardAndCarView.h"
#import "AboutCell.h"
#import "OrderViewController.h"
#import "ExchangePointsVC.h"
#import "CarCouponVC.h"
#import "FreeExperienceVoucherVC.h"
#import "SellCardVC.h"
#import "CouponViewController.h"
#import "BalanceViewController.h"
#import "AboutModel.h"
#import "MyMembershipCardViewController.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "ShareModel.h"
#import "FeedbackViewController.h"

#define kUmengAppkey @"586e0429c62dca606900044f"
#define kSignBtnWidth 60*kRate
#define kEdgeWidth    (kScreenWidth - 60*kRate*5)/6

@interface AboutViewController ()<UITableViewDelegate, UITableViewDataSource, UMSocialUIDelegate>
{
    UIScrollView *_scrollView;//滑动视图（所有的控件都加在这上面）
    
    //第一块内容
    UIView *_up_bgView;
    UIButton *_signInBtn;
    CardAndCarView *_cardView;
    CardAndCarView *_carView;
    
    //第二块内容
    UIView *_secondView;
    //第三块内容
    UITableView *_tableView;
}
@property (nonatomic, assign)BOOL isSigned;//是否已签到
@property (nonatomic, strong)ShareModel *shareModel;
@end

@implementation AboutViewController

- (instancetype)init
{
    if (self = [super init]) {
        
        //网络请求用户数据
        [self getUserInfo];
        
        //网络请求分享数据
        [self getShareInfo];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];//滑动视图的可视范围
    _scrollView.backgroundColor = kRGBColor(234, 238, 239);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(kScreenWidth, 800);
    [self.view addSubview:_scrollView];
    
    //第一块内容（个人信息，签到按钮，优惠券、爱车）
    [self addFirsrContent];
    
    //第二块内容（订单信息）
    [self addSecondContent];
    
    //第三块内容（表视图）
    [self addTableView];
}

#pragma mark ***************   第一块内容（个人信息，签到按钮，优惠券、爱车）   **************
- (void)addFirsrContent
{
    //上面的积分、头像、姓名、余额
    [self addFirstUp];
    
    //下面的优惠券和我的爱车
    [self addFirstDown];
    
    //中间的签到按钮
    [self addFirstMedium];
}

//上面的积分、头像、姓名、余额
- (void)addFirstUp
{
    _up_bgView
    = [[UIView alloc] initWithFrame:CGRectMake(0, -20, kScreenWidth, 200*kRate)];
    _up_bgView.backgroundColor = kRGBColor(22, 129, 251);
    [_scrollView addSubview:_up_bgView];
    
    //积分
    UILabel *pointsLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 100*kRate, 30*kRate, 80*kRate, 20*kRate)];
    pointsLabel.text = [NSString stringWithFormat:@"积分：%@", [[self getLocalDic] objectForKey:@"score"]];
    pointsLabel.textColor = [UIColor whiteColor];
    pointsLabel.font = [UIFont systemFontOfSize:14.0*kRate];
    [_up_bgView addSubview:pointsLabel];
    
    //头像
    UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 30*kRate, CGRectGetMaxY(pointsLabel.frame), 70*kRate, 70*kRate)];
    headImgView.image = [UIImage imageNamed:@"about_first_head"];
    [_up_bgView addSubview:headImgView];
    
    
    
    //账号
    UILabel *accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 75*kRate, CGRectGetMaxY(headImgView.frame)+10*kRate, 150*kRate, 20*kRate)];
    accountLabel.text = [NSString stringWithFormat:@"%@%@", [[self getLocalDic] objectForKey:@"realname"], [[self getLocalDic] objectForKey:@"phone"]];
    accountLabel.textColor = [UIColor whiteColor];
    accountLabel.textAlignment = NSTextAlignmentCenter;
    accountLabel.font = [UIFont systemFontOfSize:14.0*kRate];
    [_up_bgView addSubview:accountLabel];
    
    
    //余额
    UIButton *balanceBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 75*kRate, CGRectGetMaxY(accountLabel.frame), 150*kRate, 20*kRate)];
    [balanceBtn setTitle:[NSString stringWithFormat:@"余额：%@元", [[self getLocalDic] objectForKey:@"carbrand"]] forState:UIControlStateNormal];
    balanceBtn.titleLabel.textColor = [UIColor whiteColor];
    balanceBtn.titleLabel.font = [UIFont systemFontOfSize:14.0*kRate];
    [balanceBtn addTarget:self action:@selector(balanceBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_up_bgView addSubview:balanceBtn];
    
}

//中间的签到按钮
- (void)addFirstMedium
{
    _signInBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2 - kSignBtnWidth/2, CGRectGetMaxY(_up_bgView.frame) - kSignBtnWidth/2, kSignBtnWidth, kSignBtnWidth)];
    [_signInBtn setBackgroundImage:[UIImage imageNamed:@"about_first_circle"] forState:UIControlStateNormal];
    if (_isSigned) {
        [_signInBtn setTitle:@"已签到" forState:UIControlStateNormal];
    } else {
        [_signInBtn setTitle:@"签到" forState:UIControlStateNormal];
    }
    
    [_signInBtn setTitleColor:kRGBColor(0, 126, 255) forState:UIControlStateNormal];
    _signInBtn.titleLabel.font = [UIFont systemFontOfSize:14.0*kRate];
    [_signInBtn addTarget:self action:@selector(signInBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView insertSubview:_signInBtn aboveSubview:_carView];//确保无论怎么更新UI都不会使签到按钮被覆盖
}

//下面的优惠券和我的爱车
- (void)addFirstDown
{
    //优惠券
    _cardView = [[CardAndCarView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_up_bgView.frame), kScreenWidth/2 - 1, kScreenWidth*0.15)];
    _cardView.title = @"优惠券";
    _cardView.imgName = @"about_first_coupon";
    _cardView.subTitle = @"免洗券发放中";
    _cardView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_cardView];
    
    UITapGestureRecognizer *cardTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cardTapAction:)];
    [_cardView addGestureRecognizer:cardTap];
    
    //我的爱车
    _carView = [[CardAndCarView alloc] initWithFrame:CGRectMake(kScreenWidth/2, CGRectGetMinY(_cardView.frame), kScreenWidth/2, kScreenWidth*0.15)];
    _carView.title = @"我的爱车(11)";
    _carView.imgName = @"about_first_car";
    _carView.subTitle = [[self getLocalDic] objectForKey:@"carno"];
    _carView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_carView];
    
    UITapGestureRecognizer *carTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(carTapAction:)];
    [_carView addGestureRecognizer:carTap];
    
}

#pragma mark --- ButtonAction
- (void)balanceBtnAction
{
    NSLog(@"余额");
    
    BalanceViewController *balanceVC = [[BalanceViewController alloc] init];
    balanceVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:balanceVC animated:NO];
}

- (void)signInBtnAction
{
    NSLog(@"签到");
    
    [self sign];//签到的网络请求
    
    _signInBtn.alpha = 0;
    [UIView animateWithDuration:0.6 animations:^{
        [_signInBtn setTitle:@"已签到" forState:UIControlStateNormal];
        _signInBtn.alpha = 1;
    }];

}

- (void)cardTapAction:(UITapGestureRecognizer *)gesture
{
    NSLog(@"优惠券");
    
    CouponViewController *couponViewController = [[CouponViewController alloc] init];
    couponViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:couponViewController animated:NO];
    couponViewController.hidesBottomBarWhenPushed = NO;
}

- (void)carTapAction:(UITapGestureRecognizer *)gesture
{
    NSLog(@"我的爱车");
}


#pragma mark *********************   第二块内容（订单信息）   ********************
- (void)addSecondContent
{
    _secondView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_up_bgView.frame) + kScreenWidth*0.15 + 5*kRate, kScreenWidth, 96*kRate)];
    _secondView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_secondView];
    
    //第一行
          ///“我的订单”Label
    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(20*kRate, 10*kRate, 100*kRate, 20*kRate)];
    titleLB.text = @"我的订单";
    titleLB.font = [UIFont systemFontOfSize:16.0*kRate];
    titleLB.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    [_secondView addSubview:titleLB];
    
          ///“按订单类型查看”按钮
    UIButton *typeBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 130*kRate, 10*kRate, 110*kRate, 20*kRate)];
    [typeBtn setTitle:@"按订单类型查看>" forState:UIControlStateNormal];
    [typeBtn setTitleColor:[UIColor colorWithWhite:0.5 alpha:1] forState:UIControlStateNormal];
    typeBtn.titleLabel.font = [UIFont systemFontOfSize:13.0*kRate];
    [typeBtn addTarget:self action:@selector(typeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_secondView addSubview:typeBtn];
    
    
    
    //分割线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39*kRate, kScreenWidth, 1*kRate)];
    lineView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [_secondView addSubview:lineView];
    
    //第二行五个按钮
    [self addSecondFiveBtn];
}

//第二行五个按钮
- (void)addSecondFiveBtn
{
    //全部
    UIButton *allBtn = [[UIButton alloc] initWithFrame:CGRectMake(kEdgeWidth, 40*kRate, 60*kRate, 60*kRate)];
    [allBtn addTarget:self action:@selector(allBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [allBtn setImage:[UIImage imageNamed:@"about_second_all"] forState:UIControlStateNormal];
    allBtn.imageEdgeInsets = UIEdgeInsetsMake(10*kRate, 22.5*kRate, 30*kRate, 22.5*kRate);
    
    [allBtn setTitle:@"全部" forState:UIControlStateNormal];
    allBtn.titleLabel.font = [UIFont systemFontOfSize:13.0*kRate];
    [allBtn setTitleColor:[UIColor colorWithWhite:0.3 alpha:1] forState:UIControlStateNormal];
    allBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    allBtn.titleEdgeInsets = UIEdgeInsetsMake(25*kRate, -allBtn.titleLabel.bounds.size.width - 30, 0, 0);
    
    [_secondView addSubview:allBtn];
    
    //已预约
    UIButton *appointBtn = [[UIButton alloc] initWithFrame:CGRectMake(kEdgeWidth*2 + 60*kRate, 40*kRate, 60*kRate, 60*kRate)];
    [appointBtn addTarget:self action:@selector(appointBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [appointBtn setImage:[UIImage imageNamed:@"about_second_appoint"] forState:UIControlStateNormal];
    appointBtn.imageEdgeInsets = UIEdgeInsetsMake(10*kRate, 21.5*kRate, 30*kRate, 21.5*kRate);
    
    [appointBtn setTitle:@"已预约" forState:UIControlStateNormal];
    appointBtn.titleLabel.font = [UIFont systemFontOfSize:13.0*kRate];
    [appointBtn setTitleColor:[UIColor colorWithWhite:0.3 alpha:1] forState:UIControlStateNormal];
    appointBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    appointBtn.titleEdgeInsets = UIEdgeInsetsMake(25*kRate, -appointBtn.titleLabel.bounds.size.width - 40, 0, 0);
    
    [_secondView addSubview:appointBtn];
    
    //未完成
    UIButton *uncompletedBtn = [[UIButton alloc] initWithFrame:CGRectMake(kEdgeWidth*3 + 60*kRate*2, 40*kRate, 60*kRate, 60*kRate)];
    [uncompletedBtn addTarget:self action:@selector(uncompletedBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [uncompletedBtn setImage:[UIImage imageNamed:@"about_second_uncompleted.png"] forState:UIControlStateNormal];
    uncompletedBtn.imageEdgeInsets = UIEdgeInsetsMake(10*kRate, 21.5*kRate, 30*kRate, 21.5*kRate);
    
    [uncompletedBtn setTitle:@"未完成" forState:UIControlStateNormal];
    uncompletedBtn.titleLabel.font = [UIFont systemFontOfSize:13.0*kRate];
    [uncompletedBtn setTitleColor:[UIColor colorWithWhite:0.3 alpha:1] forState:UIControlStateNormal];
    uncompletedBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    uncompletedBtn.titleEdgeInsets = UIEdgeInsetsMake(25*kRate, -uncompletedBtn.titleLabel.bounds.size.width - 35, 0, 0);
    
    [_secondView addSubview:uncompletedBtn];
    
    //已完成
    UIButton *completedBtn = [[UIButton alloc] initWithFrame:CGRectMake(kEdgeWidth*4 + 60*kRate*3, 40*kRate, 60*kRate, 60*kRate)];
    [completedBtn addTarget:self action:@selector(unevaluatedBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [completedBtn setImage:[UIImage imageNamed:@"about_second_unevaluated"] forState:UIControlStateNormal];
    completedBtn.imageEdgeInsets = UIEdgeInsetsMake(10*kRate, 21.5*kRate, 30*kRate, 21.5*kRate);
    
    [completedBtn setTitle:@"已完成" forState:UIControlStateNormal];
    completedBtn.titleLabel.font = [UIFont systemFontOfSize:13.0*kRate];
    [completedBtn setTitleColor:[UIColor colorWithWhite:0.3 alpha:1] forState:UIControlStateNormal];
    completedBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    completedBtn.titleEdgeInsets = UIEdgeInsetsMake(25*kRate, -completedBtn.titleLabel.bounds.size.width - 45, 0, 0);
    
    [_secondView addSubview:completedBtn];
    
    //已评价
    UIButton *evaluatedBtn = [[UIButton alloc] initWithFrame:CGRectMake(kEdgeWidth*5 + 60*kRate*4, 40*kRate, 60*kRate, 60*kRate)];
    [evaluatedBtn addTarget:self action:@selector(completedBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [evaluatedBtn setImage:[UIImage imageNamed:@"about_second_completed"] forState:UIControlStateNormal];
    evaluatedBtn.imageEdgeInsets = UIEdgeInsetsMake(10*kRate, 22.5*kRate, 30*kRate, 22.5*kRate);
    
    [evaluatedBtn setTitle:@"已评价" forState:UIControlStateNormal];
    evaluatedBtn.titleLabel.font = [UIFont systemFontOfSize:13.0*kRate];
    [evaluatedBtn setTitleColor:[UIColor colorWithWhite:0.3 alpha:1] forState:UIControlStateNormal];
    evaluatedBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    evaluatedBtn.titleEdgeInsets = UIEdgeInsetsMake(25*kRate, -evaluatedBtn.titleLabel.bounds.size.width - 30, 0, 0);
    
    [_secondView addSubview:evaluatedBtn];
}

#pragma mark --- 第二块内容的各个按钮Action
- (void)typeBtnAction
{
    NSLog(@"按订单类型查看");
    
    OrderViewController *orderVC = [[OrderViewController alloc] init];
    orderVC.selectedNum = 0;
    [self.navigationController pushViewController:orderVC animated:NO];
}

- (void)allBtnAction
{
    NSLog(@"全部");
    
    OrderViewController *orderVC = [[OrderViewController alloc] init];
    orderVC.selectedNum = 0;
    [self.navigationController pushViewController:orderVC animated:NO];
}

- (void)appointBtnAction
{
    NSLog(@"已预约");
    
    OrderViewController *orderVC = [[OrderViewController alloc] init];
    orderVC.selectedNum = 1;
    [self.navigationController pushViewController:orderVC animated:NO];
}

- (void)uncompletedBtnAction
{
    NSLog(@"未完成");
    
    OrderViewController *orderVC = [[OrderViewController alloc] init];
    orderVC.selectedNum = 2;
    [self.navigationController pushViewController:orderVC animated:NO];
}

- (void)unevaluatedBtnAction
{
    NSLog(@"待评价");
    
    OrderViewController *orderVC = [[OrderViewController alloc] init];
    orderVC.selectedNum = 3;
    [self.navigationController pushViewController:orderVC animated:NO];
}

- (void)completedBtnAction
{
    NSLog(@"已完成");
    
    OrderViewController *orderVC = [[OrderViewController alloc] init];
    orderVC.selectedNum = 4;
    [self.navigationController pushViewController:orderVC animated:NO];
}


#pragma mark *********************   第三块内容（表视图）   ********************
- (void)addTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_secondView.frame) + 5, kScreenWidth, 610) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;//表视图不能滑动
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.backgroundColor = kRGBColor(232, 233, 234);
    [_scrollView addSubview:_tableView];

}

#pragma mark ----UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 3) {
        return 1;
    } else {
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    
    AboutCell *cell = (AboutCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    NSArray *leftImgNames = [NSArray arrayWithObjects:@"about_tableview_coupon", @"about_tableview_points", @"about_tableview_fuelCard", @"about_tableview_insurance", @"about_tableview_friends", @"about_tableview_sellCard", @"about_tableview_feedback", @"about_tableview_experiance", @"about_tableview_service", @"about_tableview_membership", nil];
    NSArray *mediumNames = [NSArray arrayWithObjects:@"我的汽车券", @"积分兑换", @"加油卡充值记录", @"保险订单", @"邀请好友", @"我要卖卡", @"意见反馈", @"赠送体验券", @"在线客服", @"我的会员卡", nil];
    
    if (cell == nil) {
        cell = [[AboutCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        
        cell.leftImgName = leftImgNames[indexPath.row];
        cell.mediumName = mediumNames[indexPath.row];
        cell.rightArrowName = @"rightArrow";
        
    }else if (indexPath.section == 1) {
        
        cell.leftImgName = leftImgNames[indexPath.row + 3];
        cell.mediumName = mediumNames[indexPath.row + 3];
        cell.rightArrowName = @"rightArrow";
        
    }else if (indexPath.section == 2) {
        
        cell.leftImgName = leftImgNames[indexPath.row + 6];
        cell.mediumName = mediumNames[indexPath.row + 6];
        cell.rightArrowName = @"rightArrow";
        
    }
    else {
        cell.leftImgName = leftImgNames[indexPath.row + 9];
        cell.mediumName = mediumNames[indexPath.row + 9];
        cell.rightArrowName = @"rightArrow";
        
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40*kRate;
}

   ///选中单元格后采取的操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            NSLog(@"我的汽车券");
            CarCouponVC *carCouponVC = [[CarCouponVC alloc] init];
            carCouponVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:carCouponVC animated:NO];
            carCouponVC.hidesBottomBarWhenPushed = NO;
            
        } else if (indexPath.row == 1) {
            
            NSLog(@"积分兑换");
            ExchangePointsVC *exchangePointsVC = [[ExchangePointsVC alloc] init];
            exchangePointsVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:exchangePointsVC animated:NO];
            exchangePointsVC.hidesBottomBarWhenPushed = NO;
            
        } else {
            
            NSLog(@"加油卡充值记录");
            
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            
            NSLog(@"保险订单");
            
        } else if (indexPath.row == 1) {
            
            NSLog(@"邀请好友");
            [self setShare];
            
        } else {
            
            NSLog(@"我要卖卡");
            SellCardVC *sellCardVC = [[SellCardVC alloc] init];
            sellCardVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:sellCardVC animated:NO];
            self.hidesBottomBarWhenPushed = NO;
            
        }
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            
            NSLog(@"意见反馈");
    
            FeedbackViewController *feedbackVC = [[FeedbackViewController alloc] init];
            feedbackVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:feedbackVC animated:NO];
            
        } else if (indexPath.row == 1) {
            
            NSLog(@"赠送体验券");
            FreeExperienceVoucherVC *freeExperienceVoucherVC = [[FreeExperienceVoucherVC alloc] init];
            freeExperienceVoucherVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:freeExperienceVoucherVC animated:NO];
            freeExperienceVoucherVC.hidesBottomBarWhenPushed = NO;
            
        } else {
            
            NSLog(@"在线客服");
        }
    } else {
        
        NSLog(@"我的会员卡");
        
        MyMembershipCardViewController *myMembershipCardVC = [[MyMembershipCardViewController alloc] init];
        myMembershipCardVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myMembershipCardVC animated:NO];
        myMembershipCardVC.hidesBottomBarWhenPushed = NO;
        
    }
    
}

///session之间的距离
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    } else {
        return 5;
    }
}



#pragma mark 以下代码的作用是：让导航栏和状态栏在该页面不显示出来，然后跳转到其他页面的时候显示导航栏和状态栏
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

#pragma mark
#pragma mark 邀请好友，分享管家婆
- (void)setShare
{
    /*
     要分享的标题title
     */
    [UMSocialData defaultData].extConfig.title = _shareModel.shareTitle;
    
    
    /*
     当分享消息类型为图文时，点击分享内容会跳转到预设的链接（注意设置的链接必须为http或https链接）
     */
    [UMSocialData defaultData].extConfig.wechatSessionData.url = _shareModel.shareLink;//微信好友
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = _shareModel.shareLink;//微信朋友圈
    [UMSocialData defaultData].extConfig.qqData.url = _shareModel.shareLink;//QQ好友
    [UMSocialData defaultData].extConfig.qzoneData.url = _shareModel.shareLink;//QQ空间
    
    
    /*
     分享的内容
     */
    //作如下判断主要是为了防止获取不到网络图片时导致分享链接失效（图文类型时链接才生效，没有图片就不是图文类型）
    if (_shareModel.shareImg) {
        
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:kUmengAppkey
                                          shareText:_shareModel.shareContent//要分享的文字
                                         shareImage:_shareModel.shareImg//要分享的图片.
                                    shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone]//要分享到的平台。分享面板中各个分享平台的排列顺序是按照这里的顺序的。
                                           delegate:self];
        
    } else {
        
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:kUmengAppkey
                                          shareText:_shareModel.shareContent//要分享的文字
                                         shareImage:[UIImage imageNamed:@"icon83.5@2x"]//要分享的图片.
                                    shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone]//要分享到的平台。分享面板中各个分享平台的排列顺序是按照这里的顺序的。
                                           delegate:self];
        
    }
}

//分享成功并且返回客户端后回调的方法（如果留在分享到的平台如QQ,那么不会回调该方法）
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的平台名（即分享到哪个平台了）
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

#pragma mark
#pragma mark 网络请求
//根据uid获取用户数据
- (void)getUserInfo
{
    NSString *url_post = [NSString stringWithFormat:@"http://%@getUserByUid.action", kHead];
    
    NSDictionary *params = @{
                             @"uid":[[self getLocalDic] objectForKey:@"uid"],
                             };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer = responseSerializer;
    
    [manager POST:url_post parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //NSLog(@"getUserByUid.action:%@", content);
        
        NSDictionary *jsonDataDic = [content objectForKey:@"jsondata"];
        
            //最近一次签到的时间
        NSString *signTimeStr = [jsonDataDic objectForKey:@"sign"];
        NSString *signDateStr = [signTimeStr substringToIndex:10];
        
            //当前的系统时间
        NSDate *currentTime = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *currentTimeStr = [formatter stringFromDate:currentTime];
        NSString *currentDateStr = [currentTimeStr substringToIndex:10];
        
        if ([signDateStr isEqualToString:currentDateStr]) {
            _isSigned = YES;//签到状态
        }
        
        //更新缓存的数据
        [self saveDataToPlistWithDic:jsonDataDic];
        
        //更新UI(UI所需的数据是从缓存中取出来的，所以先更新缓存)
        [self updateUI];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败， 失败原因是：%@", error);
    }];

}

//签到
- (void)sign
{
    NSString *url_post = [NSString stringWithFormat:@"http://%@sign.action", kHead];
    
    NSDictionary *params = @{
                             @"uid":[[self getLocalDic] objectForKey:@"uid"],
                             };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer = responseSerializer;
    
    [manager POST:url_post parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSString *result = [content objectForKey:@"result"];
        
        if ([result isEqualToString:@"success"]) {
            
            //签到成功后，重新请求数据并保存到本地，然后更新UI
            [self getUserInfo];
            
        } else {
            
            //弹出提示框
            NSString *errorMsg = [content objectForKey:@"errMsg"];
            [self showAlertViewWithTitle:@"提示" WithMessage:errorMsg];
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败， 失败原因是：%@", error);
    }];

    
}
//更新UI
- (void)updateUI
{
    [_up_bgView removeFromSuperview];
    [self addFirstUp];
    
    [_cardView removeFromSuperview];
    [_carView removeFromSuperview];
    [self addFirstDown];
    
    [_signInBtn removeFromSuperview];
    [self addFirstMedium];
}

//更新缓存的数据
- (void)saveDataToPlistWithDic:(NSDictionary *)contentDic
{
    //将请求下来的数据中的data对应的字典保存到沙盒的自己创建的plist文件中
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"my.plist"];
    [contentDic  writeToFile:filename atomically:YES];
}

#pragma mark --- 请求分享数据
- (void)getShareInfo
{
    NSString *url_get = [NSString stringWithFormat:@"http://%@getShareInfo.action", kHead];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];//单例
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:url_get parameters:nil progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *jsondataDic = [responseObject objectForKey:@"jsondata"];
        _shareModel = [[ShareModel alloc] initWithDic:jsondataDic];
        
    } failure:nil];
}
@end
