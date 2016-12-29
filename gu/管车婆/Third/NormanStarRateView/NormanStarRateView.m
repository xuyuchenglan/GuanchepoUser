//
//  NormanStarRateView.m
//  星星视图
//
//  Created by 李伟 on 16/8/4.
//  Copyright © 2016年 李伟. All rights reserved.
//

#import "NormanStarRateView.h"
//
#define kForegroundStarImageName @"stores_star_red"
#define kBackgroundStarImageName @"stores_star_gray"
#define kForegroundStarImageName_evaluate @"about_order_star_red"
#define kBackgroundStarImageName_evaluate @"about_order_star_gray"
#define kDefaultStarNumber 5
#define kAnimationTimeInterval 0.2


@interface NormanStarRateView ()

@property (nonatomic, strong) UIView *foregroundStarView;//(彩色星星视图)
@property (nonatomic, strong) UIView *backgroundStarView;//(灰色星星视图)

@property (nonatomic, assign) NSInteger numberOfStars;//(星星视图中的星星数量)

@end


@implementation NormanStarRateView

#pragma mark - Init Methods

- (instancetype)init {
    NSAssert(NO, @"You should never call this method in this class. Use initWithFrame: instead!");
    return nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame numberOfStars:kDefaultStarNumber];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _numberOfStars = kDefaultStarNumber;
        [self buildDataAndUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars {
    if (self = [super initWithFrame:frame]) {
        _numberOfStars = numberOfStars;
    }
    return self;
}

- (void)setIsEvaluating:(BOOL)isEvaluating
{
    _isEvaluating = isEvaluating;
    
    [self buildDataAndUI];
}

#pragma mark - Private Methods

- (void)buildDataAndUI {
    _scorePercent = 1;//默认为1
    _hasAnimation = NO;//默认为NO
    _allowIncompleteStar = NO;//默认为NO
    _allowTouch = YES;
    
    if (_isEvaluating) {//评分和展示评分的星星是不一样的
        self.foregroundStarView = [self createStarViewWithImage:kForegroundStarImageName_evaluate];
        self.backgroundStarView = [self createStarViewWithImage:kBackgroundStarImageName_evaluate];
    } else {
        self.foregroundStarView = [self createStarViewWithImage:kForegroundStarImageName];
        self.backgroundStarView = [self createStarViewWithImage:kBackgroundStarImageName];
    }
    
    
    [self addSubview:self.backgroundStarView];
    [self addSubview:self.foregroundStarView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapRateView:)];
    tapGesture.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapGesture];
}

- (void)userTapRateView:(UITapGestureRecognizer *)gesture {
    
    if (!_allowTouch) {
        return;
    }
    
    CGPoint tapPoint = [gesture locationInView:self];
    CGFloat offset = tapPoint.x;
    CGFloat realStarScore = offset / (self.bounds.size.width / self.numberOfStars);
    CGFloat starScore = self.allowIncompleteStar ? realStarScore : ceilf(realStarScore);
    self.scorePercent = starScore / self.numberOfStars;
    
    NSLog(@"%lf", starScore);
}

- (UIView *)createStarViewWithImage:(NSString *)imageName {
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    for (NSInteger i = 0; i < self.numberOfStars; i ++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i * self.bounds.size.width / self.numberOfStars, 0, self.bounds.size.width / self.numberOfStars, self.bounds.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imageView];
    }
    return view;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    __weak NormanStarRateView *weakSelf = self;
    CGFloat animationTimeInterval = self.hasAnimation ? kAnimationTimeInterval : 0;
    [UIView animateWithDuration:animationTimeInterval animations:^{
        weakSelf.foregroundStarView.frame = CGRectMake(0, 0, weakSelf.bounds.size.width * weakSelf.scorePercent, weakSelf.bounds.size.height);
    }];
}

#pragma mark - Get and Set Methods

- (void)setScorePercent:(CGFloat)scroePercent {
    if (_scorePercent == scroePercent) {
        return;
    }
    
    if (scroePercent < 0) {
        _scorePercent = 0;
    } else if (scroePercent > 1) {
        _scorePercent = 1;
    } else {
        _scorePercent = scroePercent;
    }
    
    if ([self.delegate respondsToSelector:@selector(starRateView:scroePercentDidChange:)]) {
        [self.delegate starRateView:self scroePercentDidChange:scroePercent];
    }
    
    [self setNeedsLayout];
}


@end
