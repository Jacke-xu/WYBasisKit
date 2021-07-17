//
//  UIButton+WY_Extension.h
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/11/27.
//  Copyright © 2018 jacke-xu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (WY_Extension)

/** 按钮默认状态文字 */
@property (nonatomic, copy) NSString *wy_nTitle;

/** 按钮高亮状态文字 */
@property (nonatomic, copy) NSString *wy_hTitle;

/** 按钮选中状态文字 */
@property (nonatomic, copy) NSString *wy_sTitle;


/** 按钮默认状态文字颜色 */
@property (nonatomic, strong) UIColor *wy_title_nColor;

/** 按钮高亮状态文字颜色 */
@property (nonatomic, strong) UIColor *wy_title_hColor;

/** 按钮选中状态文字颜色 */
@property (nonatomic, strong) UIColor *wy_title_sColor;


/** 按钮默认状态图片 */
@property (nonatomic, strong) UIImage *wy_nImage;

/** 按钮高亮状态图片 */
@property (nonatomic, strong) UIImage *wy_hImage;

/** 按钮选中状态图片 */
@property (nonatomic, strong) UIImage *wy_sImage;


/** 按钮默认状态背景图片 */
@property (nonatomic, strong) UIImage *wy_bg_nImage;

/** 按钮高亮状态背景图片 */
@property (nonatomic, strong) UIImage *wy_bg_hImage;

/** 按钮选中状态背景图片 */
@property (nonatomic, strong) UIImage *wy_bg_sImage;


/** 按钮默认状态背景颜色(内部会转换成对应颜色的图片) */
@property (nonatomic, strong) UIColor *wy_bg_nImageColor;

/** 按钮高亮状态背景颜色(内部会转换成对应颜色的图片) */
@property (nonatomic, strong) UIColor *wy_bg_hImageColor;

/** 按钮选中状态背景颜色(内部会转换成对应颜色的图片) */
@property (nonatomic, strong) UIColor *wy_bg_sImageColor;


/** 设置按钮字号 */
@property (nonatomic, strong) UIFont *wy_titleFont;


/** 按钮圆角半径 */
- (void)wy_radius:(CGFloat)radius;


/** 设置按钮左对齐 */
- (void)wy_leftAlign;

/** 设置按钮中心对齐 */
- (void)wy_centerAlign;

/** 设置按钮右对齐 */
- (void)wy_rightAlign;

/** 设置按钮上对齐 */
- (void)wy_topAlign;

/** 设置按钮下对齐 */
- (void)wy_bottomAlign;


/** 初始化frame及点击事件 */
- (instancetype)wy_initWithFrame:(CGRect)frame target:(id)target selector:(SEL)selector;

/** 设置点击事件 */
- (void)wy_addTarget:(id)target selector:(SEL)selector;

@end

NS_ASSUME_NONNULL_END
