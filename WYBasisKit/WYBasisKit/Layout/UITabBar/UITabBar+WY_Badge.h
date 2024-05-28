//
//  UITabBar+WY_Badge.h
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/12/5.
//  Copyright © 2018 jacke-xu. All rights reserved.
//  感谢https://github.com/MRsummer/CustomBadge

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, WY_BadgeStyle) {
    
    /** 不显示徽章值 */
    WY_BadgeStyleNone = 0,
    /** 显示红点徽章值 */
    WY_BadgeStyleRedDot = 1,
    /** 显示数字徽章值 */
    WY_BadgeStyleNumber = 2,
};

@interface UITabBar (WY_Badge)

/** 设置徽章背景颜色(仅限初始化时设置)  默认红色 */
@property (nonatomic, strong) UIColor *wy_badgeBackgroundColor;

/** 设置徽章文本颜色(仅限初始化时设置)  默认白色 */
@property (nonatomic, strong) UIColor *wy_badgeTextColor;

/**
 * 设置badge显示风格
 */
- (void)wy_tabBarBadgeStyle:(WY_BadgeStyle)badgeStyle badgeValue:(NSInteger)badgeValue tabBarIndex:(NSInteger)tabBarIndex;

@end

NS_ASSUME_NONNULL_END
