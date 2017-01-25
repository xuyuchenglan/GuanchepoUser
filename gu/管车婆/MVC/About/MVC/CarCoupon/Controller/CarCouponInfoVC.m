//
//  CarCouponInfoVC.m
//  管车婆
//
//  Created by 李伟 on 17/1/12.
//  Copyright © 2017年 远恒网络科技有限公司. All rights reserved.
//

#import "CarCouponInfoVC.h"
#import "CarCouponMoreView.h"

@interface CarCouponInfoVC ()
{
    UIImageView *_qrCodeImgView;//生成的二维码视图（UIImageView）
}
@end

@implementation CarCouponInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kRGBColor(248, 249, 250);
    
    //导航栏
    [self setNavigationItemTitle:_carCouponModel.name];
    [self setBackButtonWithImageName:@"back"];
    
    //下面的内容视图
    [self addContentView];
    
}

#pragma mark ****** 下面的内容视图 ******
- (void)addContentView
{
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30*kRate, 64+10*kRate, kScreenWidth - 40*kRate, 20*kRate)];
    titleLabel.text = @"汽车券详情";
    titleLabel.font = [UIFont systemFontOfSize:15.0*kRate];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:titleLabel];
    
    //内容
    CarCouponMoreView *contentView = [[CarCouponMoreView alloc] initWithFrame:CGRectMake(0, 64+40*kRate, kScreenWidth, 205*kRate)];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.carCouponModel = _carCouponModel;
    [self.view addSubview:contentView];
    
    //汽车券下单二维码
    [self addQRView];
}

//汽车券下单二维码
- (void)addQRView
{
    //提示label
    UILabel *noticeLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 365*kRate, kScreenWidth, 20*kRate)];
    noticeLB.textAlignment = NSTextAlignmentCenter;
    noticeLB.text = @"请向商家出示该二维码以完成下单";
    noticeLB.font = [UIFont systemFontOfSize:15*kRate];
    noticeLB.textColor = [UIColor colorWithWhite:0.5 alpha:1];
    [self.view addSubview:noticeLB];
    
    //二维码的位置、大小
    _qrCodeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2-90*kRate, 400*kRate, 180*kRate, 180*kRate)];
    [self.view addSubview:_qrCodeImgView];
    
    //因为生成的二维码是一个CIImage，我们直接转换成UIImage的话大小不好控制，所以使用createNonInterpolatedUIImageFormCIImage:方法返回需要大小的UIImage：
    NSString *qrStr = _carCouponModel.ewm;
    UIImage *qrcode = [self createNonInterpolatedUIImageFormCIImage:[self createQRForString:qrStr] withSize:250.0f];
    
    _qrCodeImgView.image = qrcode;

}

//首先是二维码的生成，使用CIFilter很简单，直接传入生成二维码的字符串即可：
- (CIImage *)createQRForString:(NSString *)qrString {
    
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    
    return qrFilter.outputImage;
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

@end
