//
//  IllegalResultVC.m
//  管车婆
//
//  Created by 李伟 on 16/10/9.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "IllegalResultVC.h"
#import "IllegalResultAccountView.h"
#import "IllegalCell.h"

@interface IllegalResultVC ()<UITableViewDelegate, UITableViewDataSource>
{
    UIScrollView *_scrollView;
    UIView       *_accountView;
    UITableView  *_tableView;
    UIView       *_paymentView;
}
@end

@implementation IllegalResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self addNavBar];
    
    //设置下面的内容
    [self addContentView];
    
}

#pragma mark *************   设置导航栏   *********************
- (void)addNavBar
{
    [self setNavigationItemTitle:@"违章结果"];
    
    [self setBackButtonWithImageName:@"back"];
}

#pragma mark ************   设置下面的内容   *************
- (void)addContentView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _scrollView.backgroundColor = [UIColor colorWithRed:233/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    [self.view addSubview:_scrollView];
    
    //总违章数、扣分数以及需缴纳罚款数
    [self addAccountView];
    
    //违章列表
    [self addTableView];
    
    //违章缴费
    [self addPaymentView];
}

#pragma mark --- <一>总违章数、扣分数以及需缴纳罚款数

- (void)addAccountView
{
    _accountView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, kScreenWidth, 80*kRate)];
    _accountView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_accountView];
    
    
    //未处理的违章
    IllegalResultAccountView *resultView1 = [[IllegalResultAccountView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/3, 80*kRate)];
    resultView1.title = @"未处理的违章";
    resultView1.account = @"6";
    [_accountView addSubview:resultView1];
    
    //违章扣分
    IllegalResultAccountView *resultView2 = [[IllegalResultAccountView alloc] initWithFrame:CGRectMake(kScreenWidth/3, 0, kScreenWidth/3, 80*kRate)];
    resultView2.title = @"违章扣分";
    resultView2.account = @"11";
    [_accountView addSubview:resultView2];
    
    //需交罚款
    IllegalResultAccountView *resultView3 = [[IllegalResultAccountView alloc] initWithFrame:CGRectMake(kScreenWidth/3*2, 0, kScreenWidth/3, 80*kRate)];
    resultView3.title = @"需交罚款";
    resultView3.account = @"¥800";
    [_accountView addSubview:resultView3];
    
}


#pragma mark --- <三>违章缴费

- (void)addPaymentView
{
    _paymentView = [[UIView alloc] init];
    _paymentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_paymentView];
    [_paymentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 80*kRate));
        make.left.equalTo(self.view).with.offset(0);
        make.bottom.equalTo(self.view).with.offset(0);
    }];
    
    //显示几个违章、共多少罚款的label
    [self addresultLabel];
    
    //去缴费按钮
    [self addGotoPayBtn];
    
    }

 //显示几个违章、共多少罚款的label
- (void)addresultLabel
{
    UILabel *resultLB = [[UILabel alloc] init];
    resultLB.adjustsFontSizeToFitWidth = YES;
    resultLB.font = [UIFont systemFontOfSize:15.0*kRate];
    [_paymentView addSubview:resultLB];
    [resultLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 30*kRate - 100*kRate - 30*kRate - 10*kRate, 40*kRate));
        make.top.equalTo(_paymentView).with.offset(20*kRate);
        make.left.equalTo(_paymentView).with.offset(30*kRate);
    }];
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:@"3个违章共计¥888代缴罚款"];
    NSUInteger startLoc = [[attributedStr string] rangeOfString:@"计"].location + 1;
    NSUInteger endLoc = [[attributedStr string] rangeOfString:@"代"].location;
    NSRange blueRange = NSMakeRange(startLoc, endLoc - startLoc);
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:22/255.0 green:129/255.0 blue:251/255.0 alpha:1] range:blueRange];
    [resultLB setAttributedText:attributedStr];

}

 //去缴费按钮
- (void)addGotoPayBtn
{
    UIButton *goToPayBtn = [[UIButton alloc] init];
    goToPayBtn.backgroundColor = [UIColor colorWithRed:22/255.0 green:129/255.0 blue:251/255.0 alpha:1];
    goToPayBtn.titleLabel.font = [UIFont systemFontOfSize:18.0*kRate];
    [goToPayBtn setTitle:@"去缴费" forState:UIControlStateNormal];
    goToPayBtn.layer.cornerRadius = 8.0*kRate;
    [_paymentView addSubview:goToPayBtn];
    [goToPayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*kRate, 40*kRate));
        make.right.equalTo(_paymentView).with.offset(-30*kRate);
        make.top.equalTo(_paymentView).with.offset(20*kRate);
    }];

}

#pragma mark --- <二>违章列表

- (void)addTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_accountView.frame) + 16*kRate, kScreenWidth, kScreenHeight - CGRectGetMaxY(_accountView.frame) - 16*kRate - 80*kRate)];
    _tableView.backgroundColor = [UIColor colorWithRed:233/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}

#pragma mark --------- UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *illegalCellID = @"illegalCellID";
    
    IllegalCell *illegalCell = (IllegalCell *)[tableView dequeueReusableCellWithIdentifier:illegalCellID];
    
    if (!illegalCell ) {
        illegalCell = [[IllegalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:illegalCellID];
    }
    
    illegalCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return illegalCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150.0*kRate;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}





@end
