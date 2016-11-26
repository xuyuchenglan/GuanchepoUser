//
//  NormanGuideViewCell.h
//  引导页
//
//  Created by 李伟 on 16/8/4.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *kCellIdentifier_NormanGuideViewCell = @"NormanGuideViewCell";

@interface NormanGuideViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *button;

@end
