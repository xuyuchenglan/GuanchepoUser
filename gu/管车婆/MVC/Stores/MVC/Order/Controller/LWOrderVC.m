//
//  LWOrderVC.m
//  管车婆
//
//  Created by 李伟 on 16/12/12.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import "LWOrderVC.h"
#import "AppointOrderView.h"
#import "SYQRCodeViewController.h"
#import "QRCodeView.h"
#import "LewPopupViewController.h"
#import "EnterVerificationCodeView.h"


#define kLeftEdge  30*kRate
#define kEnterVerificationCodeViewWidth (kScreenWidth-kLeftEdge*2)
#define kSubmitBtnWidth 111*kRate
#define kEdgeWidth (kScreenWidth - 300)/4

@interface LWOrderVC ()<UITextFieldDelegate>
{
    AppointOrderView *_appointOrderView;
    QRCodeView *_qrcodeView;//生成的二维码所在的视图
    UIImageView *_qrCodeImgView;//生成的二维码视图（UIImageView）
    UITextField *_enterVerificationTF;//输入验证码的textField
}
@property (nonatomic, strong)UIView          *qrView;//装载扫描生成二维码按钮的view

@end

@implementation LWOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self addNavBar];
    
    //设置下方的内容视图
    [self addContentView];
}

#pragma mark ******  设置导航栏  ******
- (void)addNavBar
{
    self.view.backgroundColor = kRGBColor(233, 233, 233);
    
    [self setBackButtonWithImageName:@"back"];
    [self setNavigationItemTitle:@"下单"];
}

#pragma mark ******  设置下方的内容视图  ******
- (void)addContentView
{
    //店铺大头照
    UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 225*kRate)];
    [headImgView sd_setImageWithURL:_storeModel.headUrl placeholderImage:[UIImage imageNamed:@"stores_headImg"] options:SDWebImageRefreshCached];
    [self.view addSubview:headImgView];
    
    //店铺各种详细信息
    _appointOrderView = [[AppointOrderView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headImgView.frame), kScreenWidth, 140)];
    _appointOrderView.storeModel = _storeModel;
    [self.view addSubview:_appointOrderView];
    
    //二维码、验证码
    [self addQR];
    
    //注意事项
    [self addMettersNeedingAttention];

}

#pragma  mark --  二维码、验证码
- (void)addQR
{
    _qrView = [[UIView alloc] init];
    _qrView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_qrView];
    [_qrView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 100));
        make.left.equalTo(self.view).with.offset(0);
        make.top.equalTo(_appointOrderView.mas_bottom).with.offset(10);
    }];
    
    //扫描商家二维码
    [self scanQR];
    
    //生成客户二维码
    [self createQR];
    
    //输入商户验证码
    [self enterYanzhengma];
}

//扫描商家二维码
- (void)scanQR
{
    UIButton *scanQRBtn = [[UIButton alloc] initWithFrame:CGRectMake(kEdgeWidth, 0, 100, 100)];
    [scanQRBtn addTarget:self action:@selector(scanQRBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [scanQRBtn setImage:[UIImage imageNamed:@"scanQR"] forState:UIControlStateNormal];
    scanQRBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 25, 40, 25);
    
    [scanQRBtn setTitle:@"扫描商家二维码" forState:UIControlStateNormal];
    scanQRBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    scanQRBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [scanQRBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    scanQRBtn.titleEdgeInsets = UIEdgeInsetsMake(70, -scanQRBtn.titleLabel.bounds.size.width - 130, 20, 0);
    
    [_qrView addSubview:scanQRBtn];
}



//生成客户二维码
- (void)createQR
{
    UIButton *createQRBtn = [[UIButton alloc] initWithFrame:CGRectMake(kEdgeWidth*2 + 100, 0, 100, 100)];
    [createQRBtn addTarget:self action:@selector(createQRBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [createQRBtn setImage:[UIImage imageNamed:@"createQR"] forState:UIControlStateNormal];
    createQRBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 25, 40, 25);
    
    [createQRBtn setTitle:@"生成客户二维码" forState:UIControlStateNormal];
    createQRBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    createQRBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [createQRBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    createQRBtn.titleEdgeInsets = UIEdgeInsetsMake(70, -createQRBtn.titleLabel.bounds.size.width - 145, 20, 0);
    
    [_qrView addSubview:createQRBtn];
    
}

//输入商户手机验证码
- (void)enterYanzhengma
{
    UIButton *enterYanzhengmaBtn = [[UIButton alloc] initWithFrame:CGRectMake(kEdgeWidth*3 + 200, 0, 100, 100)];
    [enterYanzhengmaBtn addTarget:self action:@selector(enterYanzhengmaBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [enterYanzhengmaBtn setImage:[UIImage imageNamed:@"yanzhengma"] forState:UIControlStateNormal];
    enterYanzhengmaBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 25, 40, 25);
    
    [enterYanzhengmaBtn setTitle:@"输入商户验证码" forState:UIControlStateNormal];
    enterYanzhengmaBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    enterYanzhengmaBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [enterYanzhengmaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    enterYanzhengmaBtn.titleEdgeInsets = UIEdgeInsetsMake(70, -enterYanzhengmaBtn.titleLabel.bounds.size.width - 150, 20, 0);
    
    [_qrView addSubview:enterYanzhengmaBtn];
    
}

#pragma mark ------ <1>扫描商家二维码，并进行网络下单
//扫描商家二维码
- (void)scanQRBtnAction
{
    NSLog(@"扫描商家二维码");
    
    //扫描二维码
    SYQRCodeViewController *qrcodevc = [[SYQRCodeViewController alloc] init];
    qrcodevc.SYQRCodeSuncessBlock = ^(SYQRCodeViewController *aqrvc,NSString *qrString){
        
        NSLog(@"扫描成功");
        
        //进行网络下单
        [self createOrderNetworkRequestWithQRString:qrString];
        
        [aqrvc dismissViewControllerAnimated:NO completion:nil];
        
    };
    qrcodevc.SYQRCodeFailBlock = ^(SYQRCodeViewController *aqrvc){
        
        NSLog(@"扫描失败");
        [aqrvc dismissViewControllerAnimated:NO completion:nil];
        
    };
    qrcodevc.SYQRCodeCancleBlock = ^(SYQRCodeViewController *aqrvc){
        
        NSLog(@"扫描取消");
        [aqrvc dismissViewControllerAnimated:NO completion:nil];
        
    };
    [self presentViewController:qrcodevc animated:YES completion:nil];
    
}


//扫描成功后，进行网络下单
- (void)createOrderNetworkRequestWithQRString:(NSString *)qrString
{
    NSLog(@"网络下单");
    
    //截取扫描到的客户二维码的字符串,获取到mid、pictime
    NSString *bodyStr = [qrString substringFromIndex:28];
    NSArray *arr = [bodyStr componentsSeparatedByString:@","];//根据逗号截取字符串
    NSString *mID = arr[0];
    NSString *pictime = arr[1];
    
    //获取到存储在本地的uid、uname、uphone
    NSString *uid = [[self getLocalDic] objectForKey:@"uid"];
    NSString *uname = [[self getLocalDic] objectForKey:@"realname"];
    NSString *uphone = [[self getLocalDic] objectForKey:@"phone"];
    NSString *cartype = [[self getLocalDic] objectForKey:@"cartype"];
    
    //发起网络请求，进行下单
    NSString *url_post = [NSString stringWithFormat:@"http://%@createOrder.action", kHead];
    
    NSDictionary *params = @{
                             @"uid":uid,//用户id
                             @"mid":mID,//商户id
                             @"otype":@"2",//1预约订单，2正式订单，写死传2
                             @"superid":_sid,//一级服务id,sid
                             @"urealname":uname,//用户名字
                             @"uphone":uphone,//用户电话
                             @"oway":@"1",//下单方式，写死传1（用户扫码）
                             @"cartype":cartype,
                             @"pictime":pictime//二维码时间
                             };
    
    NSLog(@"%@?uid=%@&mid=%@&otype=2&superid=%@&mname=%@&mphone=%@&oway=2&pictime=%@", url_post, uid, mID, _sid, uname, uphone, pictime);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = responseSerializer;
    
    [manager POST:url_post parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"下单，请求下来的Json格式的数据是%@", content);
        
        NSString *result = [content objectForKey:@"result"];
        if ([result isEqual:@"success"]) {
            
            //提示下单成功
            [self showAlertViewWithTitle:@"下单成功" WithMessage:nil];
            
        } else if ([result isEqual:@"fail"]) {
            
            //提示下单失败，将errormsg显示出来
            NSString *errMsg = [content objectForKey:@"errormsg"];
            [self showAlertViewWithTitle:@"下单失败" WithMessage:errMsg];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败， 失败原因是：%@", error);
    }];
    
    
}


#pragma mark ------ <2>生成客户二维码，改变二维码颜色~
//生成客户二维码
- (void)createQRBtnAction
{
    NSLog(@"生成客户二维码");
    
    /* 装有二维码以及上下两个label的视图 */
    _qrcodeView = [[QRCodeView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 110, 80, 220, 260)];
    _qrcodeView.image = [UIImage imageNamed:@"createQR_bg"];
    _qrcodeView.parentVC = self;
    [self lew_presentPopupView:_qrcodeView animation:[LewPopupViewAnimationFade new]  dismissed:^{
        NSLog(@"生成二维码结束");
    }];
    
    /* 生成二维码 */
    //二维码的位置、大小
    _qrCodeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 47, 180, 180)];
    [_qrcodeView addSubview:_qrCodeImgView];
    
    //因为生成的二维码是一个CIImage，我们直接转换成UIImage的话大小不好控制，所以使用createNonInterpolatedUIImageFormCIImage:方法返回需要大小的UIImage：
    NSString *qrStr = [self creatQRStr];
    UIImage *qrcode = [self createNonInterpolatedUIImageFormCIImage:[self createQRForString:qrStr] withSize:250.0f];
    
    //改变二维码的颜色
    UIImage *customQrcode = [self imageBlackToTransparent:qrcode withRed:0.0f andGreen:0.0f andBlue:0.0f];
    
    _qrCodeImgView.image = customQrcode;
    
    /* 上面的实效label */
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 220, 20)];
    timeLabel.text = @"二维码时效：30分钟";
    timeLabel.textColor = [UIColor whiteColor];
    timeLabel.font = [UIFont systemFontOfSize:14.0];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    [_qrcodeView addSubview:timeLabel];
    
    /* 下面的提示label */
    UILabel *tishiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_qrCodeImgView.frame) + 8, 220, 15)];
    tishiLabel.text = @"扫描二维码进行下单";
    tishiLabel.textColor = [UIColor whiteColor];
    tishiLabel.font = [UIFont systemFontOfSize:12.0];
    tishiLabel.textAlignment = NSTextAlignmentCenter;
    [_qrcodeView addSubview:tishiLabel];
    

}

//生成用户二维码需要传入的字符串
- (NSString *)creatQRStr
{
    NSString *head = @"jnzddevqrcode-com.gcp0534://";
    
    NSString *uid = [[self getLocalDic] objectForKey:@"uid"];
    
    NSString *superID = @"*1*";
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    
    NSString *qrStr = [NSString stringWithFormat:@"%@%@,%@,%@", head, uid, superID, dateString];
    NSLog(@"%@", qrStr);
    
    return qrStr;
}


//因为生成的二维码是一个CIImage，我们直接转换成UIImage的话大小不好控制，所以使用下面方法返回需要大小的UIImage：
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // create a bitmap image that we'll draw into a bitmap context at the desired size;  (创建bitmap;)
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // Create an image with the contents of our bitmap  (保存bitmap到图片)
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    // Cleanup
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

//首先是二维码的生成，使用CIFilter很简单，直接传入生成二维码的字符串即可：
- (CIImage *)createQRForString:(NSString *)qrString {
    
    // Need to convert the string to a UTF-8 encoded NSData object
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    
    // Create the filter 创建filter
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // Set the message content and error-correction level  设置内容和纠错级别
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    
    // Send the image back   返回CIImage
    return qrFilter.outputImage;
}

//生成的二维码是黑白的，如果需要改变二维码的颜色，那么还需要对二维码进行颜色填充，并转换为透明背景，使用遍历图片像素来更改图片颜色，因为使用的是CGContext，速度非常快：
void ProviderReleaseData (void *info, const void *data, size_t size){
    free((void*)data);
}
- (UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue{
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t      bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    // create context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    // traverse pixe (遍历像素)
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900){  //// 将白色变成透明
            // change color (改成下面的代码，会将图片转成想要的颜色)
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red; //0~255
            ptr[2] = green;
            ptr[1] = blue;
        }else{
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    // context to image (输出图片)
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    // release (清理空间)
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
}



#pragma mark ------ <3>输入验证码~
//输入商户手机验证码下单
- (void)enterYanzhengmaBtnAction
{
    NSLog(@"输入商户手机验证码");
    
    /* 装有二维码以及上下两个label的视图 */
    EnterVerificationCodeView *enterVerificationCodeView = [[EnterVerificationCodeView alloc] initWithFrame:CGRectMake(kLeftEdge, 150*kRate, kEnterVerificationCodeViewWidth, kEnterVerificationCodeViewWidth*0.571)];
    enterVerificationCodeView.image = [UIImage imageNamed:@"enterVerificationCode"];
    enterVerificationCodeView.layer.cornerRadius = 5.0*kRate;
    enterVerificationCodeView.userInteractionEnabled = YES;
    enterVerificationCodeView.parentVC = self;
    [self lew_presentPopupView:enterVerificationCodeView animation:[LewPopupViewAnimationFade new] dismissed:^{
        NSLog(@"生成手机验证码结束");
    }];
    
    /* 上面的titleLabel */
    UILabel *upLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15*kRate, kEnterVerificationCodeViewWidth, 20*kRate)];
    upLabel.text = @"请输入商家生成的验证码，完成下单~😁";
    upLabel.font = [UIFont systemFontOfSize:16.0*kRate];
    upLabel.textColor = [UIColor whiteColor];
    upLabel.textAlignment = NSTextAlignmentCenter;
    [enterVerificationCodeView addSubview:upLabel];
    
    /* 中间的输入验证码的TextField */
    _enterVerificationTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 50*kRate, kEnterVerificationCodeViewWidth, 60*kRate)];
    _enterVerificationTF.placeholder = @"点击此处输入验证码";
    _enterVerificationTF.delegate = self;
    _enterVerificationTF.returnKeyType = UIReturnKeyDone;
    _enterVerificationTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _enterVerificationTF.keyboardType = UIKeyboardTypeNumberPad;
    _enterVerificationTF.textAlignment = NSTextAlignmentCenter;
    _enterVerificationTF.font = [UIFont systemFontOfSize:30.0*kRate];
    [enterVerificationCodeView addSubview:_enterVerificationTF];

    
    /* 下面的确定按钮 */
    UIButton *submitBtn = [[UIButton alloc] initWithFrame:CGRectMake((kEnterVerificationCodeViewWidth - kSubmitBtnWidth)/2, 135*kRate, kSubmitBtnWidth, kSubmitBtnWidth*0.4)];
    [submitBtn addTarget:self action:@selector(submitBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn setImage:[UIImage imageNamed:@"enterVerificationCodeSubmit"] forState:UIControlStateNormal];
    [enterVerificationCodeView addSubview:submitBtn];
}

        //确定按钮Action
- (void)submitBtnAction
{
    [self.view endEditing:YES];
    
    if (_enterVerificationTF.text.length > 0) {
        
        //获取到存储在本地的uid、uname、uphone
        NSString *uid = [[self getLocalDic] objectForKey:@"uid"];
        NSString *uname = [[self getLocalDic] objectForKey:@"realname"];
        NSString *uphone = [[self getLocalDic] objectForKey:@"phone"];
        
        //发起网络请求，进行下单
        NSString *url_post = [NSString stringWithFormat:@"http://%@createOrder.action", kHead];
        
        NSDictionary *params = @{
                                 @"uid":uid,//用户id
                                 @"mid":_storeModel.mid,//商户id
                                 @"otype":@"2",//1预约订单，2正式订单，写死传2
                                 @"superid":_sid,//一级服务id,sid
                                 @"urealname":uname,//用户名字
                                 @"uphone":uphone,//用户电话
                                 @"oway":@"3",//下单方式，写死传3（用户输入验证码）
                                 @"ordercode":_enterVerificationTF.text//商户下单码，用户输入验证码下单的时候传递，其他不传递
                                 };
        
//        NSLog(@"%@?uid=%@&mid=%@&otype=2&superid=%@&mname=%@&mphone=%@&oway=3&ordercode=%@", url_post, uid, _storeModel.mid, _sid, uname, uphone, _enterVerificationTF.text);
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer = responseSerializer;
        
        [manager POST:url_post parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"下单，请求下来的Json格式的数据是%@", content);
            
            NSString *result = [content objectForKey:@"result"];
            if ([result isEqual:@"success"]) {
                
                //提示下单成功
                [self showAlertViewWithTitle:@"下单成功" WithMessage:@"请到“我的-我的订单”页面查看您的订单详细信息"];
                [self lew_dismissPopupView];//隐藏输入验证码页面，防止重复下单
                
            } else if ([result isEqual:@"fail"]) {
                
                //提示下单失败，将errormsg显示出来
                NSString *errMsg = [content objectForKey:@"errormsg"];
                [self showAlertViewWithTitle:@"下单失败" WithMessage:errMsg];
                
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"请求失败， 失败原因是：%@", error);
        }];
        
    } else {
        [self showAlertViewWithTitle:@"提示" WithMessage:@"请输入您的验证码"];
    }
    
}


#pragma  mark --  注意事项
- (void)addMettersNeedingAttention
{
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    [self.view addSubview:label];
    label.attributedText = [self getAttributedStringWithTitleOne:@"下单注意事项：" Desc1:@"1.下单生成的二维码或者扫描商户的二维码都需要在两个小时内完成，否则二维码失效；" Desc2:@"2.提成会记入您的余额当中，您可进行提现；" Desc3:@"3.提现金额3-5个工作日内打入您的账户。"];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-60, 120));
        make.left.equalTo(self.view).with.offset(30);
        make.top.equalTo(_qrView.mas_bottom).with.offset(10);
    }];
}

-(NSMutableAttributedString *)getAttributedStringWithTitleOne:(NSString *)title Desc1:(NSString *)desc1 Desc2:(NSString *)desc2 Desc3:(NSString *)desc3
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5.0];//调整行间距
    
    NSMutableAttributedString *mutaTitle = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",title] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor blackColor],NSParagraphStyleAttributeName:paragraphStyle}];
    
    NSMutableAttributedString *mutaDesc1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",desc1] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor colorWithWhite:0.4 alpha:1],NSParagraphStyleAttributeName:paragraphStyle}];
    
    NSMutableAttributedString *mutaDesc2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",desc2] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor colorWithWhite:0.4 alpha:1],NSParagraphStyleAttributeName:paragraphStyle}];
    
    NSMutableAttributedString *mutaDesc3 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",desc3] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor colorWithWhite:0.4 alpha:1],NSParagraphStyleAttributeName:paragraphStyle}];
    
    [mutaTitle appendAttributedString:mutaDesc1];
    [mutaTitle appendAttributedString:mutaDesc2];
    [mutaTitle appendAttributedString:mutaDesc3];
    
    return mutaTitle;
    
}

@end
