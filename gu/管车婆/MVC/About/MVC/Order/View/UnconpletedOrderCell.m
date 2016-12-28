//
//  UnconpletedOrderCell.m
//  管车婆
//
//  Created by 李伟 on 16/12/28.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import "UnconpletedOrderCell.h"
#import "ItemAndCountView.h"

@interface UnconpletedOrderCell()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UIImageView         *_headImgView;//门店快照
    UILabel             *_nameLB;//店名
    UILabel             *_stateLabel;//交易状态
    UIView              *_line1;//第一条分割线
    ItemAndCountView    *_itemAndCountView;//服务项目和数量
    UILabel             *_orderWay;//下单方式
    UIView              *_line2;//第二条分割线
    UILabel             *_addressLB;//地址
    UIButton            *_navBtn;//导航按钮
    UIButton            *_phoneBtn;//电话按钮
    UIButton            *_oneMoreOrderBtn;//再来一单按钮
    UIButton            *_uoloadDocumentsBtn;//上传凭证按钮
}
@end

@implementation UnconpletedOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        //第一部分：头像、店名、交易状态、第一条分割线
        [self addFirstContent];
        
        //第二部分：服务项目、服务项目数量
        [self addSecondContent];
        
        //第三部分：下单方式、第二条分割线、地址、导航、电话、再来一单、评论
        [self addThirdContent];
        
    }
    
    return self;
}

//第一部分：头像、店名、交易状态、第一条分割线
- (void)addFirstContent
{
    _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10*kRate, 10*kRate, 50*kRate, 50*kRate)];
    _headImgView.layer.cornerRadius = 25*kRate;
    _headImgView.layer.masksToBounds = YES;
    [self.contentView addSubview:_headImgView];
    
    _line1 = [[UIView alloc] init];
    _line1.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
    [self.contentView addSubview:_line1];
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - CGRectGetMaxX(_headImgView.frame) + 5*kRate, 1*kRate));
        make.left.equalTo(_headImgView.mas_right).with.offset(5*kRate);
        make.top.equalTo(self.contentView).with.offset(10*kRate + 50*kRate/2);
    }];
    
    _nameLB = [[UILabel alloc] init];
    _nameLB.font = [UIFont systemFontOfSize:15.0*kRate];
    _nameLB.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_nameLB];
    [_nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200*kRate, 20*kRate));
        make.bottom.equalTo(_line1.mas_top).with.offset(-5*kRate);
        make.left.equalTo(_headImgView.mas_right).with.offset(6*kRate);
    }];
    
    _stateLabel = [[UILabel alloc] init];
    _stateLabel.font = [UIFont systemFontOfSize:13.0*kRate];
    _stateLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:_stateLabel];
    [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60*kRate, 20*kRate));
        make.right.equalTo(self.contentView).with.offset(-30*kRate);
        make.bottom.equalTo(_line1.mas_top).with.offset(-5*kRate);
    }];
}


//第二部分：服务项目、服务项目数量
- (void)addSecondContent
{
    //服务项目及其数量
    
    _itemAndCountView = [[ItemAndCountView alloc] init];
    [self.contentView addSubview:_itemAndCountView];
    
    
    //下单方式，或者预约时间
    _orderWay = [[UILabel alloc] init];
    _orderWay.textAlignment = NSTextAlignmentRight;
    _orderWay.font = [UIFont systemFontOfSize:13.0*kRate];
    [self.contentView addSubview:_orderWay];
    [_orderWay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 10*kRate, 20*kRate));
        make.top.equalTo(_itemAndCountView.mas_bottom).with.offset(10*kRate);
        make.right.equalTo(self.contentView).with.offset(-10*kRate);
    }];
    
    
}


//第三部分：第二条分割线、地址、导航、电话、再来一单、评论
- (void)addThirdContent
{
    _line2 = [[UILabel alloc] init];
    _line2.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
    [self.contentView addSubview:_line2];
    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 1*kRate));
        make.top.equalTo(_orderWay.mas_bottom).with.offset(5*kRate);
        
    }];
    
    _addressLB = [[UILabel alloc] init];
    _addressLB.font = [UIFont systemFontOfSize:12*kRate];
    _addressLB.adjustsFontSizeToFitWidth = YES;
    _addressLB.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    [self.contentView addSubview:_addressLB];
    [_addressLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(140*kRate, 22*kRate));
        make.left.equalTo(self.contentView).with.offset(15*kRate);
        make.top.equalTo(_line2.mas_bottom).with.offset(8*kRate);
    }];
    
    _navBtn = [[UIButton alloc] init];
    [_navBtn addTarget:self action:@selector(navBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_navBtn setImage:[UIImage imageNamed:@"about_order_nav"] forState:UIControlStateNormal];
    _navBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 33*kRate);
    [_navBtn setTitle:@"导航" forState:UIControlStateNormal];
    _navBtn.titleLabel.font = [UIFont systemFontOfSize:13.0*kRate];
    [_navBtn setTitleColor:[UIColor colorWithWhite:0.2 alpha:1] forState:UIControlStateNormal];
    _navBtn.titleEdgeInsets = UIEdgeInsetsMake(2*kRate, -_navBtn.titleLabel.bounds.size.width - 30*kRate, 0, 0);
    [self.contentView addSubview:_navBtn];
    [_navBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50*kRate, 22*kRate));
        make.left.equalTo(_addressLB.mas_right).with.offset(5*kRate);
        make.top.equalTo(_line2.mas_bottom).with.offset(8*kRate);
    }];
    
    _phoneBtn = [[UIButton alloc] init];
    [_phoneBtn addTarget:self action:@selector(phoneBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_phoneBtn setImage:[UIImage imageNamed:@"about_order_phone"] forState:UIControlStateNormal];
    [self.contentView addSubview:_phoneBtn];
    [_phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20*kRate, 22*kRate));
        make.left.equalTo(_navBtn.mas_right).with.offset(20*kRate);
        make.top.equalTo(_line2.mas_bottom).with.offset(8*kRate);
    }];
    
    _uoloadDocumentsBtn = [[UIButton alloc] init];
    [_uoloadDocumentsBtn addTarget:self action:@selector(uploadDocumentsBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_uoloadDocumentsBtn setImage:[UIImage imageNamed:@"about_order_camera"] forState:UIControlStateNormal];
    [self.contentView addSubview:_uoloadDocumentsBtn];
    [_uoloadDocumentsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(26*kRate, 22*kRate));
        make.right.equalTo(self.contentView).with.offset(-15*kRate);
        make.top.equalTo(_line2.mas_bottom).with.offset(8*kRate);
    }];
    
    _oneMoreOrderBtn = [[UIButton alloc] init];
    [_oneMoreOrderBtn addTarget:self action:@selector(oneMoreOrderBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_oneMoreOrderBtn setBackgroundImage:[UIImage imageNamed:@"about_order_oneMoreOrder"] forState:UIControlStateNormal];
    [_oneMoreOrderBtn setBackgroundImage:[UIImage imageNamed:@"about_order_oneMoreOrder_selected"] forState:UIControlStateHighlighted];
    [_oneMoreOrderBtn setTitle:@"再来一单" forState:UIControlStateNormal];
    _oneMoreOrderBtn.titleLabel.font = [UIFont systemFontOfSize:13.0*kRate];
    [_oneMoreOrderBtn setTitleColor:[UIColor colorWithWhite:0.3 alpha:1] forState:UIControlStateNormal];
    [_oneMoreOrderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.contentView addSubview:_oneMoreOrderBtn];
    [_oneMoreOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60*kRate, 22*kRate));
        make.right.equalTo(_uoloadDocumentsBtn.mas_left).with.offset(-15*kRate);
        make.top.equalTo(_line2.mas_bottom).with.offset(8*kRate);
    }];
}


- (void)setOrderModel:(OrderModel *)orderModel
{
    _orderModel = orderModel;
    
    [_headImgView sd_setImageWithURL:self.orderModel.headImgUrl placeholderImage:[UIImage imageNamed:@"about_order_head"]];
    _nameLB.text = self.orderModel.nameStr;
    _stateLabel.text = self.orderModel.state;
    _orderWay.text = [NSString stringWithFormat:@"下单方式：%@", self.orderModel.orderWay];
    _addressLB.text = self.orderModel.addressStr;
    
    _itemAndCountView.items = _orderModel.items;
    [_itemAndCountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 10*kRate - 50*kRate - 6*kRate - 30*kRate, 20*kRate * _orderModel.items.count));
        make.top.equalTo(_line1.mas_bottom).with.offset(5*kRate);
        make.left.equalTo(_headImgView.mas_right).with.offset(6*kRate);
    }];
    
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 10*kRate;
    
    [super setFrame:frame];
}

#pragma mark ButtonAction
//导航
- (void)navBtnAction
{
    NSLog(@"导航");
}

//电话
- (void)phoneBtnAction
{
    NSLog(@"电话");
}

//再来一单
- (void)oneMoreOrderBtnAction
{
    NSLog(@"再来一单");
}

#pragma mark --- 上传凭证BtnAction
- (void)uploadDocumentsBtnAction:(id)sender
{
    NSLog(@"上传凭证");
    
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
    
    [self.vc presentViewController:alertController animated:YES completion:nil];
    
    UIPopoverPresentationController *popover = alertController.popoverPresentationController;
    if (popover) {
        popover.sourceView = sender;
        popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
    }
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
        [self.vc presentViewController:picker animated:YES completion:NULL];
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
        [self.vc presentViewController:picker animated:YES completion:NULL];
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
    
    [self.vc presentViewController:alertController animated:YES completion:nil];//这种弹出方式会在原来视图的背景下弹出一个视图。
}


@end
