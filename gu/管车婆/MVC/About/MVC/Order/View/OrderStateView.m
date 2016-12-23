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

#pragma mark --- UIImagePickerControllerDelegate

//当完成图片获取时的操作
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    //上传图片至服务器
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    //UIImage *img1 = [self imageWithImageSimple:img scaledToSize:CGSizeMake(700, 700)];//对选取的图片进行大小上的压缩
    [self transportImgToServerWithImg:img];
    
}

//当取消图片获取时的操作
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"取消获取图片");
}

//按固定尺寸格式压缩图片
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

//上传图片至服务器后台
- (void)transportImgToServerWithImg:(UIImage *)img
{
    NSData *imageData;
    NSString *mimetype;
    if (UIImagePNGRepresentation(img) != nil) {
        mimetype = @"image/png";
        imageData = UIImagePNGRepresentation(img);
        
    }else{
        mimetype = @"image/jpeg";
        imageData = UIImageJPEGRepresentation(img, 1.0);
        
    }
    
    NSString *uploadUrl = [NSString stringWithFormat:@"http://%@/zcar/upload.do", kIP];
    
    NSDictionary *params = @{
                             @"optype":@"pzupload",
                             @"oid":self.orderModel.orderID,
                             @"km":@"666"
                             };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval =15;
    
    [manager POST:uploadUrl parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        /**
         *在网络开发中，上传文件时，是文件不允许被覆盖、文件重名
         *要解决此问题，
         *可以在上传时使用当前的系统时间作为文件名(当然如果有需要还可以拼接更多需要的比如用户ID)
         */
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat =@"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        //NSLog(@"当前时间%@", str);
        
        NSString *fileName = [[NSString alloc] init];
        if (UIImagePNGRepresentation(img) != nil) {
            
            fileName = [NSString stringWithFormat:@"%@.png", str];
            
        }else{
            
            fileName = [NSString stringWithFormat:@"%@.jpg", str];
            
        }
        
        // 上传图片，以文件流的格式
        /**
         *filedata : 图片的data
         *name     : 后台的提供的字段
         *mimeType : 类型
         */
        [formData appendPartWithFileData:imageData name:str fileName:fileName mimeType:mimetype];
        
    } progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //NSLog(@"凭证上传：%@", content);
        
        NSString *result = [content objectForKey:@"result"];
        
        if ([result isEqual:@"success"]) {
            
            NSLog(@"上传凭证成功");
            //把刚刚上传的凭证显示出来，两种方式，直接根据返回的url加载，或者刷新一下UI
            //给OrderInfoVC页面发送一个通知,刷新UI
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadOrderInfoView" object:self];
            
        } else {
            
            //弹框显示为什么上传凭证失败
            NSString *msg_title = [content objectForKey:@"errormsg"];
            [self showAlertWithTitle:msg_title];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"上传图片失败，失败原因是:%@", error);
        
    }];
}

- (void)showAlertWithTitle:(NSString *)title
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:@"您的凭证上传已超过限定时间，请联系客服解决" preferredStyle:UIAlertControllerStyleAlert];//上拉菜单样式
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];//好的按钮
    [alertController addAction:okAction];
    
    [[self findResponderVC] presentViewController:alertController animated:YES completion:nil];//这种弹出方式会在原来视图的背景下弹出一个视图。
}



@end
