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

#define kSignBtnWidth 60*kRate
#define kEdgeWidth    (kScreenWidth - 60*kRate*5)/6

@interface AboutViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UIScrollView *_scrollView;//滑动视图（所有的控件都加在这上面）
    
    //第一块内容
    UIView *_up_bgView;
    //第二块内容
    UIView *_secondView;
    //第三块内容
    UITableView *_tableView;

    
}
@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];//滑动视图的可视范围
    _scrollView.backgroundColor = [UIColor colorWithRed:234/255.0 green:238/255.0 blue:239/255.0 alpha:1];
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
    _up_bgView.backgroundColor = [UIColor colorWithRed:22/255.0 green:129/255.0 blue:251/255.0 alpha:1];
    [_scrollView addSubview:_up_bgView];
    
    //积分
    UILabel *pointsLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 100*kRate, 30*kRate, 80*kRate, 20*kRate)];
    pointsLabel.text = @"积分：188";
    pointsLabel.textColor = [UIColor whiteColor];
    pointsLabel.font = [UIFont systemFontOfSize:14.0*kRate];
    [_up_bgView addSubview:pointsLabel];
    
    //头像
    UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 30*kRate, CGRectGetMaxY(pointsLabel.frame), 70*kRate, 70*kRate)];
    headImgView.image = [UIImage imageNamed:@"about_first_head"];
    [_up_bgView addSubview:headImgView];
    
    
    
    //账号
    UILabel *accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 75*kRate, CGRectGetMaxY(headImgView.frame)+10*kRate, 150*kRate, 20*kRate)];
    accountLabel.text = @"王一旭18653400191";
    accountLabel.textColor = [UIColor whiteColor];
    accountLabel.textAlignment = NSTextAlignmentCenter;
    accountLabel.font = [UIFont systemFontOfSize:14.0*kRate];
    [_up_bgView addSubview:accountLabel];
    
    
    //余额
    UIButton *balanceBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 75*kRate, CGRectGetMaxY(accountLabel.frame), 150*kRate, 20*kRate)];
    [balanceBtn setTitle:@"余额：100元" forState:UIControlStateNormal];
    balanceBtn.titleLabel.textColor = [UIColor whiteColor];
    balanceBtn.titleLabel.font = [UIFont systemFontOfSize:14.0*kRate];
    [balanceBtn addTarget:self action:@selector(balanceBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_up_bgView addSubview:balanceBtn];
    
}

//中间的签到按钮
- (void)addFirstMedium
{
    UIButton *signInBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2 - kSignBtnWidth/2, CGRectGetMaxY(_up_bgView.frame) - kSignBtnWidth/2, kSignBtnWidth, kSignBtnWidth)];
    [signInBtn setBackgroundImage:[UIImage imageNamed:@"about_first_circle"] forState:UIControlStateNormal];
    [signInBtn setTitle:@"签到" forState:UIControlStateNormal];
    [signInBtn setTitleColor:[UIColor colorWithRed:0 green:126/255.0 blue:1 alpha:1] forState:UIControlStateNormal];
    signInBtn.titleLabel.font = [UIFont systemFontOfSize:14.0*kRate];
    [signInBtn addTarget:self action:@selector(signInBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:signInBtn];
}

//下面的优惠券和我的爱车
- (void)addFirstDown
{
    //优惠券
    CardAndCarView *cardView = [[CardAndCarView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_up_bgView.frame), kScreenWidth/2 - 1, kScreenWidth*0.15)];
    cardView.title = @"优惠券";
    cardView.imgName = @"about_first_coupon";
    cardView.subTitle = @"免洗券发放中";
    cardView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:cardView];
    
    UITapGestureRecognizer *cardTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cardTapAction:)];
    [cardView addGestureRecognizer:cardTap];
    
    //我的爱车
    CardAndCarView *carView = [[CardAndCarView alloc] initWithFrame:CGRectMake(kScreenWidth/2, CGRectGetMinY(cardView.frame), kScreenWidth/2, kScreenWidth*0.15)];
    carView.title = @"我的爱车(11)";
    carView.imgName = @"about_first_car";
    carView.subTitle = @"鲁N12345";
    carView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:carView];
    
    UITapGestureRecognizer *carTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(carTapAction:)];
    [carView addGestureRecognizer:carTap];
    
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
    
    //待评价
    UIButton *unevaluatedBtn = [[UIButton alloc] initWithFrame:CGRectMake(kEdgeWidth*4 + 60*kRate*3, 40*kRate, 60*kRate, 60*kRate)];
    [unevaluatedBtn addTarget:self action:@selector(unevaluatedBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [unevaluatedBtn setImage:[UIImage imageNamed:@"about_second_unevaluated"] forState:UIControlStateNormal];
    unevaluatedBtn.imageEdgeInsets = UIEdgeInsetsMake(10*kRate, 21.5*kRate, 30*kRate, 21.5*kRate);
    
    [unevaluatedBtn setTitle:@"待评价" forState:UIControlStateNormal];
    unevaluatedBtn.titleLabel.font = [UIFont systemFontOfSize:13.0*kRate];
    [unevaluatedBtn setTitleColor:[UIColor colorWithWhite:0.3 alpha:1] forState:UIControlStateNormal];
    unevaluatedBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    unevaluatedBtn.titleEdgeInsets = UIEdgeInsetsMake(25*kRate, -unevaluatedBtn.titleLabel.bounds.size.width - 45, 0, 0);
    
    [_secondView addSubview:unevaluatedBtn];
    
    //已完成
    UIButton *completedBtn = [[UIButton alloc] initWithFrame:CGRectMake(kEdgeWidth*5 + 60*kRate*4, 40*kRate, 60*kRate, 60*kRate)];
    [completedBtn addTarget:self action:@selector(completedBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [completedBtn setImage:[UIImage imageNamed:@"about_second_completed"] forState:UIControlStateNormal];
    completedBtn.imageEdgeInsets = UIEdgeInsetsMake(10*kRate, 22.5*kRate, 30*kRate, 22.5*kRate);
    
    [completedBtn setTitle:@"已完成" forState:UIControlStateNormal];
    completedBtn.titleLabel.font = [UIFont systemFontOfSize:13.0*kRate];
    [completedBtn setTitleColor:[UIColor colorWithWhite:0.3 alpha:1] forState:UIControlStateNormal];
    completedBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    completedBtn.titleEdgeInsets = UIEdgeInsetsMake(25*kRate, -completedBtn.titleLabel.bounds.size.width - 30, 0, 0);
    
    [_secondView addSubview:completedBtn];
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
    _tableView.backgroundColor = [UIColor colorWithRed:232/255.0 green:233/255.0 blue:234/255.0 alpha:1];
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

@end
