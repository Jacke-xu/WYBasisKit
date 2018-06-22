//
//  UINavigationController+Extension.h
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/6/19.
//  Copyright © 2018年 jacke-xu. All rights reserved.
//

/*
 如果设置了导航栏的translucent = YES这时在添加子视图的坐标原点相对屏幕坐标是(0,0).如果设置了translucent = NO这时添加子视图的坐标原点相对屏幕坐标就是(0, navViewHeight)
 */

#import <UIKit/UIKit.h>

@interface UINavigationController (Extension)

/** 导航栏标题字体颜色 */
@property (nonatomic, strong) UIColor *titleColor;

/** 导航栏标题字号 */
@property (nonatomic, strong) UIFont *titleFont;

/** 导航栏背景色 */
@property (nonatomic, strong) UIColor *barBackgroundColor;

/** 导航栏背景图片 */
@property (nonatomic, strong) UIImage *barBackgroundImage;

/** 导航栏左侧返回按钮背景图片 */
@property (nonatomic, strong) UIImage *barReturnButtonImage;

/** 导航栏左侧返回按钮背景颜色 */
@property (nonatomic, strong) UIColor *barReturnButtonColor;

/** 设置导航栏完全透明  会设置translucent = YES */
- (void)navigationBarTransparent;

/** 让导航栏完全不透明 会设置translucent = NO */
- (void)navigationBarOpaque;

/** 设置导航栏上滑收起,下滑显示(iOS8及以后有效) */
- (void)hidesNavigationBarsOnSwipe;

/** 是否显示默认的返回按钮 */
- (void)barReturnButtonHide:(BOOL)hide navigationItem:(UINavigationItem *)navigationItem;

/** 导航栏左侧返回按钮文本 */
- (void)pushControllerBarReturnButtonTitle:(NSString *)barReturnButtonTitle navigationItem:(UINavigationItem *)navigationItem;

@end
