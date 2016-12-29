//
//  EvaluationVC.m
//  管车婆
//
//  Created by 李伟 on 16/12/26.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import "EvaluationVC.h"
#import "ItemAndCountView.h"
#import "NormanStarRateView.h"
#import "PlaceholderTextView.h"

@interface EvaluationVC ()<UITextViewDelegate, NormanStarRateViewDelegate>
{
    UIImageView         *_headImgView;//门店快照
    UILabel             *_nameLB;//店名
    UIView              *_line1;//第一条分割线
    ItemAndCountView    *_itemAndCountView;//服务项目和数量
    NormanStarRateView  *_starRateView;//星星视图评分
}

@property (nonatomic, strong) PlaceholderTextView *textView;//写评论的视图
@property (nonatomic, strong)UILabel *wordCountLabel;//字数的限制

@property (nonatomic, strong)NSString *starCount;//记录评价的星级数

@end

@implementation EvaluationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _starCount = [[NSString alloc] init];
    
    //添加通知中心监听，当键盘弹出或者消失时收到消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.view.backgroundColor = kRGBColor(248, 249, 250);
    
    //导航栏
    [self setNavigationItemTitle:@"我要评论"];
    [self setBackButtonWithImageName:@"back"];
    
    //下面的内容视图
    [self addContentView];
}

//下面的内容视图
- (void)addContentView
{
    //头像，商户名称，以及服务项目
    [self addHeadAndNameAndItems];
    
    //给商家打分视图
    [self addScoreStarView];
    
    //写评论
    [self addCommentTextView];
    
    //发表评论按钮
    [self addCommentBtn];
}

    //头像，商户名称，以及服务项目
- (void)addHeadAndNameAndItems
{
    _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20*kRate, (64+30)*kRate, 50*kRate, 50*kRate)];
    _headImgView.layer.cornerRadius = 25*kRate;
    _headImgView.layer.masksToBounds = YES;
    [_headImgView sd_setImageWithURL:self.orderModel.headImgUrl placeholderImage:[UIImage imageNamed:@"about_order_head"]];
    [self.view addSubview:_headImgView];
    
    _line1 = [[UIView alloc] init];
    _line1.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
    [self.view addSubview:_line1];
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - CGRectGetMaxX(_headImgView.frame) + 5*kRate, 1*kRate));
        make.left.equalTo(_headImgView.mas_right).with.offset(5*kRate);
        make.top.equalTo(self.view).with.offset((64+30)*kRate + 50*kRate/2);
    }];
    
    _nameLB = [[UILabel alloc] init];
    _nameLB.font = [UIFont systemFontOfSize:15.0*kRate];
    _nameLB.adjustsFontSizeToFitWidth = YES;
    _nameLB.text = self.orderModel.nameStr;
    [self.view addSubview:_nameLB];
    [_nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200*kRate, 20*kRate));
        make.bottom.equalTo(_line1.mas_top).with.offset(-5*kRate);
        make.left.equalTo(_headImgView.mas_right).with.offset(6*kRate);
    }];
    
        //服务项目及其数量
    _itemAndCountView = [[ItemAndCountView alloc] init];
    [self.view addSubview:_itemAndCountView];
    _itemAndCountView.items = _orderModel.items;
    [_itemAndCountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 10*kRate - 50*kRate - 6*kRate - 30*kRate, 20*kRate * _orderModel.items.count));
        make.top.equalTo(_line1.mas_bottom).with.offset(5*kRate);
        make.left.equalTo(_headImgView.mas_right).with.offset(6*kRate);
    }];

}

    //给商家打分视图
- (void)addScoreStarView
{
    UILabel *scoreTitleLB = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth-(80+10+200)*kRate)/2, CGRectGetMaxY(_line1.frame) + 200*kRate, 80*kRate, 30*kRate)];
    scoreTitleLB.text = @"给商家打分";
    scoreTitleLB.font = [UIFont systemFontOfSize:15*kRate];
    scoreTitleLB.adjustsFontSizeToFitWidth = YES;
    scoreTitleLB.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    [self.view addSubview:scoreTitleLB];
    
    _starRateView = [[NormanStarRateView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(scoreTitleLB.frame) + 10*kRate, CGRectGetMinY(scoreTitleLB.frame), 200*kRate, 30*kRate) numberOfStars:5];
    _starRateView.isEvaluating = YES;//是正在评分，而不是展示评分
    _starRateView.allowIncompleteStar = NO;//是否允许评分为小数
    _starRateView.allowTouch = YES;//是否允许点击星星视图
    _starRateView.scorePercent = 0;
    _starRateView.delegate = self;
    _starRateView.hasAnimation = NO;
    [self.view addSubview:_starRateView];
}

#pragma mark --- 写评论
- (void)addCommentTextView
{
    _textView = [[PlaceholderTextView alloc]initWithFrame:CGRectMake(30*kRate, CGRectGetMaxY(_starRateView.frame) + 50*kRate, kScreenWidth - 60*kRate, 180*kRate)];
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.delegate = self;
    _textView.font = [UIFont systemFontOfSize:14.f*kRate];
    _textView.textColor = [UIColor blackColor];
    _textView.textAlignment = NSTextAlignmentLeft;
    _textView.editable = YES;
    _textView.layer.cornerRadius = 4.0f*kRate;
    _textView.layer.borderColor = kRGBColor(227, 224, 216).CGColor;
    _textView.layer.borderColor = [UIColor clearColor].CGColor;
    _textView.layer.borderWidth = 0.5*kRate;
    _textView.placeholderColor = kRGBColor(0x89, 0x89, 0x89);
    _textView.placeholder = @"写下你遇到的问题，或告诉我们你的宝贵意见~";
    [self.view addSubview:_textView];
    
    
    self.wordCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*kRate, CGRectGetMaxY(_textView.frame), kScreenWidth - 60*kRate, 20*kRate)];
    _wordCountLabel.font = [UIFont systemFontOfSize:14.f*kRate];
    _wordCountLabel.textColor = [UIColor lightGrayColor];
    self.wordCountLabel.text = @"0/300";
    self.wordCountLabel.backgroundColor = [UIColor whiteColor];
    self.wordCountLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:_wordCountLabel];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}


    //发表评论按钮
- (void)addCommentBtn
{
    UIButton *commentBtn = [[UIButton alloc] init];
    commentBtn.layer.cornerRadius = 5.0*kRate;
    [commentBtn setTitle:@"发表评论" forState:UIControlStateNormal];
    [commentBtn setBackgroundColor:[UIColor redColor]];
    [commentBtn addTarget:self action:@selector(commentBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commentBtn];
    [commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-60*kRate, 50*kRate));
        make.left.equalTo(self.view).with.offset(30*kRate);
        make.top.equalTo(_wordCountLabel.mas_bottom).with.offset(50*kRate);
    }];
}

- (void)commentBtnAction
{
    [self.view endEditing:YES];
    
    if (_starCount.length == 0) {
        
        [self showAlertViewWithTitle:@"提示" WithMessage:@"请您给商家打分~否则不能提交评论~☺"];
        
    } else {
        
        if (self.textView.text.length == 0) {
            
            [self showAlertViewWithTitle:@"提示" WithMessage:@"请您留下宝贵意见☺~"];
            
        } else {
            
            NSLog(@"_starCount:%@, _textView.text:%@, _orderModel.orderID:%@, uid:%@, _orderModel.mid:%@", _starCount, _textView.text, _orderModel.orderID, [[self getLocalDic] objectForKey:@"uid"], _orderModel.mid);
            
            //在这里提交评价的网络请求
            NSString *url_post = [NSString stringWithFormat:@"http://%@pingjia.action", kHead];
            
            NSDictionary *params = @{
                                     @"oid"      :   _orderModel.orderID,
                                     @"uid"      :   [[self getLocalDic] objectForKey:@"uid"],
                                     @"mid"      :   _orderModel.mid,
                                     @"pjcontent":   _textView.text,
                                     @"star"     :   _starCount
                                     };
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
            manager.responseSerializer = responseSerializer;
            [manager POST:url_post parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSString *result = [content objectForKey:@"result"];
                NSString *exist = [content objectForKey:@"exist"];
                if ([result isEqualToString:@"success"]) {
                    [self showAlertViewWithTitle:@"评价成功!" WithMessage:nil];
                } else {
                    if (![exist isEqualToString:@"0"]) {
                        [self showAlertViewWithTitle:@"评价失败" WithMessage:@"您已评价过该订单"];
                    } else {
                        [self showAlertViewWithTitle:@"评价失败" WithMessage:@"未知原因"];
                    }
                }
                
                //刷新UI,更新已完成和已评价两个页面
                [[NSNotificationCenter defaultCenter] postNotificationName:@"completeComment" object:nil];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"请求失败， 失败原因是：%@", error);
            }];
            
            
        }
    }
}

#pragma mark
#pragma mark UITextViewDelegate
//把回车键当做退出键盘的响应键  textView退出键盘的操作
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([@"\n" isEqualToString:text] == YES)
    {
        //[textView resignFirstResponder];
        [self.view endEditing:YES];
        
        return NO;
    }
    
    return YES;
}

//在这个地方计算输入的字数
- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger wordCount = textView.text.length;
    self.wordCountLabel.text = [NSString stringWithFormat:@"%ld/300",(long)wordCount];
    [self wordLimit:textView];
}

        //超过300字不能输入
-(BOOL)wordLimit:(UITextView *)text{
    if (text.text.length < 300) {
        NSLog(@"%ld",text.text.length);
        self.textView.editable = YES;
    }
    else{
        self.textView.editable = NO;
        
    }
    return nil;
}

#pragma mark
#pragma mark NormanStarRakeViewDelegate
- (void)starRateView:(NormanStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent
{
    int starCountInt = newScorePercent * 5;
    _starCount = [NSString stringWithFormat:@"%d", starCountInt];
}


#pragma mark
#pragma mark 键盘弹出或者隐藏时调用的方法
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSLog(@"键盘显示");
    
    CGFloat height = 130*kRate;
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationBeginsFromCurrentState:YES];
    ///移动（带有动画）
    CGRect frame = self.view.frame;
    frame.origin.y = -height ;
    self.view.frame = frame;
    [UIView commitAnimations];
    
    
}


//键盘隐藏
- (void)keyboardWillHide:(NSNotification *)notification
{
    NSLog(@"键盘隐藏");
    
    //键盘消失时，试图恢复原样
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationBeginsFromCurrentState:YES];
    ///移动（带有动画）
    CGRect frame = self.view.frame;
    frame.origin.y = 0;
    self.view.frame = frame;
    [UIView commitAnimations];
    
}

#pragma mark
//编辑过程中不想编辑了，然后就滑动一下外面的屏幕，然后就结束编辑状态了
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_textView resignFirstResponder];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
