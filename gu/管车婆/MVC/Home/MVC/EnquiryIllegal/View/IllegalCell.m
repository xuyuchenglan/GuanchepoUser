//
//  IllegalCell.m
//  管车婆
//
//  Created by 李伟 on 16/10/15.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "IllegalCell.h"

@interface IllegalCell()
{
    UIView        *_line1;
    UIView        *_line2;
    UILabel       *_dateLB;
    UILabel       *_timeLB;
    UILabel       *_isDealedWithLB;
    UILabel       *_reasonLB;
    UILabel       *_addressLB;
    UILabel       *_pointsLB;
    UILabel       *_pointsLB_account;
    UILabel       *_fineLB;
    UILabel       *_fineLB_account;
    UIButton      *_payBtn;
}
@end

@implementation IllegalCell

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
        
        /************  分割线  *****************/
        [self addSeperateLine];
        /************  分割线  *****************/
        
        //第一块(高度30)
        [self addFirstContent];
        
        //第二块(高度是150 - 30 - 50 = 70)
        [self addSecondContent];
        
        //第三块（外加底部空隙，高度是34+16=50）
        [self addThirdcontent];
        
    }
    
    return self;
}

//两条分割线
- (void)addSeperateLine
{
    _line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 30*kRate, kScreenWidth, 1*kRate)];
    _line1.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self.contentView addSubview:_line1];
    
    _line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 100*kRate, kScreenWidth, 1*kRate)];
    _line2.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self.contentView addSubview:_line2];//底部高度是150-16-100=34；
}

//第一块(高度30)
- (void)addFirstContent
{
    _dateLB = [[UILabel alloc] init];
    _dateLB.font = [UIFont systemFontOfSize:13.0*kRate];
    _dateLB.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    [self.contentView addSubview:_dateLB];
    [_dateLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(90*kRate, 20*kRate));
        make.top.equalTo(self.contentView).with.offset(5*kRate);
        make.left.equalTo(self.contentView).with.offset(20*kRate);
    }];
    
    _timeLB = [[UILabel alloc] init];
    _timeLB.font = [UIFont systemFontOfSize:13.0*kRate];
    _timeLB.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    [self.contentView addSubview:_timeLB];
    [_timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60*kRate, 20*kRate));
        make.left.mas_equalTo(_dateLB.mas_right).with.offset(0);
        make.top.equalTo(self.contentView).with.offset(5*kRate);
    }];
    
    _isDealedWithLB = [[UILabel alloc] init];
    _isDealedWithLB.font = [UIFont systemFontOfSize:15.0*kRate];
    _isDealedWithLB.textColor = [UIColor colorWithRed:22/255.0 green:129/255.0 blue:252/255.0 alpha:1];
    [self.contentView addSubview:_isDealedWithLB];
    [_isDealedWithLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60*kRate, 20*kRate));
        make.right.mas_equalTo(self.contentView).with.offset(-20*kRate);
        make.top.equalTo(self.contentView).with.offset(5*kRate);
    }];
}

//第二块(高度是150 - 30 - 50 = 70)
- (void)addSecondContent
{
    _reasonLB = [[UILabel alloc] init];
    _reasonLB.font = [UIFont systemFontOfSize:15.0*kRate];
    [self.contentView addSubview:_reasonLB];
    [_reasonLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-40*kRate, 20*kRate));
        make.left.equalTo(self.contentView).with.offset(20*kRate);
        make.top.equalTo(_line1.mas_bottom).with.offset(15*kRate);
    }];
    
    _addressLB = [[UILabel alloc] init];
    _addressLB.font = [UIFont systemFontOfSize:13.0*kRate];
    _addressLB.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    [self.contentView addSubview:_addressLB];
    [_addressLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 40*kRate, 20*kRate));
        make.left.equalTo(self.contentView).with.offset(20*kRate);
        make.top.equalTo(_reasonLB.mas_bottom).with.offset(0);
    }];
}

//第三块（外加底部空隙，高度是34+16=50）
- (void)addThirdcontent
{
    _pointsLB = [[UILabel alloc] init];
    _pointsLB.font = [UIFont systemFontOfSize:15.0*kRate];
    _pointsLB.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    [self.contentView addSubview:_pointsLB];
    _pointsLB.text = @"扣分";
    [_pointsLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40*kRate, 20*kRate));
        make.left.equalTo(self.contentView).with.offset(20*kRate);
        make.top.equalTo(_line2.mas_bottom).with.offset(7*kRate);
    }];
    
    _pointsLB_account = [[UILabel alloc] init];
    _pointsLB_account.font = [UIFont systemFontOfSize:15.0*kRate];
    _pointsLB_account.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    [self.contentView addSubview:_pointsLB_account];
    [_pointsLB_account mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40*kRate, 20*kRate));
        make.left.equalTo(_pointsLB.mas_right).with.offset(0);
        make.top.equalTo(_line2.mas_bottom).with.offset(7*kRate);
    }];
    
    _fineLB = [[UILabel alloc] init];
    _fineLB.font = [UIFont systemFontOfSize:15.0*kRate];
    _fineLB.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    _fineLB.text = @"罚款";
    [self.contentView addSubview:_fineLB];
    [_fineLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40*kRate, 20*kRate));
        make.left.equalTo(_pointsLB_account.mas_right).with.offset(30*kRate);
        make.top.equalTo(_line2.mas_bottom).with.offset(7*kRate);
    }];
    
    _fineLB_account = [[UILabel alloc] init];
    _fineLB_account.font = [UIFont systemFontOfSize:15.0*kRate];
    _fineLB_account.textColor = [UIColor colorWithRed:22/255.0 green:129/255.0 blue:252/255.0 alpha:1];
    [self.contentView addSubview:_fineLB_account];
    [_fineLB_account mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60*kRate, 20*kRate));
        make.left.equalTo(_fineLB.mas_right).with.offset(0);
        make.top.equalTo(_line2.mas_bottom).with.offset(7*kRate);
    }];
    
    _payBtn = [[UIButton alloc] init];
    _payBtn.layer.cornerRadius = 6*kRate;
    _payBtn.titleLabel.font = [UIFont systemFontOfSize:13.0*kRate];
    [_payBtn setTitleColor:[UIColor colorWithWhite:0.3 alpha:1] forState:UIControlStateNormal];
    _payBtn.backgroundColor = [UIColor colorWithRed:228/255.0 green:229/255.0 blue:230/255.0 alpha:1];
    [self.contentView addSubview:_payBtn];
    [_payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80*kRate, 23*kRate));
        make.top.equalTo(_line2.mas_bottom).with.offset(7*kRate);
        make.right.equalTo(self.contentView).with.offset(-20*kRate);
    }];

}

- (void)layoutSubviews
{
    _dateLB.text = @"2016-09-17";
    _timeLB.text = @"09:50";
    _isDealedWithLB.text = @"未处理";
    _reasonLB.text = @"其他机动车在高速超速10%，不足20%";
    _addressLB.text = @"G20112KM + 700M";
    _pointsLB_account.text = @"3";
    _fineLB_account.text = @"¥200";
    [_payBtn setTitle:@"暂不能代缴" forState:UIControlStateNormal];
}



//设置单元格上下左右都有边距~
- (void)setFrame:(CGRect)frame
{
    //frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 16*kRate;//上下两个单元格的边距
    
    [super setFrame:frame];
}


@end
