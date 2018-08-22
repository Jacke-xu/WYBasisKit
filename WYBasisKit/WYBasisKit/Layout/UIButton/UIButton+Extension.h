//
//  UIButton+Extension.h
//  WYBasisKit
//
//  Created by jacke－xu on 16/9/4.
//  Copyright © 2016年 jacke-xu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+EdgeInsetsLayout.h"

@interface UIButton (Extension)

/** 按钮默认状态文字 */
@property (nonatomic, copy) NSString *nTitle;

/** 按钮高亮状态文字 */
@property (nonatomic, copy) NSString *hTitle;

/** 按钮选中状态文字 */
@property (nonatomic, copy) NSString *sTitle;


/** 按钮默认状态文字颜色 */
@property (nonatomic, strong) UIColor *title_nColor;

/** 按钮高亮状态文字颜色 */
@property (nonatomic, strong) UIColor *title_hColor;

/** 按钮选中状态文字颜色 */
@property (nonatomic, strong) UIColor *title_sColor;


/** 按钮默认状态图片 */
@property (nonatomic, strong) UIImage *nImage;

/** 按钮高亮状态图片 */
@property (nonatomic, strong) UIImage *hImage;

/** 按钮选中状态图片 */
@property (nonatomic, strong) UIImage *sImage;


/** 设置按钮字号 */
@property (nonatomic, strong) UIFont *titleFont;


/** 设置按钮左对齐 */
- (void)leftAlignment;

/** 设置按钮中心对齐 */
- (void)centerAlignment;

/** 设置按钮右对齐 */
- (void)rightAlignment;

/** 设置按钮上对齐 */
- (void)topAlignment;

/** 设置按钮下对齐 */
- (void)bottomAlignment;


/** 初始化frame及点击事件 */
- (instancetype)initWithFrame:(CGRect)frame target:(id)target selector:(SEL)selector;

/** 设置点击事件 */
- (void)addTarget:(id)target selector:(SEL)selector;

@end
