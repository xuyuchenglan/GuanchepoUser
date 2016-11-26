//
//  UIResponder+FindResponderVC.m
//  管车婆
//
//  Created by 李伟 on 16/11/8.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "UIResponder+FindResponderVC.h"

@implementation UIResponder (FindResponderVC)

- (UIViewController *)findResponderVCWith:(UIViewController *)viewController
{
    UIResponder *responder_vc = (UIResponder *)self;
    do {
        responder_vc = responder_vc.nextResponder;
    } while (![responder_vc isMemberOfClass:[viewController class]]);
    
    UIViewController *vc = (UIViewController *)responder_vc;
    
    return vc;
}




@end
