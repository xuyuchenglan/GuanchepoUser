//
//  FillInPersonalInfoVC.m
//  管车婆
//
//  Created by 李伟 on 17/1/18.
//  Copyright © 2017年 远恒网络科技有限公司. All rights reserved.
//

#import "FillInPersonalInfoVC.h"
#import "FillInPersonalInfoCell.h"

@interface FillInPersonalInfoVC ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
}
@end

@implementation FillInPersonalInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //配置导航栏
    [self SetNav];
    
    //配置下面的内容视图
    [self addContentView];
}

#pragma mark *** 配置导航栏 ***
- (void)SetNav
{
    //隐藏返回按钮
    [self.navigationItem setHidesBackButton:YES];
    
    
    //标题
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-90*kRate,20*kRate,180*kRate,44*kRate)];
    titleLabel.text = @"绑定会员卡";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];  //设置Label背景透明
    titleLabel.font            = [UIFont boldSystemFontOfSize:18*kRate];  //设置文本字体与大小
    titleLabel.textAlignment   = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;

    
    //“暂不完善”按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(kScreenWidth - 120*kRate, 30*kRate, 80*kRate, 16.2*kRate);
    [btn setTitle:@"暂不完善" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16*kRate];
    [btn addTarget: self action: @selector(btnAction) forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = back;
}

- (void)btnAction
{
    NSLog(@"暂不完善");
    
    [self.navigationController popViewControllerAnimated:NO];
}


#pragma mark *** 配置下面的内容视图 ***
- (void)addContentView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark --- UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger number = 0;
    
    if (section == 0) {
        number = 3;
    }else if (section == 1){
        number = 6;
    }else if (section == 2){
        number = 2;
    }

    return number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"FillInPersonalInfoCell";
    
    FillInPersonalInfoCell *fillInPersonalInfoCell = (FillInPersonalInfoCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    NSArray *leftNames = [NSArray arrayWithObjects:@"姓名", @"手机号", @"身份证号", @"品牌", @"车牌号", @"排量-年份", @"销售年款", @"新车上路时间", @"行驶里程", @"车辆类型", @"查询城市", nil];
    
    if (fillInPersonalInfoCell == nil) {
        
        fillInPersonalInfoCell = [[FillInPersonalInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (indexPath.section == 0) {
        
        fillInPersonalInfoCell.leftName = leftNames[indexPath.row];
        
    }else if (indexPath.section == 1) {
        
        fillInPersonalInfoCell.leftName = leftNames[indexPath.row + 3];
        
    } else {
        
        fillInPersonalInfoCell.leftName = leftNames[indexPath.row + 9];
        
    }
    
    fillInPersonalInfoCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return fillInPersonalInfoCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40*kRate;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(20*kRate, 0, kScreenWidth, 30*kRate)];
    
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    headerLabel.highlightedTextColor = [UIColor whiteColor];
    headerLabel.font = [UIFont systemFontOfSize:20*kRate];
    headerLabel.frame = CGRectMake(20*kRate, 0, kScreenWidth, 30*kRate);
    
    if (section == 0) {
        headerLabel.text =  @"个人资料";
    }else if (section == 1){
        headerLabel.text = @"爱车信息";
    }else if (section == 2){
        headerLabel.text = @"以下为查询违章专用";
    }
    
    [customView addSubview:headerLabel];
    
    return customView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30*kRate;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld,%ld", (long)indexPath.section, (long)indexPath.row);
}

@end
