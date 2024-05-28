//
//  UIView+WY_Extension.h
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/11/27.
//  Copyright © 2018 jacke-xu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+WY_Rounded.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (WY_Extension)

/** view.width */
@property (nonatomic, assign) CGFloat wy_width;

/** view.height */
@property (nonatomic, assign) CGFloat wy_height;

/** view.origin.x */
@property (nonatomic, assign) CGFloat wy_left;

/** view.origin.y */
@property (nonatomic, assign) CGFloat wy_top;

/** view.origin.x + view.width */
@property (nonatomic, assign) CGFloat wy_right;

/** view.origin.y + view.height */
@property (nonatomic, assign) CGFloat wy_bottom;

/** view.center.x */
@property (nonatomic, assign) CGFloat wy_centerx;

/** view.center.y */
@property (nonatomic, assign) CGFloat wy_centery;

/** view.origin */
@property (nonatomic, assign) CGPoint wy_origin;

/** view.size */
@property (nonatomic, assign) CGSize wy_size;

/** 找到自己的所属viewController */
- (UIViewController *)wy_belongsViewController;

/** 找到当前显示的viewController */
- (UIViewController *)wy_currentViewController;

/** 创建view */
+ (UIView *)wy_createViewWithFrame:(CGRect)frame color:(UIColor *)color;

/** 添加手势点击事件 */
- (void)wy_addGestureAction:(id)target selector:(SEL)selector;

/**
 * 根据键盘的弹出与收回，自动调整控件位置，防止键盘遮挡输入框,注意，如果调用该方法，则必须在父控制器的dealloc方法中调用releaseKeyboardNotification方法,以释放键盘监听通知
 @ param mainView 要移动的主视图，控制器view(controller.view)
 */
- (void)wy_automaticFollowKeyboard:(UIView *)mainView;

/**
 * 释放监听键盘的通知,如果调用过automaticFollowKeyboard方法，则必须在父控制器的dealloc方法中调用本方法以释放键盘监听通知
 */
- (void)wy_releaseKeyboardNotification;

/** 添加收起键盘的手势 */
- (void)wy_gestureHidingkeyboard;

@end

NS_ASSUME_NONNULL_END
