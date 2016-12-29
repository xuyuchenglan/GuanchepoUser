//
//  EnquiryWeatherVC.m
//  管车婆
//
//  Created by 李伟 on 16/10/8.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "EnquiryWeatherVC.h"
#import "WeathreModel.h"
#import "WeatherCell.h"

#define kWeatherViewHeight kScreenWidth*140/750

@interface EnquiryWeatherVC ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
}
@property (nonatomic, strong)NSMutableArray *weatherModels;
@end

@implementation EnquiryWeatherVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kRGBColor(233, 239, 239);
    
    //设置导航栏
    [self addNavBar];
    
    //下面的内容部分
    [self addWeatherListView];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //网络请求天气数据
        [self getWeatherData];
    }
    return self;
}

#pragma mark
#pragma mark *************   设置导航栏   *********************
- (void)addNavBar
{
    [self setNavigationItemTitle:@"天气查询"];
    
    [self setBackButtonWithImageName:@"back"];
}


#pragma mark ****************   设置下面的内容部分   *********************
- (void)addWeatherListView
{
    _weatherModels = [NSMutableArray array];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + 12*kRate, kScreenWidth, kScreenHeight - 64 - 12*kRate) style:UITableViewStylePlain];
    _tableView.backgroundColor = kRGBColor(233, 239, 239);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [UIView new];
    self.automaticallyAdjustsScrollViewInsets = false;
    [self.view addSubview:_tableView];
}

#pragma mark --- UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _weatherModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    WeathreModel *weatherModel = [[WeathreModel alloc] init];
//    weatherModel.bgImgStr = @"weather_sunny_bg";
//    weatherModel.dateStr = @"2016-10-09";
//    weatherModel.weatherStr = @"晴晴晴";
//    weatherModel.temperatureRangeStr = @"15°C-28°C";
//    weatherModel.isSuitableForWashing = @"适宜洗车";
//    weatherModel.weatherImgStr = @"weather_sunny";
    
    static NSString *identifier = @"weatherCell";
    
    WeatherCell *weatherCell = (WeatherCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!weatherCell) {
        weatherCell = [[WeatherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (_weatherModels.count > indexPath.row) {
        weatherCell.weatherModel = _weatherModels[indexPath.row];
    }
    
    return weatherCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kWeatherViewHeight + 12*kRate;//12为单元格间的间距
}

#pragma mark ****** 网络请求天气数据 ******
- (void)getWeatherData
{
    NSString *url_get = [NSString stringWithFormat:@"http://%@getWeatherDaysDatas.action", kHead];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];//单例
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:url_get parameters:nil progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *weathers = [responseObject objectForKey:@"weathers"];
        
        for (NSDictionary *weatherDic in weathers) {
            
            WeathreModel *weatherModel = [[WeathreModel alloc] initWithDictionary:weatherDic];
            [_weatherModels addObject:weatherModel];
            
        }
        
        //刷新UI
        [_tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败，原因是%@", error);
    }];
    
}

@end
