//
//  UIView+Rounded.m
//  WYBasisKit
//
//  Created by jacke-xu on 2018/11/27.
//  Copyright © 2017年 jacke-xu. All rights reserved.
//

#import "UIView+WY_Rounded.h"
#import <objc/runtime.h>

@implementation NSObject (_WYAdd)

+ (void)wy_swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel {
    
    Method originalMethod = class_getInstanceMethod(self, originalSel);
    Method newMethod = class_getInstanceMethod(self, newSel);
    if (!originalMethod || !newMethod) return;
    method_exchangeImplementations(originalMethod, newMethod);
}

- (void)wy_setAssociateValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)wy_getAssociatedValueForKey:(void *)key {
    return objc_getAssociatedObject(self, key);
}

- (void)wy_removeAssociateWithKey:(void *)key {
    objc_setAssociatedObject(self, key, nil, OBJC_ASSOCIATION_ASSIGN);
}

@end

@implementation UIImage (WY_Rounded)

+ (UIImage *)wy_imageWithSize:(CGSize)size drawBlock:(void (^)(CGContextRef context))drawBlock {
    if (!drawBlock) return nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!context) return nil;
    drawBlock(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)wy_maskRoundCornerRadiusImageWithColor:(UIColor *)color cornerRadii:(CGSize)cornerRadii size:(CGSize)size corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    return [UIImage wy_imageWithSize:size drawBlock:^(CGContextRef  _Nonnull context) {
        CGContextSetLineWidth(context, 0);
        [color set];
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:CGRectInset(rect, -0.3, -0.3)];
        UIBezierPath *roundPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, 0.3, 0.3) byRoundingCorners:corners cornerRadii:cornerRadii];
        [rectPath appendPath:roundPath];
        CGContextAddPath(context, rectPath.CGPath);
        CGContextEOFillPath(context);
        if (!borderColor || !borderWidth) return;
        [borderColor set];
        UIBezierPath *borderOutterPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:cornerRadii];
        UIBezierPath *borderInnerPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, borderWidth, borderWidth) byRoundingCorners:corners cornerRadii:cornerRadii];
        [borderOutterPath appendPath:borderInnerPath];
        CGContextAddPath(context, borderOutterPath.CGPath);
        CGContextEOFillPath(context);
    }];
}

@end



static void *const _WYMaskCornerRadiusLayerKey = "_WYMaskCornerRadiusLayerKey";
static NSMutableSet<UIImage *> *maskCornerRaidusImageSet;

@implementation CALayer (WY_Rounded)

+ (void)load{
    [CALayer wy_swizzleInstanceMethod:@selector(layoutSublayers) with:@selector(_wy_layoutSublayers)];
}

- (UIImage *)wy_contentImage{
    return [UIImage imageWithCGImage:(__bridge CGImageRef)self.contents];
}

- (void)setWy_contentImage:(UIImage *)wy_contentImage {
    
    self.contents = (__bridge id)wy_contentImage.CGImage;
}

- (void)wy_cornerRadius:(CGFloat)radius cornerColor:(UIColor *)color {

    [self wy_cornerRadius:radius cornerColor:color corners:UIRectCornerAllCorners];
}

- (void)wy_cornerRadius:(CGFloat)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners {
    
    [self wy_cornerRadii:CGSizeMake(radius, radius) cornerColor:color corners:corners borderColor:nil borderWidth:0];
}

- (void)wy_cornerRadii:(CGSize)cornerRadii cornerColor:(UIColor *)color corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    if (!color) return;
    CALayer *cornerRadiusLayer = [self wy_getAssociatedValueForKey:_WYMaskCornerRadiusLayerKey];
    if (!cornerRadiusLayer) {
        cornerRadiusLayer = [CALayer new];
        cornerRadiusLayer.opaque = YES;
        [self wy_setAssociateValue:cornerRadiusLayer withKey:_WYMaskCornerRadiusLayerKey];
    }
    if (color) {
        [cornerRadiusLayer wy_setAssociateValue:color withKey:"_wy_cornerRadiusImageColor"];
    }else{
        [cornerRadiusLayer wy_removeAssociateWithKey:"_wy_cornerRadiusImageColor"];
    }
    [cornerRadiusLayer wy_setAssociateValue:[NSValue valueWithCGSize:cornerRadii] withKey:"_wy_cornerRadiusImageRadius"];
    [cornerRadiusLayer wy_setAssociateValue:@(corners) withKey:"_wy_cornerRadiusImageCorners"];
    if (borderColor) {
        [cornerRadiusLayer wy_setAssociateValue:borderColor withKey:"_wy_cornerRadiusImageBorderColor"];
    }else{
        [cornerRadiusLayer wy_removeAssociateWithKey:"_wy_cornerRadiusImageBorderColor"];
    }
    [cornerRadiusLayer wy_setAssociateValue:@(borderWidth) withKey:"_wy_cornerRadiusImageBorderWidth"];
    UIImage *image = [self _wy_getCornerRadiusImageFromSet];
    if (image) {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        cornerRadiusLayer.wy_contentImage = image;
        [CATransaction commit];
    }
}

- (UIImage *)_wy_getCornerRadiusImageFromSet{
    if (!self.bounds.size.width || !self.bounds.size.height) return nil;
    CALayer *cornerRadiusLayer = [self wy_getAssociatedValueForKey:_WYMaskCornerRadiusLayerKey];
    UIColor *color = [cornerRadiusLayer wy_getAssociatedValueForKey:"_wy_cornerRadiusImageColor"];
    if (!color) return nil;
    CGSize radius = [[cornerRadiusLayer wy_getAssociatedValueForKey:"_wy_cornerRadiusImageRadius"] CGSizeValue];
    NSUInteger corners = [[cornerRadiusLayer wy_getAssociatedValueForKey:"_wy_cornerRadiusImageCorners"] unsignedIntegerValue];
    CGFloat borderWidth = [[cornerRadiusLayer wy_getAssociatedValueForKey:"_wy_cornerRadiusImageBorderWidth"] floatValue];
    UIColor *borderColor = [cornerRadiusLayer wy_getAssociatedValueForKey:"_wy_cornerRadiusImageBorderColor"];
    if (!maskCornerRaidusImageSet) {
        maskCornerRaidusImageSet = [NSMutableSet new];
    }
    __block UIImage *image = nil;
    [maskCornerRaidusImageSet enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, BOOL * _Nonnull stop) {
        CGSize imageSize = [[obj wy_getAssociatedValueForKey:"_wy_cornerRadiusImageSize"] CGSizeValue];
        UIColor *imageColor = [obj wy_getAssociatedValueForKey:"_wy_cornerRadiusImageColor"];
        CGSize imageRadius = [[obj wy_getAssociatedValueForKey:"_wy_cornerRadiusImageRadius"] CGSizeValue];
        NSUInteger imageCorners = [[obj wy_getAssociatedValueForKey:"_wy_cornerRadiusImageCorners"] unsignedIntegerValue];
        CGFloat imageBorderWidth = [[obj wy_getAssociatedValueForKey:"_wy_cornerRadiusImageBorderWidth"] floatValue];
        UIColor *imageBorderColor = [obj wy_getAssociatedValueForKey:"_wy_cornerRadiusImageBorderColor"];
        BOOL isBorderSame = (CGColorEqualToColor(borderColor.CGColor, imageBorderColor.CGColor) && borderWidth == imageBorderWidth) || (!borderColor && !imageBorderColor) || (!borderWidth && !imageBorderWidth);
        BOOL canReuse = CGSizeEqualToSize(self.bounds.size, imageSize) && CGColorEqualToColor(imageColor.CGColor, color.CGColor) && imageCorners == corners && CGSizeEqualToSize(radius, imageRadius) && isBorderSame;
        if (canReuse) {
            image = obj;
            *stop = YES;
        }
    }];
    if (!image) {
        image = [UIImage wy_maskRoundCornerRadiusImageWithColor:color cornerRadii:radius size:self.bounds.size corners:corners borderColor:borderColor borderWidth:borderWidth];
        [image wy_setAssociateValue:[NSValue valueWithCGSize:self.bounds.size] withKey:"_wy_cornerRadiusImageSize"];
        [image wy_setAssociateValue:color withKey:"_wy_cornerRadiusImageColor"];
        [image wy_setAssociateValue:[NSValue valueWithCGSize:radius] withKey:"_wy_cornerRadiusImageRadius"];
        [image wy_setAssociateValue:@(corners) withKey:"_wy_cornerRadiusImageCorners"];
        if (borderColor) {
            [image wy_setAssociateValue:color withKey:"_wy_cornerRadiusImageBorderColor"];
        }
        [image wy_setAssociateValue:@(borderWidth) withKey:"_wy_cornerRadiusImageBorderWidth"];
        [maskCornerRaidusImageSet addObject:image];
    }
    return image;
}

#pragma mark - exchage Methods

- (void)_wy_layoutSublayers {
    
    [self _wy_layoutSublayers];
    CALayer *cornerRadiusLayer = [self wy_getAssociatedValueForKey:_WYMaskCornerRadiusLayerKey];
    if (cornerRadiusLayer) {
        UIImage *aImage = [self _wy_getCornerRadiusImageFromSet];
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        cornerRadiusLayer.wy_contentImage = aImage;
        cornerRadiusLayer.frame = self.bounds;
        [CATransaction commit];
        [self addSublayer:cornerRadiusLayer];
    }
}

@end

@implementation UIView (WY_Rounded)

- (void)wy_cornerRadius:(CGFloat)radius cornerColor:(UIColor *)color {
    
    [self.layer wy_cornerRadius:radius cornerColor:color];
}

- (void)wy_cornerRadius:(CGFloat)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners {
    
    [self.layer wy_cornerRadius:radius cornerColor:color corners:corners];
}

- (void)wy_cornerRadii:(CGSize)cornerRadii cornerColor:(UIColor *)color corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    
    [self.layer wy_cornerRadii:cornerRadii cornerColor:color corners:corners borderColor:borderColor borderWidth:borderWidth];
}

@end
