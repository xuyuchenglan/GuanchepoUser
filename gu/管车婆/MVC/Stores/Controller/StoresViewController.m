//
//  StoresViewController.m
//  管车婆
//
//  Created by 李伟 on 16/9/27.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "StoresViewController.h"
#import "StoresListVC.h"
#import "StoreServiceModel.h"

#define kDetailServeCellHeight 40*kRate

@interface StoresViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
}
@property (nonatomic, assign)long      currentBtnTag;
@property (nonatomic, strong)NSArray  *servesArr;//细分服务数组
@property (nonatomic, strong)NSString *selectedServe;//记录选中的服务
@property (nonatomic, copy)NSArray    *models;
@end

@implementation StoresViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //导航栏
    [self addNavBar];

//    //设置下面的同步滑动视图(请求门店列表数据成功以后再设置)
//    [self addSyncScrollView];
    
    //选择细分服务视图
    [self addDetailServeTableView];
    
    //网络请求门店列表数据
    [self getServices];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _tableView.hidden = YES;
}

#pragma mark ******************      导航栏      ****************
- (void)addNavBar
{
    //标题
    [self setNavigationItemTitle:@"附近商家"];
}



#pragma mark ******************  设置同步滑动视图  ****************
- (void)addSyncScrollView
{
    NSLog(@"设置同步滑动视图");
    
    StoreServiceModel *model1 = [_models[0] firstObject];
    StoreServiceModel *model2 = [_models[1] firstObject];
    StoreServiceModel *model3 = [_models[2] firstObject];
    StoreServiceModel *model4 = [_models[3] firstObject];
    
    //配置按钮标题数组
    self.titleArray = [NSArray arrayWithObjects:@"汽车服务", @"保养服务", @"汽车美容", @"其他服务", nil];
    
    //配置控制器数组(需要与上面的标题相对应)
    StoresListVC *carServiceVC = [[StoresListVC alloc] init];//汽车服务
    carServiceVC.vc = self;
    carServiceVC.type = @"0";
    carServiceVC.name = model1.name;
    carServiceVC.sid = model1.sid;//相应服务页面下默认选择的细分服务项目
    StoresListVC *maintenanceVC = [[StoresListVC alloc] init];//保养服务
    maintenanceVC.vc = self;
    maintenanceVC.type = @"1";
    maintenanceVC.name = model2.name;
    maintenanceVC.sid = model2.sid;
    StoresListVC *carBeautyVC = [[StoresListVC alloc] init];//汽车美容
    carBeautyVC.vc = self;
    carBeautyVC.type = @"2";
    carBeautyVC.name = model3.name;
    carBeautyVC.sid = model3.sid;
    StoresListVC *otherVC = [[StoresListVC alloc] init];//其他服务
    otherVC.vc = self;
    otherVC.type = @"3";
    otherVC.name = model4.name;
    otherVC.sid = model4.sid;
    self.controllerArray = [NSArray arrayWithObjects:carServiceVC, maintenanceVC, carBeautyVC, otherVC, nil];
}

#pragma mark ******************   复写父视图中展示选择细分服务的视图   ****************
- (void)addDetailServeTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 200)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    [self.view addSubview:_tableView];
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];//获取屏幕最上层窗口
    [window addSubview:_tableView];//让_tableView位于当前屏幕的最上层显示
    _tableView.hidden = YES;
    
    
}

- (void)selectDetailServeWithBtn:(UIButton *)btn
{
    long btnTag = btn.tag - 100;

    if (_currentBtnTag == btnTag) {
        _tableView.hidden = !_tableView.hidden;
    } else {
        _tableView.hidden = YES;
    }
    _currentBtnTag = (int)btnTag;

    
    if (!_tableView.hidden) {
        
        int index = (int)btnTag;
        _servesArr = _models[index];
        
        _tableView.frame = CGRectMake(0, 100, kScreenWidth, kDetailServeCellHeight*_servesArr.count);
        [_tableView reloadData];
    }
}

#pragma make --- UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _servesArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StoreServiceModel *currentModel = _servesArr[indexPath.row];
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    cell.textLabel.text = currentModel.name;
    cell.textLabel.font = [UIFont systemFontOfSize:15.0*kRate];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kDetailServeCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.hidden = YES;
    
    
    StoreServiceModel *currentModel = _servesArr[indexPath.row];
    
    _selectedServe = currentModel.name;
    
    NSString *sid = currentModel.sid;
    
    //给StoresListVC发送一个通知，让他改变topView上的显示内容.
    NSDictionary *infoDic = @{
                              @"type":[NSString stringWithFormat:@"%ld", _currentBtnTag],
                              @"selectedServe":_selectedServe,
                              @"sid":sid
                              };
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showSelectedServe" object:nil userInfo:infoDic];
}

#pragma mark
#pragma mark 网络请求
- (void)getServices
{
    NSString *url_get = [NSString stringWithFormat:@"http://%@getServicesBySType.action", kHead];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];//单例
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:url_get parameters:nil progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *arr1 = [responseObject objectForKey:@"1"];
        NSArray *arr2 = [responseObject objectForKey:@"2"];
        NSArray *arr3 = [responseObject objectForKey:@"3"];
        NSArray *arr4 = [responseObject objectForKey:@"4"];
        
        NSMutableArray *modelArr1 = [NSMutableArray array];
        NSMutableArray *modelArr2 = [NSMutableArray array];
        NSMutableArray *modelArr3 = [NSMutableArray array];
        NSMutableArray *modelArr4 = [NSMutableArray array];
        
        for (NSDictionary *dic in arr1) {
            StoreServiceModel *model = [[StoreServiceModel alloc] initWithDic:dic];
            [modelArr1 addObject:model];
        }
        
        for (NSDictionary *dic in arr2) {
            StoreServiceModel *model = [[StoreServiceModel alloc] initWithDic:dic];
            [modelArr2 addObject:model];
        }
        
        for (NSDictionary *dic in arr3) {
            StoreServiceModel *model = [[StoreServiceModel alloc] initWithDic:dic];
            [modelArr3 addObject:model];
        }
        
        for (NSDictionary *dic in arr4) {
            StoreServiceModel *model = [[StoreServiceModel alloc] initWithDic:dic];
            [modelArr4 addObject:model];
        }
        
        _models = [NSArray arrayWithObjects:modelArr1, modelArr2, modelArr3, modelArr4, nil];
        
        //刷新UI
        [_tableView reloadData];
        
        //设置下面的同步滑动视图(之所以在这里设置主要是为了设置一级服务的默认细分服务)
        [self addSyncScrollView];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败，原因是%@", error);
        
    }];

}

#pragma mark
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
