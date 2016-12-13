//
//  StoresViewController.m
//  管车婆
//
//  Created by 李伟 on 16/9/27.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "StoresViewController.h"
#import "StoresListVC.h"

#define kDetailServeCellHeight 40*kRate

@interface StoresViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
}
@property (nonatomic, assign)long      currentBtnTag;
@property (nonatomic, strong)NSArray  *servesArr;//细分服务数组
@property (nonatomic, strong)NSString *selectedServe;//记录选中的服务
@end

@implementation StoresViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //导航栏
    [self addNavBar];

    //设置下面的同步滑动视图
    [self addSyncScrollView];
    
    //选择细分服务视图
    [self addDetailServeTableView];
    
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
    
    //配置按钮标题数组
    self.titleArray = [NSArray arrayWithObjects:@"汽车服务", @"汽车美容", @"轮胎服务", @"保养服务", nil];
    
    //配置控制器数组(需要与上面的标题相对应)
    StoresListVC *carServiceVC = [[StoresListVC alloc] init];
    carServiceVC.type = @"0";//汽车服务
    StoresListVC *carBeautyVC = [[StoresListVC alloc] init];
    carBeautyVC.type = @"1";//汽车美容
    StoresListVC *tyreVC = [[StoresListVC alloc] init];
    tyreVC.type = @"2";//轮胎服务
    StoresListVC *mainTenanceVC = [[StoresListVC alloc] init];
    mainTenanceVC.type = @"3";//保养服务
    self.controllerArray = [NSArray arrayWithObjects:carServiceVC, carBeautyVC, tyreVC, mainTenanceVC, nil];
}

#pragma mark ******************   复写父视图中展示选择细分服务的视图   ****************
- (void)addDetailServeTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 200)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
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
        
        if (btnTag == 0) {
            _servesArr = [NSArray arrayWithObjects:@"洗车-1座", @"洗车-2座", @"洗车-3座", @"洗车-4座", @"洗车-5座", @"洗车-6座", nil];
        } else if (btnTag == 1) {
            _servesArr = [NSArray arrayWithObjects:@"汽车美容1", @"汽车美容2", @"汽车美容3", @"汽车美容4", @"汽车美容5", @"汽车美容6", @"汽车美容7", @"汽车美容8", nil];
        } else if (btnTag == 2) {
            _servesArr = [NSArray arrayWithObjects:@"轮胎服务1", @"轮胎服务2", @"轮胎服务3", @"轮胎服务4", @"轮胎服务5", @"轮胎服务6", @"轮胎服务7", nil];
        } else {
            _servesArr = [NSArray arrayWithObjects:@"保养服务1", @"保养服务2", @"保养服务3", @"保养服务4", @"保养服务5", @"保养服务6", nil];
        }

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
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    cell.textLabel.text = _servesArr[indexPath.row];
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
    
    UITableViewCell *currentCell = [tableView cellForRowAtIndexPath:indexPath];
    
    _selectedServe = currentCell.textLabel.text;
    
    //给StoresListVC发送一个通知，让他改变topView上的显示内容
    NSDictionary *infoDic = [NSDictionary dictionaryWithObjectsAndKeys:_selectedServe, @"selectedServe", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showSelectedServe" object:nil userInfo:infoDic];
}

#pragma mark
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
