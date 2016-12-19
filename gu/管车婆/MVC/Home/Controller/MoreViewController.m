//
//  MoreViewController.m
//  管车婆
//
//  Created by 李伟 on 16/12/14.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import "MoreViewController.h"
#import "ServiceModel.h"
#import "ItemStoresVC.h"

#define kBtnWidth kScreenWidth/4

@interface MoreViewController ()

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //导航栏
    [self setNavigationItemTitle:@"更多"];
    [self setBackButtonWithImageName:@"back"];
    
}

- (void)setServices:(NSArray *)services
{
    _services = services;
    
    //内容
    for (int i = 0; i < services.count; i++) {
        
        ServiceModel *currentModel = services[i];
        
        int h = i%4;
        int v = i/4;
        
        UIButton *itemBtn = [[UIButton alloc] initWithFrame:CGRectMake(kBtnWidth*h, 64+kBtnWidth*v, kBtnWidth, kBtnWidth)];
        itemBtn.tag = 10000 + i;
        [itemBtn addTarget:self action:@selector(itemBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [itemBtn sd_setImageWithURL:currentModel.serviceImg forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"home_second_dujing"]];
        itemBtn.imageEdgeInsets = UIEdgeInsetsMake(20*kRate, 30*kRate, 35*kRate, 25*kRate);
        
        [itemBtn setTitle:currentModel.serviceName forState:UIControlStateNormal];
        itemBtn.titleLabel.font = [UIFont systemFontOfSize:12.0*kRate];
        itemBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [itemBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        itemBtn.titleEdgeInsets = UIEdgeInsetsMake(kBtnWidth - 35*kRate, -itemBtn.titleLabel.bounds.size.width - 70, 5*kRate, 0);
        
        [self.view addSubview:itemBtn];
        
    }
}

//BtnAction
- (void)itemBtnAction:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    int index = (int)btn.tag - 10000;
    ServiceModel *currentModel = _services[index];
    
    ItemStoresVC *itemStoresVC = [[ItemStoresVC alloc] init];
    itemStoresVC.sid = currentModel.serviceId;
    itemStoresVC.sname = currentModel.serviceName;
    itemStoresVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:itemStoresVC animated:NO];
    itemStoresVC.hidesBottomBarWhenPushed = NO;
    
    
}

#pragma mark


@end
