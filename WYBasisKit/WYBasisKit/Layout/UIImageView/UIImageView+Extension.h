//
//  UIImageView+Extension.h
//  WYBasisKit
//
//  Created by jacke－xu on 16/9/4.
//  Copyright © 2016年 jacke-xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Extension)

/** 创建本地图片imageView */
+ (UIImageView *)createImageViewWithFrame:(CGRect)frame image:(UIImage *)image;

/** 创建矩形imageView */
+ (UIImageView *)createRectangleImageViewWithFrame:(CGRect)frame imageUrl:(NSString *)imageUrl placeholderImage:(UIImage *)placeholderImage;

/** 创建圆形imageView */
+ (UIImageView *)createCircularImageViewWithFrame:(CGRect)frame imageUrl:(NSString *)imageUrl borderWith:(CGFloat)borderWith borderColor:(UIColor *)borderColor placeholderImage:(UIImage *)placeholderImage;

@end
