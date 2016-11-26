//
//  BuyAutoInsuranceVC.m
//  管车婆
//
//  Created by 李伟 on 16/10/8.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "BuyAutoInsuranceVC.h"

@interface BuyAutoInsuranceVC ()

@end

@implementation BuyAutoInsuranceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self addNavBar];

}


#pragma mark *************   设置导航栏   *********************
- (void)addNavBar
{
    [self setNavigationItemTitle:@"买车险"];
    
    [self setBackButtonWithImageName:@"back"];
}


@end
