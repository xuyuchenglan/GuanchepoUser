//
//  WeatherCell.m
//  管车婆
//
//  Created by 李伟 on 16/10/19.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "WeatherCell.h"

#define kWeatherViewHeight kScreenWidth*140/750

@interface WeatherCell()
{
    UIImageView *bgImgView;
    UILabel     *dateLabel;
    UILabel     *weatherLabel;
    UILabel     *temperatureRangeLabel;
    UILabel     *isSuitableForWashingLabel;
    UIImageView *weatherImgView;
}
@end

@implementation WeatherCell

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
        
        bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kWeatherViewHeight)];
        [self.contentView addSubview:bgImgView];

        dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(30*kRate, 10*kRate, 100*kRate, 20*kRate)];
        dateLabel.textColor = [UIColor blackColor];
        dateLabel.font = [UIFont systemFontOfSize:14.0*kRate];
        [bgImgView addSubview:dateLabel];

        weatherLabel = [[UILabel alloc] initWithFrame:CGRectMake(30*kRate, 40*kRate, 50*kRate, 20*kRate)];
        weatherLabel.textColor = [UIColor blackColor];
        weatherLabel.font = [UIFont systemFontOfSize:14.0*kRate];
        weatherLabel.textAlignment = NSTextAlignmentCenter;
        [bgImgView addSubview:weatherLabel];
        
        temperatureRangeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(weatherLabel.frame) + 20*kRate, 40*kRate, 100*kRate, 20*kRate)];
        temperatureRangeLabel.textColor = [UIColor blackColor];
        temperatureRangeLabel.font = [UIFont systemFontOfSize:14.0*kRate];
        [bgImgView addSubview:temperatureRangeLabel];
        
        isSuitableForWashingLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 140*kRate, 40*kRate, 70*kRate, 20*kRate)];
        isSuitableForWashingLabel.textColor = [UIColor colorWithRed:1 green:214/255.0 blue:0 alpha:1];
        isSuitableForWashingLabel.font = [UIFont systemFontOfSize:14.0*kRate];
        [bgImgView addSubview:isSuitableForWashingLabel];
        
        weatherImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 60*kRate, 40*kRate, 20*kRate, 20*kRate)];
        [bgImgView addSubview:weatherImgView];
        
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    bgImgView.image = [UIImage imageNamed:_weatherModel.bgImgStr];
    
    dateLabel.text = _weatherModel.dateStr;
    
    weatherLabel.text = _weatherModel.weatherStr;
    
    temperatureRangeLabel.text = _weatherModel.temperatureRangeStr;
    
    isSuitableForWashingLabel.text = _weatherModel.isSuitableForWashing;
    
    weatherImgView.image = [UIImage imageNamed:_weatherModel.weatherImgStr];
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 12*kRate;//上下两个单元格的边距
    
    [super setFrame:frame];
}

@end
