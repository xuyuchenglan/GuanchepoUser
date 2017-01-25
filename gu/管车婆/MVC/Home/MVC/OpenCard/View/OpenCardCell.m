//
//  OpenCardCell.m
//  管车婆
//
//  Created by 李伟 on 16/11/7.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "OpenCardCell.h"
#import "PayForOpeningCard.h"
#import "OpenCardVC.h"
#import "OpenCardModel.h"


#define kCellWidth (kScreenWidth - 15*kRate*2)

@interface OpenCardCell()
{
    UIImageView *_cellBgImgView;
    UIImageView *_infoImgView;
    
    UILabel     *_cardTypeLB;
    UILabel     *_chargeLB;
    UILabel     *_servicesLB;
    UIButton    *_openCardBtn;
}
@end

@implementation OpenCardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _cellBgImgView = [[UIImageView alloc] init];
        self.backgroundView = _cellBgImgView;
        self.backgroundView.frame = CGRectMake(0, 0, kCellWidth, (240-10)*kRate);
        
        _infoImgView = [[UIImageView alloc] init];
        _infoImgView.userInteractionEnabled = YES;
        _infoImgView.image = [UIImage imageNamed:@"home_third_membership_bg"];
        [self.contentView addSubview:_infoImgView];
        [_infoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kCellWidth-4*kRate, 80*kRate));
            make.left.equalTo(self.contentView).with.offset(2*kRate);
            make.bottom.equalTo(self.contentView).with.offset(0);
        }];
        
        //卡种、金额、服务、开卡按钮
        [self addInfo];
    }
    
    return self;
}

   //卡种、金额、服务、开卡按钮
- (void)addInfo
{
    _cardTypeLB = [[UILabel alloc] init];
    _cardTypeLB.font = [UIFont systemFontOfSize:17.0*kRate];
    _cardTypeLB.textColor = [UIColor whiteColor];
    [_infoImgView addSubview:_cardTypeLB];
    [_cardTypeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200*kRate, 25*kRate));
        make.left.equalTo(_infoImgView).with.offset(15*kRate);
        make.top.equalTo(_infoImgView).with.offset(15*kRate);
    }];
    
    _chargeLB = [[UILabel alloc] init];
    _chargeLB.textColor = [UIColor redColor];
    _chargeLB.font = [UIFont systemFontOfSize:17.0*kRate];
    [_infoImgView addSubview:_chargeLB];
    [_chargeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70*kRate, 25*kRate));
        make.left.equalTo(_infoImgView).with.offset(15*kRate);
        make.top.equalTo(_cardTypeLB.mas_bottom).with.offset(5*kRate);
    }];
    
    _servicesLB = [[UILabel alloc] init];
    _servicesLB.textColor = [UIColor whiteColor];
    _servicesLB.font = [UIFont systemFontOfSize:13.0*kRate];
    _servicesLB.adjustsFontSizeToFitWidth = YES;
    [_infoImgView addSubview:_servicesLB];
    [_servicesLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150*kRate, 20*kRate));
        make.left.equalTo(_chargeLB.mas_right).with.offset(10*kRate);
        make.top.equalTo(_cardTypeLB.mas_bottom).with.offset(10*kRate);
    }];
    
    _openCardBtn = [[UIButton alloc] init];
    _openCardBtn.backgroundColor = [UIColor orangeColor];
    [_openCardBtn addTarget:self action:@selector(openBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_openCardBtn setTitle:@"立即开卡" forState:UIControlStateNormal];
    _openCardBtn.titleLabel.textColor = [UIColor whiteColor];
    _openCardBtn.titleLabel.font = [UIFont systemFontOfSize:17.0*kRate];
    [_infoImgView addSubview:_openCardBtn];
    [_openCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*kRate, 30*kRate));
        make.right.equalTo(_infoImgView).with.offset(-15*kRate);
        make.top.equalTo(_cardTypeLB.mas_bottom).with.offset(0);
    }];
    
    
}

#pragma mark
- (void)layoutSubviews
{
    [_cellBgImgView sd_setImageWithURL:self.openCardModel.picUrl placeholderImage:[UIImage imageNamed:@"home_third_membership_card"]];
    _cardTypeLB.text = self.openCardModel.name;
    _chargeLB.text = [NSString stringWithFormat:@"￥ %@", self.openCardModel.price];
    _servicesLB.text = self.openCardModel.desc;
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 10*kRate;
    
    frame.origin.x = 15*kRate;
    frame.size.width = kCellWidth;
    
    [super setFrame:frame];
}

#pragma mark
#pragma mark ButtonAction
- (void)openBtnAction
{
    NSLog(@"立即开卡");
    PayForOpeningCard *pay4CardVC = [[PayForOpeningCard alloc] init];
    pay4CardVC.openCardModel = _openCardModel;
    pay4CardVC.hidesBottomBarWhenPushed = YES;
    [[self findResponderVCWith:[[OpenCardVC alloc] init]].navigationController pushViewController:pay4CardVC animated:NO];
    
}

@end
