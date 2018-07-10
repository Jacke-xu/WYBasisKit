//
//  NSString+DES.h
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/7/9.
//  Copyright © 2018年 jacke-xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DES)

/**
 *  加密方法
 *
 *  @param string   需要加密的字符串
 *  @param key      加密key
 */
+ (NSString *)DESEncry:(NSString *)string key:(NSString *)key;



/**
 *  解密方法
 *
 *  @param string   需要解密的字符串
 *  @param key      解密key(与加密key是一致的)
 */
+ (NSString *)DESDecry:(NSString *)string key:(NSString *)key;

@end
