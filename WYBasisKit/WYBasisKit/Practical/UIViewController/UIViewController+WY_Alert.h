//
//  UIViewController+WY_Alert.h
//  WYBasisKit
//
//  Created by bangtuike on 2019/6/27.
//  Copyright © 2019 jacke-xu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, WY_PreferredStyle) {
    
    /** UIAlertControllerStyleAlert，默认 */
    WY_PreferredStyleAlert = 0,
    /** UIAlertControllerStyleActionSheet */
    WY_PreferredStyleActionSheet = 1
};

@interface UIViewController (WY_Alert)

/// 设置弹窗提醒模式 默认UIAlertControllerStyleAlert
@property (nonatomic, assign) WY_PreferredStyle wy_preferredStyle;

/// 是否需要点击空白处关闭弹窗 默认NO
@property (nonatomic, assign) BOOL wy_clickBlankClose;

/// 设置AlertController标题颜色
@property (nonatomic, strong) UIColor *wy_alertTitleColor;

/// 设置AlertController消息颜色
@property (nonatomic, strong) UIColor *wy_alertMessageColor;

/// 设置AlertController事件按钮颜色
@property (nonatomic, strong) NSArray <UIColor *>*wy_actionTitleColors;

/// 取消按钮颜色 优先级比wy_actionTitleColors高
@property (nonatomic, strong) UIColor *wy_cancelActionColor;

/// 其他按钮颜色 优先级比wy_actionTitleColors高
@property (nonatomic, strong) UIColor *wy_otherActionColor;

/// 设置AlertController标题字号
@property (nonatomic, strong) UIFont *wy_alertTitleFont;

/// 设置AlertController消息字号
@property (nonatomic, strong) UIFont *wy_alertMessageFont;

/// 获取AlertController标题
@property (nonatomic, copy, readonly) NSString *wy_alertTitle;

/// 获取AlertController消息
@property (nonatomic, copy, readonly) NSString *wy_alertMessage;

/// 获取AlertController事件按钮文本
@property (nonatomic, strong, readonly) NSArray <NSString *>*wy_actionTitles;

- (void)wy_showAlertControllerWithMessage:(NSString *_Nullable)alertMessage;

- (void)wy_showAlertControllerWithMessage:(NSString *_Nullable)alertMessage
                             actionTitles:(NSArray <NSString *>*_Nullable)actionTitles
                                  handler:(void(^__nullable)(UIAlertAction *alertAction, NSInteger actionIndex))handler;

- (void)wy_showAlertControllerWithAlertTitle:(NSString *_Nullable)alertTitle
                                alertMessage:(NSString *_Nullable)alertMessage;

- (void)wy_showAlertControllerWithAlertTitle:(NSString *_Nullable)alertTitle
                                alertMessage:(NSString *_Nullable)alertMessage
                                actionTitles:(NSArray <NSString *>*_Nullable)actionTitles
                                     handler:(void(^__nullable)(UIAlertAction *alertAction, NSInteger actionIndex))handler;

@end

NS_ASSUME_NONNULL_END
