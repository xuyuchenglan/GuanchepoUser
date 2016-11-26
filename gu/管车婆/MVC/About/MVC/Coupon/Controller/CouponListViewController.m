//
//  CouponListViewController.m
//  管车婆
//
//  Created by 李伟 on 16/11/10.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "CouponListViewController.h"
#import "LWCouponCell.h"

#define kCellWidth (kScreenWidth - 10*kRate*2)

@interface CouponListViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
}
@end

@implementation CouponListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, kScreenHeight - 64 - 10*kRate - 45*kRate)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [_tableView setSeparatorColor:[UIColor clearColor]];//去除单元格之间的分割线
    _tableView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
}

#pragma mark UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"LWCouponCell";
    
    LWCouponCell *cell = (LWCouponCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[LWCouponCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (indexPath.row == 0) {
        cell.type = @"jianmianquan";
    } else if (indexPath.row == 1) {
        cell.type = @"dazhequan";
    } else {
        cell.type = @"tiyanquan";
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (kCellWidth*0.289+15*kRate);
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
