//
//  OrderStateView.m
//  管车婆
//
//  Created by 李伟 on 16/8/29.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "OrderStateView.h"

@interface OrderStateView()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UILabel *_dataLabel_orderState;//订单状态
    UILabel *_dataLabel_pjState;//评论状态
    UILabel *_dataLabel_isVoucherUp;//是否上传凭证
}
@end

@implementation OrderStateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //第一行
        [self addFirstLine];
        
        //第二行
        [self addSecondLine];
        
        //第三行
        [self addThirdLine];
        
    }
    return self;
}

//第一行，订单状态
- (void)addFirstLine
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(35*kRate, 5*kRate, 100*kRate, 20*kRate)];
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:@"订单状态"];
    [attrStr addAttribute:NSKernAttributeName value:@(3.0*kRate) range:NSMakeRange(0, attrStr.length)];///文字间间距
    titleLabel.attributedText = attrStr;
    titleLabel.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    titleLabel.font = [UIFont systemFontOfSize:12.0*kRate];
    [self addSubview:titleLabel];
    
    _dataLabel_orderState = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame) + 20*kRate, 5*kRate, kScreenWidth - CGRectGetMaxX(titleLabel.frame) - 50*kRate, 20*kRate)];
    _dataLabel_orderState.font = [UIFont systemFontOfSize:12.0*kRate];
    [self addSubview:_dataLabel_orderState];
    
    
}

//第二行，评论状态
- (void)addSecondLine
{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 30*kRate, kScreenWidth, 0.5*kRate)];
    lineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    [self addSubview:lineView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(35*kRate, 35*kRate, 100*kRate, 20*kRate)];
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:@"评论状态"];
    [attrStr addAttribute:NSKernAttributeName value:@(3.0*kRate) range:NSMakeRange(0, attrStr.length)];///文字间间距
    titleLabel.attributedText = attrStr;
    titleLabel.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    titleLabel.font = [UIFont systemFontOfSize:12.0*kRate];
    [self addSubview:titleLabel];
    
    _dataLabel_pjState = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame) + 20*kRate, 35*kRate, kScreenWidth - CGRectGetMaxX(titleLabel.frame) - 50*kRate, 20*kRate)];
    _dataLabel_pjState.font = [UIFont systemFontOfSize:12.0*kRate];
    [self addSubview:_dataLabel_pjState];
    
}

//第三行，上传凭证
- (void)addThirdLine
{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 60*kRate, kScreenWidth, 0.5*kRate)];
    lineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    [self addSubview:lineView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(35*kRate, 65*kRate, 100*kRate, 20*kRate)];
    titleLabel.font = [UIFont systemFontOfSize:12.0*kRate];
    titleLabel.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:@"上传凭证"];
    [attrStr addAttribute:NSKernAttributeName value:@(3.0*kRate) range:NSMakeRange(0, attrStr.length)];///文字间间距
    titleLabel.attributedText = attrStr;
    [self addSubview:titleLabel];
    
    _dataLabel_isVoucherUp = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame) + 20*kRate, 65*kRate, kScreenWidth - CGRectGetMaxX(titleLabel.frame) - 50*kRate, 20*kRate)];
    _dataLabel_isVoucherUp.font = [UIFont systemFontOfSize:12.0*kRate];
    [self addSubview:_dataLabel_isVoucherUp];
    
    
    
}

- (void)layoutSubviews
{
    _dataLabel_orderState.text = self.orderModel.state;
    _dataLabel_pjState.text = self.orderModel.pjState;
    _dataLabel_isVoucherUp.text = @"无需上传";

    //不需要上传凭证的时候隐藏凭证栏,需要上传凭证的时候才会显示上传凭证按钮
    if ([self.orderModel.voucher isEqual:@"1"]) {
        _dataLabel_isVoucherUp.text = self.orderModel.isVoucherUp;
        [self addVoucherUpBtn];
    }
    
}

#pragma mark *************   上传凭证   ***********************
//添加上传凭证控件
- (void)addVoucherUpBtn
{
    UIButton *voucherUpBtn = [[UIButton alloc] initWithFrame:CGRectMake( kScreenWidth - 100*kRate, 61*kRate, 80*kRate, 29*kRate)];
    [voucherUpBtn addTarget:self action:@selector(addVoucherUpBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:voucherUpBtn];
    
    [voucherUpBtn setImage:[UIImage imageNamed:@"about_order_camera"] forState:UIControlStateNormal];
    [voucherUpBtn setImage:[UIImage imageNamed:@"about_order_camera_selected"] forState:UIControlStateHighlighted];
    voucherUpBtn.imageEdgeInsets = UIEdgeInsetsMake(5*kRate, 55*kRate, 5*kRate, 5*kRate);
    
    [voucherUpBtn setTitle:@"点击上传" forState:UIControlStateNormal];
    voucherUpBtn.titleLabel.font = [UIFont systemFontOfSize:12.0*kRate];
    voucherUpBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [voucherUpBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [voucherUpBtn setTitleColor:[UIColor colorWithWhite:0.8 alpha:1] forState:UIControlStateHighlighted];
    voucherUpBtn.titleEdgeInsets = UIEdgeInsetsMake(5*kRate, -voucherUpBtn.titleLabel.bounds.size.width - 85*kRate, 5*kRate, 20*kRate);
    
    
}

- (void)addVoucherUpBtnAction:(id)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancleAction];
    
    //从相册选取
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //NSLog(@"从相册选取");
        [self photosLibrary];
        
    }];
    [alertController addAction:cameraAction];
    
    //直接拍照
    UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //NSLog(@"直接拍照");
        [self takePhotos];
        
    }];
    [alertController addAction:takePhotoAction];
    
    [[self findResponderVC] presentViewController:alertController animated:YES completion:nil];
    
    UIPopoverPresentationController *popover = alertController.popoverPresentationController;
    if (popover) {
        popover.sourceView = sender;
        popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
    }
    
}

/*
 *  找到下一个控制器类型的响应者
 */
- (UIViewController *)findResponderVC
{
    UIResponder *responder_vc = (UIResponder *)self;
    do {
        responder_vc = responder_vc.nextResponder;
    } while (![responder_vc isKindOfClass:[UIViewController class]]);
    
    UIViewController *vc = (UIViewController *)responder_vc;
    
    return vc;
}

//从相册选取
- (void)photosLibrary
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        [[self findResponderVC] presentViewController:picker animated:YES completion:NULL];
    }
}

//直接拍照
- (void)takePhotos
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = YES;
        [[self findResponderVC] presentViewController:picker animated:YES completion:NULL];
    } else
    {
        NSLog(@"摄像头不可用");
    }
}





@end
