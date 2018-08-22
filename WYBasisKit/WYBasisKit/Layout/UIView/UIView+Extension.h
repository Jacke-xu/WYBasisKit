//
//  UIView+Extension.h
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/6/11.
//  Copyright © 2018年 jacke-xu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Rounded.h"

@interface UIView (Extension)

/** view.width */
@property (nonatomic, assign) CGFloat width;

/** view.height */
@property (nonatomic, assign) CGFloat height;

/** view.origin.x */
@property (nonatomic, assign) CGFloat left;

/** view.origin.y */
@property (nonatomic, assign) CGFloat top;

/** view.origin.x + view.width */
@property (nonatomic, assign) CGFloat right;

/** view.origin.y + view.height */
@property (nonatomic, assign) CGFloat bottom;

/** view.center.x */
@property (nonatomic, assign) CGFloat centerx;

/** view.center.y */
@property (nonatomic, assign) CGFloat centery;

/** view.origin */
@property (nonatomic, assign) CGPoint origin;

/** view.size */
@property (nonatomic, assign) CGSize size;

/** 找到自己的所属viewController */
- (UIViewController *)belongsViewController;

/** 找到当前显示的viewController */
- (UIViewController *)currentViewController;

/** 创建view */
+ (UIView *)createViewWithFrame:(CGRect)frame color:(UIColor *)color;

/** 创建导航栏 */
+ (UIView *)createNavWithTitle:(NSString *)title;

/** 创建一个可以返回导航标签的导航栏 */
+ (UIView *)createNavWithTitle:(NSString *)title lableAction:(void(^)(UILabel *navLab))action;

/** 创建带返回方法导航栏 */
+ (UIView *)createBackNavWithTitle:(NSString *)title target:(id)target selector:(SEL)selector;

/** 创建一个带返回方法和返回导航标签的导航栏 */
+ (UIView *)createBackNavWithTitle:(NSString *)title lableAction:(void(^)(UILabel *navLab))action target:(id)target selector:(SEL)selector;

/** 添加手势点击事件 */
- (void)addGestureAction:(id)target selector:(SEL)selector;

/**
 * 根据键盘的弹出与收回，自动调整控件位置，防止键盘遮挡输入框,注意，如果调用该方法，则必须在父控制器的dealloc方法中调用releaseKeyboardNotification方法,以释放键盘监听通知
 @ param mainView 要移动的主视图，控制器view(controller.view)
 */
- (void)automaticFollowKeyboard:(UIView *)mainView;

/**
  * 释放监听键盘的通知,如果调用过automaticFollowKeyboard方法，则必须在父控制器的dealloc方法中调用本方法以释放键盘监听通知
 */
- (void)releaseKeyboardNotification;

/** 添加收起键盘的手势 */
- (void)gestureHidingkeyboard;

@end
