//
//  ActivityViewController.m
//  管车婆
//
//  Created by 李伟 on 17/1/9.
//  Copyright © 2017年 远恒网络科技有限公司. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityModel.h"
#import "ActivityCell.h"
#import "ActivityInfoVC.h"


@interface ActivityViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UIView *_titleView;//类似导航栏的视图
    UITableView *_tableView;
}
@property (nonatomic, strong)NSMutableArray *activityModelsArr;

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    
    _activityModelsArr = [NSMutableArray array];
    
    //网络请求之活动数据
    [self activityDataSessionRequestWithIsRefresh:YES];
    
    //设置导航栏
    [self setNavigationBar];
    
    //设置下面的表视图
    [self addTableView];
    
}


#pragma  mark *****************  网络请求之活动数据  ****************
- (void)activityDataSessionRequestWithIsRefresh:(BOOL)isRefresh
{
    
    NSString *url_post = [NSString stringWithFormat:@"http://%@getActivity.action", kHead];
    
    NSDictionary *params = @{
                             @"currsize":@"0",
                             @"pagesize":@"10"
                             };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = responseSerializer;
    [manager POST:url_post parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [_activityModelsArr removeAllObjects];//清空所有数据，然后再重新获取
        
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSArray *jsonData = [content objectForKey:@"jsondata"];
        for (NSDictionary *dic in jsonData) {
            ActivityModel *activityModel = [[ActivityModel alloc] initWithDic:dic];
            [_activityModelsArr addObject:activityModel];
        }
        
        //刷新UI
        [_tableView reloadData];
        
        
    } failure:nil];
}

#pragma  mark *****************  设置导航栏  ****************
- (void)setNavigationBar
{
    [self setNavigationItemTitle:@"活动"];
    [self setBackButtonWithImageName:@"back"];
}


#pragma  mark *****************  添加表视图  ****************
- (void)addTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleView.frame), kScreenWidth, kScreenHeight - 80*kRate)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [_tableView setSeparatorColor:[UIColor clearColor]];//去除单元格之间的分割线
    _tableView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
}

#pragma mark ---- UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _activityModelsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"ActivityCell";
    
    ActivityCell *cell = (ActivityCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[ActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (_activityModelsArr.count > indexPath.row) {
        
        cell.activityModel = _activityModelsArr[indexPath.row];
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100*kRate;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityInfoVC *activdinfoVC = [[ActivityInfoVC alloc] init];
    if (_activityModelsArr.count>indexPath.row) {
        ActivityModel *currentActivityModel = _activityModelsArr[indexPath.row];
        activdinfoVC.linkUrl = currentActivityModel.linkUrl;
        activdinfoVC.titleStr = currentActivityModel.title;
    }
    [self.navigationController pushViewController:activdinfoVC animated:NO];
    
    //选中单元格时高亮显示，交互完成之后移除高亮显示。
    [self performSelector:@selector(unselectCell:) withObject:nil afterDelay:0.3];//0.3秒后取消单元格选中状态。
    
    
}

-(void)unselectCell:(id)sender{
    
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:YES];
}


#pragma mark
//移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
