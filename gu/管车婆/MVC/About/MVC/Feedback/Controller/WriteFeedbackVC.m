//
//  WriteFeedbackVC.m
//  管车婆
//
//  Created by 李伟 on 17/1/6.
//  Copyright © 2017年 远恒网络科技有限公司. All rights reserved.
//

#import "WriteFeedbackVC.h"
#import "ChatCell.h"
#import "ChatCellFrame.h"
#import "FeedbackModel.h"

@interface WriteFeedbackVC ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    UITableView *_tableView;
    
    UIView *_tfView;//最下面写反馈的视图
    UITextField *_tf;//写反馈的输入框
}
@property (nonatomic, strong)NSMutableArray *chatCellFramesArr;
@property (nonatomic, strong)NSString       *feedbackContent;//记录输入框中输入的反馈文字
@end

@implementation WriteFeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _chatCellFramesArr = [NSMutableArray array];
    
    if (![self.isFirst isEqual:@"yes"]) {
        //网络请求反馈详情数据
        [self getNetworkFeedbackInfo];
    }

    
    //设置导航栏
    [self setNavigationItemTitle:@"意见反馈"];
    [self setBackButtonWithImageName:@"back"];
    
    //设置下面的聊天界面
    [self addChatView];
    
    //填写反馈的输入框
    [self addTF];
}


#pragma mark ******************   设置下面的聊天界面   *********************
- (void)addChatView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 60*kRate)];
    _tableView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//去除单元格分割线
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    
}

#pragma mark ------- UItableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _chatCellFramesArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *chatCellID = @"chatCellID";
    
    ChatCell *chatCell = [tableView dequeueReusableCellWithIdentifier:chatCellID];
    
    ChatCellFrame *chatCellFrame = [[ChatCellFrame alloc] init];
    if (_chatCellFramesArr.count > indexPath.row) {
        chatCellFrame = _chatCellFramesArr[indexPath.row];
    }
    
    if (!chatCell) {
        chatCell = [[ChatCell alloc] init];
    }
    
    chatCell.selectionStyle = UITableViewCellSelectionStyleNone;//去除选中效果
    chatCell.cellFrame = chatCellFrame;
    chatCell.contentView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    
    
    return chatCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatCellFrame *currentFrame = _chatCellFramesArr[indexPath.row];
    return currentFrame.cellHeight;
}


#pragma mark ******************   填写反馈的输入框   *********************
- (void)addTF
{
    //添加一个观察者，实时监测输入框中文字的变化，以实时获取到输入框中输入的文字
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    
    _tfView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 60*kRate, kScreenWidth, 60*kRate)];
    _tfView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tfView];
    
    _tf = [[UITextField alloc] initWithFrame:CGRectMake(15*kRate, 0, kScreenWidth - 70*kRate, 45*kRate)];
    _tf.delegate = self;
    _tf.borderStyle = UITextBorderStyleNone;
    _tf.placeholder = @"请输入您的问题或建议";
    _tf.autocorrectionType = UITextAutocorrectionTypeNo;
    _tf.returnKeyType = UIReturnKeySend;
    _tf.adjustsFontSizeToFitWidth = YES;
    [_tfView addSubview:_tf];
    
    //右侧的笔
    UIImageView *writeImg = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 45*kRate, 5*kRate, 40*kRate, 40*kRate)];
    writeImg.image = [UIImage imageNamed:@"feedback_write"];
    [_tfView addSubview:writeImg];
    
    
    //下面的那条灰线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15*kRate, 50*kRate, kScreenWidth - 30*kRate, 1*kRate)];
    lineView.backgroundColor = [UIColor colorWithWhite:0.6 alpha:1];
    [_tfView addSubview:lineView];
    
}

//一监测到输入框有变化就调用该方法
- (void)textFieldChanged:(NSNotification *)noti
{
    _feedbackContent = _tf.text;
}


#pragma mark ------ UITextFieldDelegate
//点击“Return”键的时候调用的方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_tf resignFirstResponder];//收起键盘
    
    if (_feedbackContent.length > 0) {
        
        //网络请求，提交反馈数据
        [self sendFeedbackData];
    }
    
    return YES;
}

//键盘出现时，让视图上升
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - 300*kRate, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
    
}

//键盘消失时，试图恢复原样
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 300*kRate, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

#pragma mark ------ 网络请求，提交反馈数据
- (void)sendFeedbackData
{
    NSLog(@"发送反馈");
    
    NSString *url_post = [NSString stringWithFormat:@"http://%@addFeedback.action", kHead];
    
    NSString *feedid = [[NSString alloc] init];
    if (self.feedID.length > 0) {
        feedid = self.feedID;
    } else {
        feedid = @"";
    }
    
    NSString *relationID = [[NSString alloc] init];
    if ([self.isFirst isEqual:@"yes"]) {
        relationID = @"1";
    } else if ([self.isFirst isEqual:@"no"]) {
        relationID = feedid;
    }
    
    NSLog(@"relationID:%@", relationID);
    
    NSDictionary *params = @{
                             @"uid":[[self getLocalDic] objectForKey:@"uid"],
                             @"content":_feedbackContent,
                             @"type":@"2",
                             @"relationid":relationID
                             };
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = responseSerializer;
    
    [manager POST:url_post parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        _tf.text = nil;
        
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSString *result = [content objectForKey:@"result"];
        NSString *feedididid = [content objectForKey:@"feedid"];
        
        if ([result isEqual:@"success"] && feedididid.length > 0) {
            if ([_isFirst isEqual:@"yes"]) {
                _feedID = feedididid;
            }
            _isFirst = @"no";//只要提交一次反馈成功，就设置isFirsr为no
        }
        
        //请求反馈详情数据，并显示出来
        if (_feedID.length > 0) {
            [self getNetworkFeedbackInfo];
        }
        
        //给FeedbackViewController发送一个通知，刷新UI，显示最新的反馈列表
        [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadFeedbackListData" object:self];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败， 失败原因是：%@", error);
    }];
    
}

#pragma mark
#pragma  mark *****************   网络请求反馈详情数据   ********************
- (void)getNetworkFeedbackInfo
{
    NSString *url_post = [NSString stringWithFormat:@"http://%@getFeedbackDetails.action", kHead];
    
    NSString *feedid = [[NSString alloc] init];
    if (self.feedID.length > 0) {
        feedid = self.feedID;
    } else {
        feedid = @"";
    }
    
    NSDictionary *params = @{
                             @"fid":_feedID
                             };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = responseSerializer;
    
    [manager POST:url_post parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [_chatCellFramesArr removeAllObjects];//如果不加这段代码，会导致在原来的基础上逐渐累加，而不是刷新。
        
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSArray *jsondataArr = [content objectForKey:@"jsondata"];
        
        for (NSDictionary *jsondataDic in jsondataArr) {
            
            FeedbackModel *feedbackModel = [[FeedbackModel alloc] initWithDic:jsondataDic];
            ChatCellFrame *chatCellFrame = [[ChatCellFrame alloc] init];
            chatCellFrame.feedbackModel = feedbackModel;
            [_chatCellFramesArr addObject:chatCellFrame];
            
        }
        
        //刷新UI
        [_tableView reloadData];
        
        
    } failure:nil];
    
}

#pragma mark
#pragma mark 移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
