//
//  UIImage+Extension.h
//  WYBasisKit
//
//  Created by jacke－xu on 16/9/4.
//  Copyright © 2016年 jacke-xu. All rights reserved.
//

#import <UIKit/UIKit.h>

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
+ (UIImage *)Base64StrToUIImage:(NSString *)encodedImageStr;

/** 图片转字符串 */
+ (NSString *)ImageToBase64Str:(UIImage *)image;

/**
 *  拉伸图片
 *
 *  @param name 图片名字
 *
 *  @return 拉伸好的图片
 */
+ (UIImage *)hd_resizedImageWithImageName:(NSString *)name;

/**
 *  拉伸图片
 *
 *  @param image 要拉伸的图片
 *
 *  @return 拉伸好的图片
 */
+ (UIImage *)hd_resizedImageWithImage:(UIImage *)image;

/**
 *  返回一个缩放好的图片
 *
 *  @param image  要切割的图片
 *  @param imageSize 边框的宽度
 *
 *  @return 切割好的图片
 */
+ (UIImage *)hd_cutImage:(UIImage*)image andSize:(CGSize)imageSize;

/**
 *  返回一个下边有半个红圈的原型头像
 *
 *  @param image  要切割的图片
 *
 *  @return 切割好的头像
 */
+ (UIImage *)hd_captureCircleImage:(UIImage*)image;

/**
 *  根据url返回一个圆形的头像
 *
 *  @param iconUrl 头像的URL
 *  @param border  边框的宽度
 *  @param color   边框的颜色
 *
 *  @return 切割好的头像
 */
+ (UIImage *)hd_captureCircleImageWithURL:(NSString *)iconUrl andBorderWith:(CGFloat)border andBorderColor:(UIColor *)color;

/**
 *  根据iamge返回一个圆形的头像
 *
 *  @param iconImage 要切割的头像
 *  @param border    边框的宽度
 *  @param color     边框的颜色
 *
 *  @return 切割好的头像
 */
+ (UIImage *)hd_captureCircleImageWithImage:(UIImage *)iconImage andBorderWith:(CGFloat)border andBorderColor:(UIColor *)color;

/**
 *  生成毛玻璃效果的图片
 *
 *  @param image      要模糊化的图片
 *  @param blurAmount 模糊化指数
 *
 *  @return 返回模糊化之后的图片
 */
+ (UIImage *)hd_blurredImageWithImage:(UIImage *)image andBlurAmount:(CGFloat)blurAmount;

/**
 *  截取相应的view生成一张图片
 *
 *  @param view 要截的view
 *
 *  @return 生成的图片
 */
+ (UIImage *)hd_viewShotWithView:(UIView *)view;

/**
 *  截屏
 *
 *  @return 返回截屏的图片
 */
+ (UIImage *)hd_screenShot;

/**
 *  给图片添加水印
 *
 *  @param originalImage         原图
 *  @param waterImageName 水印的名字
 *
 *  @return 添加完水印的图片
 */
+ (UIImage *)hd_waterImageWithBgImageName:(UIImage *)originalImage andWaterImageName:(NSString *)waterImageName;

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
+ (UIImage *)hd_reduceImage:(UIImage *)image percent:(float)percent;

/**
 *  对图片进行压缩
 *
 *  @param image   要压缩的图片
 *  @param newSize 压缩后的图片的像素尺寸
 *
 *  @return 压缩好的图片
 */
+ (UIImage *)hd_imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;

/**
 *  对图片进行压缩
 *
 *  @param image   要压缩的图片
 *  @param kb 压缩后的图片的内存大小
 *
 *  @return 压缩好的图片
 */
+ (UIImage *)hd_imageWithImageSimple:(UIImage*)image scaledToKB:(NSInteger)kb;

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
 *  生成了一个毛玻璃效果的图片
 *
 *  @return 返回模糊化好的图片
 */
- (UIImage *)hd_blurredImage:(CGFloat)blurAmount;

/**
 *  生成一个毛玻璃效果的图片
 *
 *  @param blurLevel 毛玻璃的模糊程度
 *
 *  @return 毛玻璃好的图片
 */
- (UIImage *)hd_blearImageWithBlurLevel:(CGFloat)blurLevel;

/** 根据给定的url计算网络图片的大小*/
+ (CGSize)downloadImageSizeWithURL:(id)imageURL;

/** 根据视频url获取第一帧图片*/
+ (UIImage *)videoPreViewImage:(NSURL *)path;

@end
