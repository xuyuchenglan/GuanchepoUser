//
//  OrderListVC.m
//  管车婆
//
//  Created by 李伟 on 16/10/19.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "OrderListVC.h"
#import "OrderCell.h"
#import "OrderInfoVC.h"

#define kTitleHeight 45*kRate

@interface OrderListVC ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
}
@end

@implementation OrderListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10*kRate, kScreenWidth, kScreenHeight - 64 - kTitleHeight - 49*kRate - 10*kRate)];
    _tableView.backgroundColor = [UIColor colorWithRed:234/255.0 green:238/255.0 blue:239/255.0 alpha:1];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    
    
}

#pragma mark UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"ordercell";
    
    OrderCell *cell = (OrderCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (!cell) {
        
        cell = [[OrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (120 + 20*3 + 5)*kRate;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderInfoVC *orderInfoVC = [[OrderInfoVC alloc] init];
    if ([_type isEqual:@"1"]) {
        orderInfoVC.isAppoint = @"yes";
    }
    [[self findResponderVC].navigationController pushViewController:orderInfoVC animated:NO];
    
    
    //选中单元格时高亮显示，交互完成之后移除高亮显示。
    [self performSelector:@selector(unselectCell:) withObject:self afterDelay:0.3];//0.3秒后取消单元格选中状态。
}

- (void)unselectCell:(id)sender
{
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:YES];
}

/*
 *  由于self.navigationController为空，故调用push一点效果也没有，因此需要找到下一个控制器类型的响应者（本页面中是appointmentViewController）
 */
- (UIViewController *)findResponderVC
{
    UIResponder *responder_vc = (UIResponder *)self;
    do {
        responder_vc = responder_vc.nextResponder;
    } while (![responder_vc isKindOfClass:[UIViewController class]]);
    
    UIViewController *vc = (UIViewController *)responder_vc;
    
    return vc;
}


@end
