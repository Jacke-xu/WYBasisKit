//
//  NSString+AES256.m
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/7/9.
//  Copyright © 2018年 jacke-xu. All rights reserved.
//

#import "NSString+AES256.h"
#import "NSString+Base64.h"
#import "NSData+Base64.h"
#import "NSData+CommonCrypto.h"

@implementation NSString (AES256)

+ (NSString *)AES256Encry:(NSString *)string key:(NSString *)key {
    
    NSData *encryptedData = [[string dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptedDataUsingKey:[[key dataUsingEncoding:NSUTF8StringEncoding] SHA256Hash] error:nil];
    NSString *base64EncodedString = [NSString base64StringFromData:encryptedData length:[encryptedData length]];
    return base64EncodedString;
}

+ (NSString *)AES256Decry:(NSString *)string key:(NSString *)key {
    
    NSData *encryptedData = [NSData base64DataFromString:string];
    NSData *decryptedData = [encryptedData decryptedAES256DataUsingKey:[[key dataUsingEncoding:NSUTF8StringEncoding] SHA256Hash] error:nil];
    return [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
}

@end
