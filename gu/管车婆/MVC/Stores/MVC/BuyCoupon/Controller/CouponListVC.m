//
//  CouponListVC.m
//  管车婆
//
//  Created by 李伟 on 16/10/24.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "CouponListVC.h"
#import "CouponCell.h"
#import "CouponModel.h"

@interface CouponListVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}
@end

@implementation CouponListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10*kRate, kScreenWidth, kScreenHeight - 64 - 280*kRate)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [_tableView setSeparatorColor:[UIColor clearColor]];//去除单元格之间的分割线
    _tableView.backgroundColor = kRGBColor(233, 233, 233);
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    
    
}

#pragma mark UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _couponModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CouponCell";
    
    CouponCell *cell = (CouponCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[CouponCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (_couponModels.count  > indexPath.row) {
        cell.couponModel = _couponModels[indexPath.row];
    }
    
    cell.storeModel = _storeModel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100*kRate;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //选中单元格时高亮显示，交互完成之后移除高亮显示。
    [self performSelector:@selector(unselectCell:) withObject:nil afterDelay:0.3];//0.3秒后取消单元格选中状态。
}

-(void)unselectCell:(id)sender{
    
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:YES];
}





@end
