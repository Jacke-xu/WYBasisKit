//
//  NSString+MD5Encryption.h
//  WYBasisKit
//
//  Created by jacke－xu on 16/6/10.
//  Copyright © 2016年 jacke－xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5Encryption)

/**
 *  16位字符串加密
 *
 *  @param isLowercase 是否需要小写加密
 */
+ (NSString *)MD5_16BitWithString:(NSString *)MD5String isLowercase:(BOOL)isLowercase;

/**
 *  32位字符串加密
 *
 *  @param isLowercase 是否需要小写加密
 */
+ (NSString *)MD5_32BitWithString:(NSString *)MD5String isLowercase:(BOOL)isLowercase;

/**
*  16位MD5加密
*
*  @param isUppercase 是否需要大写加密
*/
+ (NSString *)MD5_16BitWithString:(NSString *)MD5String isUppercase:(BOOL)isUppercase;

/**
 *  16位牛叉_MD5加密
 *
 *  @param isUppercase 是否需要大写加密
 */
+ (NSString *)MD5_NB_16BitWithString:(NSString *)MD5String isUppercase:(BOOL)isUppercase;

/**
 *  32位MD5加密
 *
 *  @param isUppercase 是否需要大写加密
 */
+ (NSString *)MD5_32BitWithString:(NSString *)MD5String isUppercase:(BOOL)isUppercase;

/**
 *  32位牛叉NB_MD5加密
 *
 *  @param isUppercase 是否需要大写加密
 */
+ (NSString *)MD5_NB_32BitWithString:(NSString *)MD5String isUppercase:(BOOL)isUppercase;


@end
