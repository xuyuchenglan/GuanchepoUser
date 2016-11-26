//
//  ChangeFuelcardVC.m
//  管车婆
//
//  Created by 李伟 on 16/10/28.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "ChangeFuelcardVC.h"
#import "CardCell.h"
#import "AddFuelCardVC.h"

@interface ChangeFuelcardVC ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
}
@end

@implementation ChangeFuelcardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:233/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    
    //设置导航栏
    [self addNavBar];
    
    //设置下面的视图
    [self addContentView];
}


#pragma mark ****** 设置导航栏 ******
- (void)addNavBar
{
    [self setNavigationItemTitle:@"加油卡充值"];
    [self setBackButtonWithImageName:@"back"];
}


#pragma mark ****** 设置下面的视图 ******
- (void)addContentView
{
    //加油卡列表
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = [UIColor colorWithRed:233/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    _tableView.tableFooterView = [UIView new];
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 100*kRate * 3 + 64));
        make.top.equalTo(self.view).with.offset(10*kRate);
    }];
    
    //添加加油卡按钮
    UIButton *addFuelCardBtn = [[UIButton alloc] init];
    [addFuelCardBtn setTitle:@"添 加 加 油 卡" forState:UIControlStateNormal];
    addFuelCardBtn.layer.cornerRadius = 5.0*kRate;
    addFuelCardBtn.titleLabel.font = [UIFont systemFontOfSize:18.0*kRate];
    [addFuelCardBtn setBackgroundColor:[UIColor colorWithRed:22/255.0 green:129/255.0 blue:251/255.0 alpha:1]];
    [addFuelCardBtn addTarget:self action:@selector(addFuelCardBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addFuelCardBtn];
    [addFuelCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 60*kRate, 50*kRate));
        make.left.equalTo(self.view).with.offset(30*kRate);
        make.top.equalTo(_tableView.mas_bottom).with.offset(30*kRate);
    }];
    
}

#pragma mark ---UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cardcell";
    
    CardCell *cell = (CardCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[CardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100*kRate;
}

#pragma mark ---UIButtonAction
- (void)addFuelCardBtnAction
{
    AddFuelCardVC *addFuelcardVC = [[AddFuelCardVC alloc] init];
    addFuelcardVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addFuelcardVC animated:NO];
    addFuelcardVC.hidesBottomBarWhenPushed = NO;
}

@end
