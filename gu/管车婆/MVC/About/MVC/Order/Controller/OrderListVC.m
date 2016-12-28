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
#import "OrderModel.h"
#import "LWAppointmentCell.h"
#import "UnconpletedOrderCell.h"

#define kTitleHeight 45*kRate

@interface OrderListVC ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
}
@property (nonatomic, strong)NSMutableArray *orderModels;
@end

@implementation OrderListVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _orderModels = [NSMutableArray array];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10*kRate, kScreenWidth, kScreenHeight - 64 - kTitleHeight - 49*kRate - 10*kRate)];
    _tableView.backgroundColor = [UIColor colorWithRed:234/255.0 green:238/255.0 blue:239/255.0 alpha:1];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
}

- (void)setType:(NSString *)type
{
    _type = type;
    
    if ([_type isEqualToString:@"0"] || [_type isEqualToString:@"1"]) {//监听取消预约时发送过来的通知,以刷新“全部”和“已预约”页面
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrder) name:@"cancelAppointment" object:nil];
    }
    
    //网络请求订单列表数据
    [self getOrder];
}

#pragma mark
#pragma mark UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _orderModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderModel *currentModel = _orderModels[indexPath.row];
    
    if (currentModel.appointTime_start.length > 0) {//预约订单
        
        static NSString *appointID = @"appointID";
        LWAppointmentCell *cell = (LWAppointmentCell *)[tableView dequeueReusableCellWithIdentifier:appointID];
        if (!cell) {
            cell = [[LWAppointmentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:appointID];
        }
        cell.orderModel = currentModel;
        cell.vc = _vc;
        
        return cell;
        
    } else {
        
        if ([currentModel.voucher isEqualToString:@"1"] && [currentModel.isVoucherUp isEqualToString:@"未上传"]) {//待传凭证
            
            static NSString *identify = @"uncompleted";
            UnconpletedOrderCell *cell = (UnconpletedOrderCell *)[tableView dequeueReusableCellWithIdentifier:identify];
            if (!cell) {
                cell = [[UnconpletedOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
            }
            cell.orderModel = currentModel;
            cell.vc = _vc;
            
            return cell;
            
        } else {
            
            static NSString *identify = @"ordercell";
            OrderCell *cell = (OrderCell *)[tableView dequeueReusableCellWithIdentifier:identify];
            if (!cell) {
                cell = [[OrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
            }
            cell.orderModel = currentModel;
            cell.vc = _vc;
            
            return cell;
            
        }
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderModel *currentModel = _orderModels[indexPath.row];
    return (120 + 20*currentModel.items.count + 5)*kRate;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderModel *currentModel = _orderModels[indexPath.row];
    
    OrderInfoVC *orderInfoVC = [[OrderInfoVC alloc] init];
    orderInfoVC.orderModel = currentModel;
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

#pragma mark
#pragma mark 网络请求订单列表数据
- (void)getOrder
{
    NSString *url_post = [NSString stringWithFormat:@"http://%@getOrder.action", kHead];
    
    NSDictionary *params = @{
                             @"uid":[[self getLocalDic] objectForKey:@"uid"],
                             @"type":_type,
                             @"currsize":@"0",
                             @"pagesize":@"20"
                             };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer = responseSerializer;
    
    [manager POST:url_post parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *jsondatArr = [content objectForKey:@"jsondata"];
        
        [_orderModels removeAllObjects];
        for (NSDictionary *dic in jsondatArr) {
            
            OrderModel *model = [[OrderModel alloc] initWithDic:dic];
            [_orderModels addObject:model];
            
        }
        
        //刷新UI
        [_tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败， 失败原因是：%@", error);
    }];
}

#pragma mark
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
