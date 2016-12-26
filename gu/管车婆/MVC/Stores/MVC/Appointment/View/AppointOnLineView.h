//
//  AppointOnLineView.h
//  管车婆
//
//  Created by 李伟 on 16/12/13.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MyBlock)();

@interface AppointOnLineView : UIView

@property (nonatomic, copy)MyBlock myBlock;

- (void)dateBtnActionWithBlock:(MyBlock)block;


@property (nonatomic, strong)UIButton    *timeBtn;
@property (nonatomic, strong)UITextField *nameTF;
@property (nonatomic, strong)UITextField *phoneTF;

@end
