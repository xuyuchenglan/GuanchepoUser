//
//  ItemAndCountView.m
//  管车婆
//
//  Created by 李伟 on 16/10/20.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "ItemAndCountView.h"
#import "OrderModel.h"

@interface ItemAndCountView()
{
    UILabel *_label;
}
@end

@implementation ItemAndCountView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _label = [[UILabel alloc] init];
        _label.numberOfLines = 0;
        [self addSubview:_label];
    }
    return self;
}

- (void)setItems:(NSArray *)items
{
    _items = items;

    _label.attributedText = [self getAttributedStringWithItems:items];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300*kRate, 20*items.count*kRate));
        make.top.mas_equalTo(0);
        make.left.equalTo(self).with.offset(0);
    }];
}

-(NSMutableAttributedString *)getAttributedStringWithItems:(NSArray *)items
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5.0*kRate];//调整行间距
    
    NSMutableAttributedString *mutaAttStr = [[NSMutableAttributedString alloc] init];
    for (int i = 0; i < items.count; i++) {
        
        NSDictionary *currentDic = items[i];
        
        NSMutableAttributedString *itemStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@                                                  ",[currentDic objectForKey:@"itemStr"]] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13*kRate],NSForegroundColorAttributeName:[UIColor colorWithWhite:0.4 alpha:1],NSParagraphStyleAttributeName:paragraphStyle}];
        [mutaAttStr appendAttributedString:itemStr];
        
        NSMutableAttributedString *itemCount = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",[currentDic objectForKey:@"itemCount"]] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13*kRate],NSForegroundColorAttributeName:[UIColor colorWithWhite:0.4 alpha:1],NSParagraphStyleAttributeName:paragraphStyle}];
        [mutaAttStr appendAttributedString:itemCount];

        
    }
    
    return mutaAttStr;
    
}

@end
