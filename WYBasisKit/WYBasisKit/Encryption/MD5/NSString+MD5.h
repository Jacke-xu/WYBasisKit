//
//  NSString+MD5.h
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/7/9.
//  Copyright © 2018年 jacke-xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)

/**
 *  16位MD5加密
 *
 *  @param isUppercase 是否需要大写加密
 */
+ (NSString *)MD5_16BitEncry:(NSString *)MD5String isUppercase:(BOOL)isUppercase;

/**
 *  16位牛叉_MD5加密
 *
 *  @param isUppercase 是否需要大写加密
 */
+ (NSString *)MD5_NB16BitEncry:(NSString *)MD5String isUppercase:(BOOL)isUppercase;

/**
 *  32位MD5加密
 *
 *  @param isUppercase 是否需要大写加密
 */
+ (NSString *)MD5_32BitEncry:(NSString *)MD5String isUppercase:(BOOL)isUppercase;

/**
 *  32位牛叉NB_MD5加密
 *
 *  @param isUppercase 是否需要大写加密
 */
+ (NSString *)MD5_NB32BitEncry:(NSString *)MD5String isUppercase:(BOOL)isUppercase;

@end
