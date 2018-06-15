//
//  UIImageView+Extension.m
//  WYBasisKit
//
//  Created by jacke－xu on 16/9/4.
//  Copyright © 2016年 jacke-xu. All rights reserved.
//

#import "UIImageView+Extension.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (Extension)

+ (UIImageView *)createImageViewWithFrame:(CGRect)frame image:(UIImage *)image {
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    imageView.image = image;
    return imageView;
}

+ (UIImageView *)createRectangleImageViewWithFrame:(CGRect)frame imageUrl:(NSString *)imageUrl placeholderImage:(UIImage *)placeholderImage {
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:placeholderImage];
    return imageView;
}

+ (UIImageView *)createCircularImageViewWithFrame:(CGRect)frame imageUrl:(NSString *)imageUrl borderWith:(CGFloat)borderWith borderColor:(UIColor *)borderColor placeholderImage:(UIImage *)placeholderImage  {
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:placeholderImage];
    imageView.layer.cornerRadius = frame.size.width/2;
    imageView.layer.borderWidth = borderWith;
    imageView.layer.borderColor = borderColor.CGColor;
    imageView.clipsToBounds = YES;
    
    return imageView;
}

@end
