//
//  StoresListVC.m
//  管车婆
//
//  Created by 李伟 on 16/9/28.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "StoresListVC.h"
#import "StoreCell.h"
#import "StoreModel.h"

#define kHeadImgWidth kScreenWidth*2/7

@interface StoresListVC ()<UITableViewDelegate, UITableViewDataSource>
{
    UIView      *_topView;
    UITableView *_tableView;
    UILabel     *_carInfoLB;
}
//@property (nonatomic, strong)NSString *currentType;
@end

@implementation StoresListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置tableView上方的显示汽车信息的View
    [self addTopView];
    
    //设置tableView
    [self addTableView];
    
}

#pragma mark *************** 设置tableView上方的显示汽车信息的View *****************
- (void)addTopView
{
    //接收StoresViewController发送过来的通知，更新carInfoLB里的内容
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCarInfoLB:) name:@"showSelectedServe" object:nil];
    
    
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 35*kRate)];
    [self.view addSubview:_topView];
    
    _carInfoLB = [[UILabel alloc] initWithFrame:CGRectMake(20*kRate, 5*kRate, 100*kRate, 25*kRate)];
    _carInfoLB.font = [UIFont systemFontOfSize:14.0*kRate];
    _carInfoLB.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    _carInfoLB.text = @"洗车—5座";
    [_topView addSubview:_carInfoLB];
}

- (void)updateCarInfoLB:(NSNotification *)notification
{
    NSDictionary *selectedServeDic = [notification userInfo];
    _carInfoLB.text = [selectedServeDic objectForKey:@"selectedServe"];
    
//    NSLog(@"%@", [selectedServeDic objectForKey:@"type"]);
    
//    _currentType = [[selectedServeDic objectForKey:@"type"] string];
//    
//    NSLog(@"_currentType:%@,_type:%@", _currentType, _type);
    
//    if ([_currentType isEqualToString:_type]) {
//        _carInfoLB.text = [selectedServeDic objectForKey:@"selectedServe"];
//    } else {
//        
//    }
    
    
    
}

#pragma  mark *****************  设置tableView  ****************
- (void)addTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_topView.frame), kScreenWidth, kScreenHeight - 180*kRate)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [_tableView setSeparatorColor:[UIColor clearColor]];//去除单元格之间的分割线
    _tableView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    _tableView.allowsSelection = NO;
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
    static NSString *identifier = @"AppointmentCell";
    
    StoreCell *cell = (StoreCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    StoreModel *storeModel = [[StoreModel alloc] init];
    
    if (!cell) {
        cell = [[StoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.storeModel = storeModel;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kHeadImgWidth*0.85 + 10*2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark
//移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
