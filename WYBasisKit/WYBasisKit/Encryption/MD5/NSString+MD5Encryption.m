//
//  NSString+MD5Encryption.m
//  WYBasisKit
//
//  Created by jacke－xu on 16/6/10.
//  Copyright © 2016年 jacke－xu. All rights reserved.
//

#import "NSString+MD5Encryption.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5Encryption)

+ (NSString *)MD5_16BitWithString:(NSString *)MD5String isLowercase:(BOOL)isLowercase {
    
    //提取32位MD5散列的中间16位
    NSString *md5_32Bit_String=[self MD5_32BitWithString:MD5String isLowercase:NO];
    NSString *result = [[md5_32Bit_String substringToIndex:24] substringFromIndex:8];//即9～25位
    
    if (isLowercase) {
        return [result lowercaseString];
    }else{
        return result;
    }
}

+ (NSString *)MD5_32BitWithString:(NSString *)MD5String isLowercase:(BOOL)isLowercase {
    
    const char *cStr = [MD5String UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    NSString *str = [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
    
    if (isLowercase) {
        return [str lowercaseString];
    }else{
        return str;
    }
}

+ (NSString *)MD5_16BitWithString:(NSString *)MD5String isUppercase:(BOOL)isUppercase {
    
    //提取32位MD5散列的中间16位
    NSString *md5_32Bit_String=[self MD5_32BitWithString:MD5String isUppercase:NO];
    NSString *result = [[md5_32Bit_String substringToIndex:24] substringFromIndex:8];//即9～25位
    
    if (isUppercase) {
        return [result uppercaseString];
    }else{
        return result;
    }
}

+ (NSString *)MD5_NB_16BitWithString:(NSString *)MD5String isUppercase:(BOOL)isUppercase {
    
    //提取32位MD5散列的中间16位
    NSString *md5_32Bit_String=[self MD5_NB_32BitWithString:MD5String isUppercase:NO];
    NSString *result = [[md5_32Bit_String substringToIndex:24] substringFromIndex:8];//即9～25位
    
    if (isUppercase) {
        return [result uppercaseString];
    }else{
        return result;
    }
}

+ (NSString *)MD5_32BitWithString:(NSString *)MD5String isUppercase:(BOOL)isUppercase {
    
    const char *str = [MD5String UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( str, (CC_LONG)MD5String.length, digest );
    //CC_MD5(str, (CC_LONG)strlen(str), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    
    if (isUppercase) {
        return [result uppercaseString];
    }else{
        return result;
    }
}

+ (NSString *)MD5_NB_32BitWithString:(NSString *)MD5String isUppercase:(BOOL)isUppercase {
    
    const char *cStr = [MD5String UTF8String];
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    [result appendFormat:@"%02x",digest[0]];
    
    for (int i = 1; i< CC_MD5_DIGEST_LENGTH; i++) {
        
        [result appendFormat:@"%02x",digest[i]^digest[0]];
        
    }
    
    if (isUppercase) {
        return [result uppercaseString];
    }else{
        return result;
    }
}

@end
