//
//  UIImage+Extension.h
//  WYBasisKit
//
//  Created by jacke－xu on 16/9/4.
//  Copyright © 2016年 jacke-xu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GradientType) {
    
    GradientTypeTopToBottom      = 0,//从上到小
    GradientTypeLeftToRight      = 1,//从左到右
    GradientTypeUpleftToLowright = 2,//左上到右下
    GradientTypeUprightToLowleft = 3,//右上到左下
};

@interface UIImage (Extension)

/**
 *  获取图片宽
 */
- (CGFloat)width;

/**
 *  获取图片高
 */
- (CGFloat)height;

/**
 *  获取启动页图片
 *
 *  @return 启动页图片
 */
+ (UIImage *)launchImage;

/**
 *  加载非.Bound文件下图片，单张、或2x、3x均适用(若加载非png图片需要拼接后缀名)
 *
 *  @param image 图片名
 */
+ (UIImage *)loadImage:(NSString *)image;

/**
 *  加载.Bound文件下图片(无子文件夹，若加载非png图片需要拼接后缀名)
 *
 *  @param image 图片名
 */
+ (UIImage *)bundleImage:(NSString *)image;

/**
 *  加载.Bound文件下子文件夹图片(若加载非png图片需要拼接后缀名)
 *
 *  @param fileName 图片文件夹名
 *
 *  @param fileImage 图片名
 */
+ (UIImage *)fileImage:(NSString *)fileImage fileName:(NSString *)fileName;

/** 字符串转图片 */
+ (UIImage *)base64StrToUIImage:(NSString *)encodedImageStr;

/** 图片转字符串 */
+ (NSString *)imageToBase64Str:(UIImage *)image;

/**
 *  图片切割
 *
 *  @param image  要切割的图片
 *  @param imageSize 边框的宽度
 *
 *  @return 切割好的图片
 */
+ (UIImage *)cutImage:(UIImage*)image andSize:(CGSize)imageSize;

/**
 *  根据url返回一个圆形的头像
 *
 *  @param iconUrl 头像的URL
 *  @param border  边框的宽度
 *  @param color   边框的颜色
 *
 *  @return 切割好的头像
 */
+ (UIImage *)captureCircleImageWithURL:(NSString *)iconUrl andBorderWith:(CGFloat)border andBorderColor:(UIColor *)color;

/**
 *  根据iamge返回一个圆形的头像
 *
 *  @param iconImage 要切割的头像
 *  @param border    边框的宽度
 *  @param color     边框的颜色
 *
 *  @return 切割好的头像
 */
+ (UIImage *)captureCircleImageWithImage:(UIImage *)iconImage andBorderWith:(CGFloat)border andBorderColor:(UIColor *)color;

/**
 *  生成毛玻璃效果的图片
 *
 *  @param image      要模糊化的图片
 *  @param blurAmount 模糊化指数
 *
 *  @return 返回模糊化之后的图片
 */
+ (UIImage *)blurredImageWithImage:(UIImage *)image andBlurAmount:(CGFloat)blurAmount;

/**
 *  截取相应的view生成一张图片
 *
 *  @param view 要截的view
 *
 *  @return 生成的图片
 */
+ (UIImage *)viewShotWithView:(UIView *)view;

/**
 *  截屏
 *
 *  @return 返回截屏的图片
 */
+ (UIImage *)screenShot;

/**
 *  图片进行压缩
 *
 *  @param image   要压缩的图片
 *  @param percent 要压缩的比例(建议在0.3以上)
 *
 *  @return 压缩之后的图片
 *
 *  @exception 压缩之后为image/jpeg 格式
 */
+ (UIImage *)reduceImage:(UIImage *)image percent:(float)percent;

/**
 *  对图片进行压缩
 *
 *  @param image   要压缩的图片
 *  @param newSize 压缩后的图片的像素尺寸
 *
 *  @return 压缩好的图片
 */
+ (UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;

/**
 *  对图片进行压缩
 *
 *  @param image   要压缩的图片
 *  @param kb 压缩后的图片的内存大小
 *
 *  @return 压缩好的图片
 */
+ (UIImage *)imageWithImageSimple:(UIImage*)image scaledToKB:(NSInteger)kb;

/**
 *  对图片进行压缩
 *
 *  @param image   要压缩的图片
 *  @param maxLength 压缩后的图片的内存大小
 *
 *  @return 压缩好的图片
 */
+ (UIImage *)compressImage:(UIImage *)image toByte:(NSInteger)maxLength;

/**
 *  生成一个毛玻璃效果的图片
 *
 *  @return 返回模糊化好的图片
 */
- (UIImage *)blurredImage:(CGFloat)blurAmount;

/**
 *  生成一个毛玻璃效果的图片
 *
 *  @param blurLevel 毛玻璃的模糊程度
 *
 *  @return 毛玻璃好的图片
 */
- (UIImage *)blearImageWithBlurLevel:(CGFloat)blurLevel;

/** 根据给定的url计算网络图片的大小*/
+ (CGSize)downloadImageSizeWithURL:(id)imageURL;

/** 根据视频url获取第一帧图片*/
+ (UIImage *)videoPreViewImage:(NSURL *)path;

/** 根据给定的颜色生成图片*/
+ (UIImage *)createImage:(UIColor *)imageColor;

/**
 通过渐变色生成图片
 
 @param colors 渐变颜色数组
 @param gradientType 渐变类型
 @param imageSize 需要的图片尺寸
 
 */
+ (UIImage *)imageFromGradientColors:(NSArray *)colors gradientType:(GradientType)gradientType imageSize:(CGSize)imageSize;

/**
 对比两张图片是否相同
 
 @param image 原图
 @param anotherImage 需要比较的图片
 
 */
+ (BOOL)imageEqualToImage:(UIImage*)image anotherImage:(UIImage *)anotherImage;

/**
 图片透明度
 
 @param alpha 透明度
 @param image 原图
 
 */
+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image;

/**
 镶嵌图片
 
 @param firstImage 图片1
 @param secondImage 图片2
 @return 拼接后的图片
 */
+ (UIImage *)spliceFirstImage:(UIImage *)firstImage secondImage:(UIImage *)secondImage;

/**
 生成二维码图片
 
 @param dataDic 二维码中的信息
 @param size 二维码Size
 @param waterImage 水印图片
 @return 一个二维码图片，水印在二维码中央
 */
+ (UIImage *)qrCodeImageForDataDic:(NSDictionary *)dataDic size:(CGSize)size waterImage:(UIImage *)waterImage;

/**
 修改二维码颜色
 
 @param image 二维码图片
 @param red red
 @param green green
 @param blue blue
 @return 修改颜色后的二维码图片
 */
+ (UIImage *)changeColorWithQRCodeImage:(UIImage *)image red:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue;

@end
