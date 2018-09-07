//
//  AppleSystemService.h
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/7/11.
//  Copyright © 2018年 jacke-xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppleSystemService : NSObject

/**
 *  直接拨打电话(拨打完电话回不到原来的应用,会停留在通讯录里,而且是直接拨打,不弹出提示)
 *
 *  @param phoneNum 电话号码
 */
+ (void)directPhoneCallWithPhoneNum:(NSString *)phoneNum;

/**
 *  弹出对话框并询问是否拨打电话(打完电话后还会回到原来的程序,也会弹出提示,推荐这种)
 *
 *  @param phoneNum 电话号码
 *  @param view     contentView
 */
+ (void)phoneCallWithPhoneNum:(NSString *)phoneNum contentView:(UIView *)view;

/**
 *  跳到app的评论页
 *
 *  @param appId APP的id号
 */
+ (void)jumpToAppReviewPageWithAppId:(NSString *)appId;


@end
