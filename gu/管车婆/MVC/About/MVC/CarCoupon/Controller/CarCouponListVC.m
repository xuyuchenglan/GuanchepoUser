//
//  CarCouponListVC.m
//  管车婆
//
//  Created by 李伟 on 16/11/3.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "CarCouponListVC.h"
#import "CarCouponCell.h"

@interface CarCouponListVC ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
}
@end

@implementation CarCouponListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = [UIColor colorWithRed:233/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    _tableView.tableFooterView = [UIView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, (kScreenHeight - 64 - 45 - 10)));
        make.left.equalTo(self.view).with.offset(0);
        make.top.equalTo(self.view).with.offset(10);
    }];
}

#pragma mark UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CarCouponCell";
    
    CarCouponCell *cell = (CarCouponCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[CarCouponCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    
    if ([_type isEqual:@"2"]) {
        cell.type = @"洗车券";
    } else if ([_type isEqual:@"3"]) {
        cell.type = @"保养券";
    } else if ([_type isEqual:@"4"]) {
        cell.type = @"美容券";
    } else {
        cell.type = @"洗车券";
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170*kRate;
}


@end
