//
//  CarOwnersCell.m
//  管车婆
//
//  Created by 李伟 on 16/10/11.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "CarOwnersCell.h"
#import "UIControlFlagView.h"

#define kAccountViewWidth 105*kRate

@interface CarOwnersCell()
{
    UILabel      *dateLabel;
    UIImageView  *imgView;
    UILabel      *titleLabel;
    UILabel      *subTitleLabel;
    UIView       *accountView;
    
    UIControlFlagView *_flagView;//点赞按钮
}
@end

@implementation CarOwnersCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 30*kRate, 100*kRate)];
        [self.contentView addSubview:imgView];
        
        dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 130*kRate, 10*kRate, 100*kRate, 20*kRate)];
        dateLabel.textColor = [UIColor whiteColor];
        dateLabel.font = [UIFont systemFontOfSize:15.0*kRate];
        [imgView addSubview:dateLabel];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10*kRate, CGRectGetMaxY(imgView.frame) + 10*kRate, kScreenWidth - 50*kRate, 20*kRate)];
        titleLabel.font = [UIFont systemFontOfSize:14.0*kRate];
        [self.contentView addSubview:titleLabel];
        
        subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10*kRate, CGRectGetMaxY(titleLabel.frame) + 5*kRate, kScreenWidth - 50*kRate - kAccountViewWidth, 20*kRate)];
        subTitleLabel.font = [UIFont systemFontOfSize:10.0*kRate];
        subTitleLabel.textColor = [UIColor colorWithWhite:0.4 alpha:1];
        [self.contentView addSubview:subTitleLabel];
        
        //设置阅读、评论、点赞等按钮
        [self addAccountView];
        
    }
    
    return self;
}

//设置阅读、评论、点赞等按钮
- (void)addAccountView
{
    accountView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(subTitleLabel.frame), CGRectGetMinY(subTitleLabel.frame), kAccountViewWidth, 20*kRate)];
    [self.contentView addSubview:accountView];
    
    //最左边，阅读
    UIButton *readingBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 15*kRate, 15*kRate)];
    [readingBtn setImage:[UIImage imageNamed:@"carOwners_reading"] forState:UIControlStateNormal];
    [readingBtn addTarget:self action:@selector(readingBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [accountView addSubview:readingBtn];
    
    UILabel *readingAccountLB = [[UILabel alloc] initWithFrame:CGRectMake(15*kRate, 0, 20*kRate, 15*kRate)];
    readingAccountLB.text = @"66";
    readingAccountLB.font = [UIFont systemFontOfSize:10.0*kRate];
    [accountView addSubview:readingAccountLB];
    
    
    //中间，评论
    UIButton *commentBtn = [[UIButton alloc] initWithFrame:CGRectMake(35*kRate, 0, 15*kRate, 15*kRate)];
    [commentBtn setImage:[UIImage imageNamed:@"carOwners_comment"] forState:UIControlStateNormal];
    [commentBtn addTarget:self action:@selector(commentBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [accountView addSubview:commentBtn];
    
    UILabel *commentAccountLB = [[UILabel alloc] initWithFrame:CGRectMake(50*kRate, 0, 20*kRate, 15*kRate)];
    commentAccountLB.text = @"666";
    commentAccountLB.font = [UIFont systemFontOfSize:9.0*kRate];
    [accountView addSubview:commentAccountLB];
    
    //最右边，点赞
    _flagView = [[UIControlFlagView alloc] initWithFrame:CGRectMake(70*kRate, 0, 15*kRate, 15*kRate)];
    _flagView.noStateImg = [UIImage imageNamed:@"carOwners_like"];
    _flagView.yesStateImg = [UIImage imageNamed:@"carOwners_like_blue"];
    [accountView addSubview:_flagView];
//    self.carOwnersModel.flag = _flagView.flag;//点赞控件的初始状态
//    NSLog(@"self.carOwnersModel:%@", self.carOwnersModel);

    UITapGestureRecognizer *likeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(likeTapAction)];
    [_flagView addGestureRecognizer:likeTap];
    
    UILabel *likeAccountLB = [[UILabel alloc] initWithFrame:CGRectMake(85*kRate, 0, 20*kRate, 15*kRate)];
    likeAccountLB.text = @"66";
    likeAccountLB.font = [UIFont systemFontOfSize:10.0*kRate];
    [accountView addSubview:likeAccountLB];

}

- (void)layoutSubviews
{
    imgView.image = [UIImage imageNamed:@"carOwners_img"];
    dateLabel.text = @"2016-10-11";
    titleLabel.text = @"汽车驾驶之新手攻略";
    subTitleLabel.text = @"由驾校为您提供的强大驾驶技巧";
    
    
}




//设置单元格上下左右都有边距~
- (void)setFrame:(CGRect)frame
{
    
    frame.origin.x = 15*kRate;//左右距屏幕的距离
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 15*kRate;//上下两个单元格的边距
    
    
    
    [super setFrame:frame];
}

#pragma mark ButtonAction
- (void)readingBtnAction
{
    NSLog(@"阅读");
}

- (void)commentBtnAction
{
    NSLog(@"评论");
}

- (void)likeTapAction
{
    
    if (self.carOwnersModel.flag == FlagModelYES) {
        
        NSLog(@"ksjhgfds");
        [_flagView setFlag:FlagModelNO withAnimation:YES];
        
        CarOwnersModel *newModel = [[CarOwnersModel alloc] init];
        newModel.flag = FlagModelNO;
        self.carOwnersModel = newModel;
        
    } else if (self.carOwnersModel.flag == FlagModelNO) {
        
        NSLog(@"akhfsulqiyafbdjhf");
        [_flagView setFlag:FlagModelYES withAnimation:YES];
        
        CarOwnersModel *newModel = [[CarOwnersModel alloc] init];
        newModel.flag = FlagModelYES;
        self.carOwnersModel = newModel;
        
        

    }
    
}



#pragma mark
- (void)setCarOwnersModel:(CarOwnersModel *)carOwnersModel
{
    
    if (_carOwnersModel.flag != carOwnersModel.flag) {
        NSLog(@"属性被修改");
        
    }
    
    UIControlFlagMode flag = carOwnersModel.flag;
    [_flagView setFlag:flag withAnimation:NO];
    
    _carOwnersModel = carOwnersModel;
}

  

@end
