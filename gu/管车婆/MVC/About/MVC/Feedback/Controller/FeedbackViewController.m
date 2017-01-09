//
//  FeedbackViewController.m
//  管车婆
//
//  Created by 李伟 on 17/1/6.
//  Copyright © 2017年 远恒网络科技有限公司. All rights reserved.
//

#import "FeedbackViewController.h"
#import "FeedBackCountView.h"
#import "FeedbackInfoCell.h"
#import "FeedbackModel.h"
#import "ChatCellFrame.h"
#import "WriteFeedbackVC.h"
#import "FeedbackCountModel.h"

#define kAccountViewHeight 70*kRate
#define kAccountSubViewwidth 80*kRate
#define kAccountViewEdge (kScreenWidth - 3*kAccountSubViewwidth)/6

@interface FeedbackViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UIImageView *_titleView;//显示车行图标以及编写反馈按钮的view
    UIView *_adviceAccountView;//显示各种反馈建议数量的View
    
    UITableView *_tableView;
}
@property (nonatomic, strong)NSMutableArray  *chatCellFramesArr;
@property (nonatomic, strong)FeedbackCountModel *feedbackCountModel;
@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    
    _chatCellFramesArr = [NSMutableArray array];
    
    /*注意，接入请求反馈数量的接口后删掉以下几行代码*/
    _feedbackCountModel = [[FeedbackCountModel alloc] init];
    _feedbackCountModel.allCount = @"6条";
    _feedbackCountModel.nohfCount = @"3条";
    _feedbackCountModel.hfCount = @"3条";
    /*注意，接入请求反馈数量的接口后删掉以上几行代码*/

    //接收WriteFeedbackVC发送过来的通知，以在提交最新反馈之后就能显示最新的反馈列表
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadFeedbackListData) name:@"uploadFeedbackListData" object:nil];
    
    //网络请求反馈列表数据
    [self getNetworkFeedbackListDataWithIsRefresh:YES];
    //网络请求反馈数量数据
    [self getNetworkFeedbackCountData];
    
    //显示车行图标以及编写反馈按钮的title
    [self addTitleView];
    
    //全部建议、未回复、已回复
    [self addAccountView];
    
    //表视图
    [self addTableView];

    
}

#pragma mark **************  接收WriteFeedbackVC发送过来的通知  ******************
- (void)uploadFeedbackListData
{
    NSLog(@"接收到WriteFeedbackVC发送过来的通知，shauxinle ~");
    
    //网络请求反馈列表数据
    [self getNetworkFeedbackListDataWithIsRefresh:YES];
}

#pragma mark **************  网络请求反馈列表数据  ******************
- (void)getNetworkFeedbackListDataWithIsRefresh:(BOOL)isRefresh
{
    NSString *url_post = [NSString stringWithFormat:@"http://%@getFeedbackList.action", kHead];
    
    NSDictionary *params = @{
                             @"uid":[[self getLocalDic] objectForKey:@"uid"],
                             @"type":@"2",//固定传2，2代表用户反馈，1代表商户反馈
                             @"currsize":@"0",
                             @"pagesize":@"10"
                             };
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = responseSerializer;
    [manager POST:url_post parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSArray *jsondataArr = [content objectForKey:@"jsondata"];
        
        [_chatCellFramesArr removeAllObjects];
        
        for (NSDictionary *jsondataDic in jsondataArr) {
            
            FeedbackModel *feedbackModel = [[FeedbackModel alloc] initWithDic:jsondataDic];
            
            ChatCellFrame *chatCellFrame = [[ChatCellFrame alloc] init];
            chatCellFrame.feedbackModel = feedbackModel;
            [_chatCellFramesArr addObject:chatCellFrame];
            
        }
        
        //刷新UI
        [_tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败， 失败原因是：%@", error);
    }];
}

//网络请求反馈数量数据
- (void)getNetworkFeedbackCountData
{
    NSString *url_post = [NSString stringWithFormat:@"http://%@getfeedbackcount.action", kHead];
    
    NSDictionary *params = @{
                             @"type":@"2",
                             @"uid":@""
                             };
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = responseSerializer;
    [manager POST:url_post parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        _feedbackCountModel = [[FeedbackCountModel alloc] initWithDic:content];
        
        //刷新显示数量的视图
        [_adviceAccountView removeFromSuperview];
        [self addAccountView];
        
        
    } failure:nil];
    
}



#pragma mark **************  显示车行图标以及编写反馈按钮的title  ******************
- (void)addTitleView
{
    _titleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth*0.393)];
    _titleView.image = [UIImage imageNamed:@"feedback_title_bg"];
    _titleView.userInteractionEnabled = YES;
    [self.view addSubview:_titleView];
    
    //返回按钮
    [self addBackBtn];
    
    //头像
    [self addHeadView];
    
    //编写反馈的按钮
    [self addFeedBackBtn];
    
}

//返回按钮
- (void)addBackBtn
{
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(20*kRate, 30*kRate, 60*kRate, 24*kRate)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_titleView addSubview:backBtn];
}

- (void)backBtnAction
{
    NSLog(@"返回");
    
    [self.navigationController popViewControllerAnimated:NO];
}

//头像
- (void)addHeadView
{
    UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 50*kRate, 40*kRate, 80*kRate, 80*kRate)];
    headImgView.layer.cornerRadius = 40.0*kRate;
    headImgView.layer.masksToBounds = YES;
    [headImgView sd_setImageWithURL:[NSURL URLWithString:[[self getLocalDic] objectForKey:@"userHeadUrl"]] placeholderImage:[UIImage imageNamed:@"about_first_head"]];
    [_titleView addSubview:headImgView];
}


//编写反馈的按钮
- (void)addFeedBackBtn
{
    UIButton *feedbackBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 60*kRate, 30*kRate, 40*kRate, 40*kRate)];
    [feedbackBtn setBackgroundImage:[UIImage imageNamed:@"feedback_write"] forState:UIControlStateNormal];
    [feedbackBtn addTarget:self action:@selector(feedbackBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_titleView addSubview:feedbackBtn];
}

- (void)feedbackBtnAction
{
    NSLog(@"填写意见反馈");
    
    WriteFeedbackVC *writeFeedbackVC = [[WriteFeedbackVC alloc] init];
    writeFeedbackVC.isFirst = @"yes";//新建一条反馈，必须传isFirst值为yes
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:writeFeedbackVC animated:NO];
}

#pragma mark *******************  全部建议、未回复、已回复  ***********************
- (void)addAccountView
{
    _adviceAccountView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleView.frame), kScreenWidth, kAccountViewHeight)];
    _adviceAccountView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_adviceAccountView];
    
    //上面的一个小长条label
    [self addShowLabel];
    
    //各种反馈建议的数量
    [self addFeedbackCounts];
}

//上面的一个小长条label
- (void)addShowLabel
{
    UILabel *showLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 110*kRate, 0, 220*kRate, 20*kRate)];
    showLabel.text = @"您的宝贵意见是我们前进路上的指明灯";
    showLabel.textColor = [UIColor grayColor];
    showLabel.font = [UIFont systemFontOfSize:12.0*kRate];
    [_adviceAccountView addSubview:showLabel];
    
}

//各种反馈建议的数量
- (void)addFeedbackCounts
{
    NSArray *imgNames = [NSArray arrayWithObjects:@"feedback_all", @"feedback_no", @"feedback_yes", nil];
    NSArray *titles = [NSArray arrayWithObjects:@"全部建议", @"未回复", @"已回复", nil];
    NSArray *accounts = [NSArray arrayWithObjects:_feedbackCountModel.allCount, _feedbackCountModel.nohfCount, _feedbackCountModel.hfCount, nil];
    
    for (int i = 0; i < titles.count; i++) {
        
        FeedbackCountView *countSubView = [[FeedbackCountView alloc] initWithFrame:CGRectMake(kAccountViewEdge*(2*i+1) + i*kAccountSubViewwidth + kScreenWidth*0.03, 20*kRate, kAccountSubViewwidth, kAccountViewHeight-20*kRate)];
        countSubView.imgName = imgNames[i];
        countSubView.title = titles[i];
        if (accounts.count > i) {
            countSubView.account = accounts[i];
        }
        [_adviceAccountView addSubview:countSubView];
    }
    
}



#pragma mark ***************************  表视图  ******************************
- (void)addTableView
{
    //表视图展示
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(15*kRate, CGRectGetMaxY(_adviceAccountView.frame)+10*kRate, kScreenWidth - 30*kRate, kScreenHeight - CGRectGetMaxY(_adviceAccountView.frame) - 10*kRate - 20*kRate) style:UITableViewStylePlain];
    
    _tableView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.tableFooterView = [[UIView alloc] init];
    
    [self.view addSubview:_tableView];
    
}


#pragma mark ---- UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _chatCellFramesArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatCellFrame *currentFrame = [[ChatCellFrame alloc] init];
    if (_chatCellFramesArr.count > indexPath.row) {
        currentFrame = _chatCellFramesArr[indexPath.row];
    }
    
    static NSString *identifier = @"cell";
    
    FeedbackInfoCell *cell = (FeedbackInfoCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[FeedbackInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.layer.cornerRadius = 5.0*kRate;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.feedbackModel = currentFrame.feedbackModel;
    
    //自定义cell的回调，获取要展开/收起的cell。刷新点击的cell
    cell.showMoreTextBlock = ^(UITableViewCell *currentCell){
        NSIndexPath *indexRow = [_tableView indexPathForCell:currentCell];
        
        [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexRow, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FeedbackModel *currentEntity = nil;
    
    ChatCellFrame *currentFrame = [[ChatCellFrame alloc] init];
    if (_chatCellFramesArr.count > indexPath.row) {
        currentFrame = _chatCellFramesArr[indexPath.row];
    }
    
    currentEntity = currentFrame.feedbackModel;
    
    //根据isShowMoreText属性判断cell的高度
    if (currentEntity.isShowMoreText) {
        return [FeedbackInfoCell cellMoreHeight:currentEntity];
    } else {
        return [FeedbackInfoCell cellDefaultHeight];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FeedbackInfoCell *currentCell = [tableView cellForRowAtIndexPath:indexPath];
    
    WriteFeedbackVC *writeFeedbackVC = [[WriteFeedbackVC alloc] init];
    writeFeedbackVC.feedID = currentCell.feedbackModel.feedID;
    writeFeedbackVC.isFirst = @"no";
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:writeFeedbackVC animated:NO];
}


#pragma mark
#pragma mark 以下代码的作用是：让导航栏在该页面不显示出来，然后跳转到其他页面的时候显示导航栏
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

#pragma mark 
#pragma mark 移除通知观察者
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
