//
//  OrderInfoVC.m
//  管车婆
//
//  Created by 李伟 on 16/10/22.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "OrderInfoVC.h"
#import "OrderContentInfoView.h"
#import "OrderContentMoreView.h"
#import "OrderStateView.h"
#import "AppointContentInfoView.h"
#import "VoucherModel.h"

#define kImgWidth (kScreenWidth - 30*kRate)

@interface OrderInfoVC ()
{
    UIView *_moreView;
    UIView *_infoView;
    UIView *_stateView;
    UIView *_voucherView;
}
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)NSMutableArray *voucherModels;
@end

@implementation OrderInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _voucherModels = [NSMutableArray array];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _scrollView.backgroundColor = [UIColor colorWithRed:248/255.0 green:249/255.0 blue:250/255.0 alpha:1];
    _scrollView.contentSize = CGSizeMake(kScreenWidth, 1000 + kImgWidth * 2);
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    //添加观察者，接收OrderStateView发送过来的通知,在上传凭证成功以后刷新UI以显示上传的凭证
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderDetail) name:@"reloadOrderInfoView" object:nil];
    
    //设置导航栏
    [self addNavBar];
    
    //设置下面的内容视图
    [self addContentView];
    
    //请求订单详情数据
    [self getOrderDetail];
}

#pragma mark ******   设置导航栏   ******
- (void)addNavBar
{
    [self setNavigationItemTitle:@"订单管理"];
    
    [self setBackButtonWithImageName:@"back"];
}


#pragma  mark *****************  设置下面的内容视图  ****************

- (void)addContentView
{
    //订单详情
    [self addMoreView];
    
    //订单信息
    [self addInfoView];
    
    //订单状态
    if (![_isAppoint isEqual:@"yes"]) {
        //订单状态
        [self addStateView];
    }
    
    if ([_orderModel.isVoucherUp isEqual:@"已上传"]) {
        //网络请求保养凭证
        [self getVoucherSessionRequest];
        
    }
    
}

//订单详情
- (void)addMoreView
{
    _moreView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 195*kRate)];
    [_scrollView addSubview:_moreView];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30*kRate, 10*kRate, kScreenWidth - 40*kRate, 20*kRate)];
    titleLabel.text = @"订单详情";
    titleLabel.font = [UIFont systemFontOfSize:15.0*kRate];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [_moreView addSubview:titleLabel];
    
    //内容
    OrderContentMoreView *contentView = [[OrderContentMoreView alloc] initWithFrame:CGRectMake(0, 40*kRate, kScreenWidth, 155*kRate)];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.orderModel = _orderModel;
    [_moreView addSubview:contentView];
}

//订单信息
- (void)addInfoView
{
    if ([_isAppoint isEqual:@"yes"]) {
        _infoView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_moreView.frame), kScreenWidth, 160*kRate)];
    } else {
        _infoView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_moreView.frame), kScreenWidth, 130*kRate)];
    }
    [_scrollView addSubview:_infoView];
    
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30*kRate, 10*kRate, kScreenWidth - 40*kRate, 20*kRate)];
    titleLabel.text = @"订单信息";
    titleLabel.font = [UIFont systemFontOfSize:15.0*kRate];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [_infoView addSubview:titleLabel];
    
    //内容
    if ([_isAppoint isEqual:@"yes"]) {
        AppointContentInfoView *contentView = [[AppointContentInfoView alloc] initWithFrame:CGRectMake(0, 40*kRate, kScreenWidth, 120*kRate)];
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.orderModel = _orderModel;
        [_infoView addSubview:contentView];
    } else {
        OrderContentInfoView *contentView = [[OrderContentInfoView alloc] initWithFrame:CGRectMake(0, 40*kRate, kScreenWidth, 90*kRate)];
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.orderModel = _orderModel;
        [_infoView addSubview:contentView];
    }
    
    
}

//订单状态
- (void)addStateView
{
    _stateView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_infoView.frame), kScreenWidth, 130*kRate)];
    [_scrollView addSubview:_stateView];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30*kRate, 10*kRate, kScreenWidth - 40*kRate, 20*kRate)];
    titleLabel.text = @"订单状态";
    titleLabel.font = [UIFont systemFontOfSize:15.0*kRate];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [_stateView addSubview:titleLabel];
    
    //内容
    OrderStateView *contentView = [[OrderStateView alloc] initWithFrame:CGRectMake(0, 40*kRate, kScreenWidth, 90*kRate)];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.orderModel = _orderModel;
    [_stateView addSubview:contentView];
}

//保养凭证
- (void)addVoucherView
{
    _voucherView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_stateView.frame), kScreenWidth, 200)];
    [_scrollView addSubview:_voucherView];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, kScreenWidth - 40, 20)];
    titleLabel.text = @"保养凭证";
    titleLabel.font = [UIFont systemFontOfSize:15.0];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [_voucherView addSubview:titleLabel];
    
    //内容
    if (_voucherModels.count > 0) {
        
        for (int i = 0; i < _voucherModels.count; i++) {
            
            VoucherModel *currentVoucherModel = (VoucherModel *)_voucherModels[i];
            UIImageView *contentView = [[UIImageView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(titleLabel.frame) + (kImgWidth + 10)*i + 10, kImgWidth, kImgWidth)];
            
            [contentView sd_setImageWithURL:currentVoucherModel.voucherUrl];
            [_voucherView addSubview:contentView];
            
            
        }
        
    }
    
}


#pragma mark
#pragma mark 网络请求
//网络请求保养凭证
- (void)getVoucherSessionRequest
{
    NSString *url_post = [NSString stringWithFormat:@"http://%@getOrderPz.action", kHead];
    
    NSDictionary *params = @{
                             @"oid":_orderModel.orderID
                             };
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = responseSerializer;
    
    [manager POST:url_post parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        [_voucherModels removeAllObjects];

        NSArray *jsondataArr = [content objectForKey:@"jsondata"];
        for (NSDictionary *picDic in jsondataArr) {
            VoucherModel *voucherModel = [[VoucherModel alloc] initWithDic:picDic];
            [_voucherModels addObject:voucherModel];
        }
        
        _scrollView.contentSize = CGSizeMake(kScreenWidth, 1000 + kImgWidth * _voucherModels.count);
        
        //添加VoucherView
        [self addVoucherView];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败， 失败原因是：%@", error);
    }];
    
}


//获取订单详情数据，刷新UI
- (void)getOrderDetail
{
    NSString *url_post = [NSString stringWithFormat:@"http://%@getOrderDetail.action", kHead];
    
    NSDictionary *params = @{
                             @"oid"     :  _orderModel.orderID
                             };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = responseSerializer;
    [manager POST:url_post parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *jsondataDic = [content objectForKey:@"jsondata"];
        NSLog(@"订单详情:%@", jsondataDic);
        
        _orderModel = [[OrderModel alloc] initWithDic:jsondataDic];

        //刷新UI
        [self updateOrderInfoView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败， 失败原因是：%@", error);
    }];
    
}

//刷新UI
- (void)updateOrderInfoView
{
    [_moreView removeFromSuperview];
    [_infoView removeFromSuperview];
    [_stateView removeFromSuperview];
    [_voucherView removeFromSuperview];
    
    [self addContentView];
}




#pragma mark
#pragma mark 移除观察者
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
