//
//  EnquiryDriverScoresVC.m
//  管车婆
//
//  Created by 李伟 on 16/10/8.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "EnquiryDriverScoresVC.h"

@interface EnquiryDriverScoresVC ()

@end

@implementation EnquiryDriverScoresVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self addNavBar];

}

#pragma mark *************   设置导航栏   *********************
- (void)addNavBar
{
    [self setNavigationItemTitle:@"驾照查分"];
    
    [self setBackButtonWithImageName:@"back"];
}



@end
