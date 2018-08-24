//
//  WYNetworking.m
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/6/26.
//  Copyright © 2018年 jacke-xu. All rights reserved.
//

#import "WYNetworking.h"
#import "AFNetworking.h"
#import "NetworkMonitoring.h"
#import "NSObject+ModelParse.h"

@implementation WYUploadModle

- (NSString *)description {
    
    return [NSString stringWithFormat:@"<%@ : %p> \n{picName : %@ \n pic : %@ \n}", [self class], self,self.picName, self.pic];
}

@end

@implementation WYNetworking
singleton_implementation(WYNetworking)//单例实现

/**
 *  GET请求(未返回请求进度)
 *
 *  @param URLString  请求的链接
 *  @param parameters 请求的参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
- (void)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure {
    
    [self networkMonitoring:^(BOOL hasNetwork) {if(hasNetwork == NO) {return;}}];
    
    AFHTTPSessionManager *manager = [self sessionManagerFromRequestType:@"GET"];
    
    [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {success(responseObject,[NSObject parse:responseObject]);}
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {failure(error,[error localizedDescription]);}
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
}


/**
 *  GET请求(有返回请求进度)
 *
 *  @param URLString  请求的链接
 *  @param parameters 请求的参数
 *  @param progress   进度的回调
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
- (void)GET:(NSString *)URLString parameters:(NSDictionary *)parameters progress:(Progress)progress success:(Success)success failure:(Failure)failure {
    
    [self networkMonitoring:^(BOOL hasNetwork) {if(hasNetwork == NO) {return;}}];
    
    AFHTTPSessionManager *manager = [self sessionManagerFromRequestType:@"GET"];
    
    [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if(progress) {progress(downloadProgress);}
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {success(responseObject,[NSObject parse:responseObject]);}
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {failure(error,[error localizedDescription]);}
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
}


/**
 *  POST请求(未返回请求进度)
 *
 *  @param URLString  请求的链接
 *  @param parameters 请求的参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
- (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure {
    
    [self networkMonitoring:^(BOOL hasNetwork) {if(hasNetwork == NO) {return;}}];
    
    AFHTTPSessionManager *manager = [self sessionManagerFromRequestType:@"POST"];
    
    [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {success(responseObject,[NSObject parse:responseObject]);}
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {failure(error,[error localizedDescription]);}
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
}

/**
 *  POST请求(有返回请求进度)
 *
 *  @param URLString  请求的链接
 *  @param parameters 请求的参数
 *  @param progress   进度的回调
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
- (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters progress:(Progress)progress success:(Success)success failure:(Failure)failure {
    
    [self networkMonitoring:^(BOOL hasNetwork) {if(hasNetwork == NO) {return;}}];
    
    AFHTTPSessionManager *manager = [self sessionManagerFromRequestType:@"POST"];
    
    [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if(progress) {progress(uploadProgress);}
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {success(responseObject,[NSObject parse:responseObject]);}
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {failure(error,[error localizedDescription]);}
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
}


/**
 *  POST图片上传(多张图片) // 可扩展成多个别的数据上传如:mp3等
 *
 *  @param URLString  请求的链接
 *  @param parameters 请求的参数
 *  @param picArray   存放图片模型的数组
 *  @param progress   进度的回调
 *  @param success    上传成功的回调
 *  @param failure    上传失败的回调
 */
- (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters andPicArray:(NSArray <WYUploadModle *>*)picArray progress:(Progress)progress success:(Success)success failure:(Failure)failure {
    
    [self networkMonitoring:^(BOOL hasNetwork) {if(hasNetwork == NO) {return;}}];
    
    AFHTTPSessionManager *manager = [self sessionManagerFromRequestType:@"UPLOAD"];
    
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSInteger count = picArray.count;
        NSString *fileName = @"";
        NSData *data = [NSData data];
        
        for (int i = 0; i < count; i++)
        {
            @autoreleasepool {
                WYUploadModle *uploadModle = picArray[i];
                fileName = [NSString stringWithFormat:@"pic%02d.jpg", i];
                /**
                 *  压缩图片然后再上传(1.0代表无损 0~~1.0区间)
                 */
                data = UIImageJPEGRepresentation(uploadModle.pic, 1.0);
                CGFloat precent = uploadModle.picSize / (data.length / 1024.0);
                if (precent > 1) {precent = 1.0;}
                data = nil;
                data = UIImageJPEGRepresentation(uploadModle.pic, precent);
                
                [formData appendPartWithFileData:data name:uploadModle.picName fileName:fileName mimeType:@"image/jpeg"];
                data = nil;
                uploadModle.pic = nil;
            }
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if(progress) {progress(uploadProgress);}
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {success(responseObject,[NSObject parse:responseObject]);}
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {failure(error,[error localizedDescription]);}
    }];
}


/**
 *  POST图片上传(单张图片) // 可扩展成单个别的数据上传如:mp3等
 *
 *  @param URLString   请求的链接
 *  @param parameters  请求的参数
 *  @param uploadModle 上传的图片模型
 *  @param progress    进度的回调
 *  @param success     上传成功的回调
 *  @param failure     上传失败的回调
 */
- (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters andPic:(WYUploadModle *)uploadModle progress:(Progress)progress success:(Success)success failure:(Failure)failure {
    
    [self networkMonitoring:^(BOOL hasNetwork) {if(hasNetwork == NO) {return;}}];
    
    AFHTTPSessionManager *manager = [self sessionManagerFromRequestType:@"UPLOAD"];
    
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        /**
         *  压缩图片然后再上传(1.0代表无损 0~~1.0区间)
         */
        NSData *data = UIImageJPEGRepresentation(uploadModle.pic, 1.0);
        CGFloat precent = uploadModle.picSize / (data.length / 1024.0);
        if (precent > 1) {precent = 1.0;}
        data = nil;
        data = UIImageJPEGRepresentation(uploadModle.pic, precent);
        
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", uploadModle.picName];
        
        [formData appendPartWithFileData:data name:uploadModle.picName fileName:fileName mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if(progress) {progress(uploadProgress);}
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {success(responseObject,[NSObject parse:responseObject]);}
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {failure(error,[error localizedDescription]);}
    }];
}


/**
 *  POST上传url资源
 *
 *  @param URLString   请求的链接
 *  @param parameters  请求的参数
 *  @param uploadModle 上传的图片模型(资源的url地址)
 *  @param progress    进度的回调
 *  @param success     上传成功的回调
 *  @param failure     上传失败的回调
 */
- (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters andPicUrl:(WYUploadModle *)uploadModle progress:(Progress)progress success:(Success)success failure:(Failure)failure {
    
    [self networkMonitoring:^(BOOL hasNetwork) {if(hasNetwork == NO) {return;}}];
    
    AFHTTPSessionManager *manager = [self sessionManagerFromRequestType:@"UPLOAD"];
    
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", uploadModle.picName];
        // 根据本地路径获取url(相册等资源上传)
        NSURL *url = [NSURL fileURLWithPath:uploadModle.url]; // [NSURL URLWithString:uploadModle.url] 可以换成网络的图片在上传
        
        [formData appendPartWithFileURL:url name:uploadModle.picName fileName:fileName mimeType:@"application/octet-stream" error:nil];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if(progress) {progress(uploadProgress);}
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {success(responseObject,[NSObject parse:responseObject]);}
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {failure(error,[error localizedDescription]);}
    }];
}


/**
 *  下载
 *
 *  @param URLString       请求的链接
 *  @param progress        进度的回调
 *  @param destination     返回URL的回调
 *  @param downLoadSuccess 下载成功的回调
 *  @param failure         下载失败的回调
 */
- (NSURLSessionDownloadTask *)downLoadWithURL:(NSString *)URLString progress:(Progress)progress destination:(Destination)destination downLoadSuccess:(DownLoadSuccess)downLoadSuccess failure:(Failure)failure {
    
    [self networkMonitoring:^(BOOL hasNetwork) {if(hasNetwork == NO) {return;}}];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //设置安全策略
    if(_requestWay !=  requestWayHttp) {[manager setSecurityPolicy:[self securityPolicyWithSessionManager:manager]];}
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    
    // 下载任务
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (progress) {progress(downloadProgress);}
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        if (destination) {return destination(targetPath, response);}
        else {return nil;}
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (error) {failure(error, [error localizedDescription]);}
        else {downLoadSuccess(response, filePath);}
    }];
    
    // 开始启动任务
    [task resume];
    
    return task;
}


/**
 *  JSON序列化
 *
 *  @param object   需要序列化的数据
 */
+ (instancetype)JSONSerializer:(id)object {
    
    return [NSJSONSerialization JSONObjectWithData:object options:NSJSONReadingMutableLeaves|NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:nil];
}


/**
 *  判断网络连接状况
 */
- (void)networkMonitoring:(void(^)(BOOL hasNetwork))networkBlock {
    
    if([NetworkMonitoring sharedNetworkMonitoring].networkStatus == NetworkStatusNotReachable) {
        
        [StateView showWarningInfo:@"无网络连接,请检查您的网络设置!"];
    }
    
    if(networkBlock) {
        
        networkBlock([NetworkMonitoring sharedNetworkMonitoring].networkStatus != NetworkStatusNotReachable);
    }
}


/**
 *  根据网络请求的类型设置SessionManager
 *
 *  @param requestType   网络请求的类型(POST/GET)
 */
- (AFHTTPSessionManager *)sessionManagerFromRequestType:(NSString *)requestType {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = self.acceptableContentTypes;
    manager.requestSerializer.timeoutInterval = (self.timeoutInterval ? self.timeoutInterval : 10);
    
    //设置安全策略
    if(_requestWay !=  requestWayHttp) {[manager setSecurityPolicy:[self securityPolicyWithSessionManager:manager]];}
    
    if([requestType isEqualToString:@"GET"]) {
        
        NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:manager.responseSerializer.acceptableContentTypes];
        [contentTypes addObject:@"text/html"];
        [contentTypes addObject:@"text/plain"];
    }
    else if ([requestType isEqualToString:@"POST"]) {
        
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8"forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain",@"text/html", nil];
        
        manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        [manager setSessionDidBecomeInvalidBlock:^(NSURLSession * _Nonnull session, NSError * _Nonnull error) {
            NSLog(@"setSessionDidBecomeInvalidBlock");
        }];
    }
    else if ([requestType isEqualToString:@"UPLOAD"]) {
        
        //请求不使用AFN默认转换,保持原有数据
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        //响应不使用AFN默认转换,保持原有数据
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        //按需设置
        //[manager.requestSerializer setValue:@"multipart/form-data"forHTTPHeaderField:@"Content-Type"];
        
        //上传下载等无需开启状态栏动画
        return manager;
    }
    else {}
    
    //开启状态栏动画
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    return manager;
}


/**
 *  设置安全策略
 *
 *  @param sessionManager   需要设置安全策略的会话管理器
 */
- (AFSecurityPolicy *)securityPolicyWithSessionManager:(AFHTTPSessionManager *)sessionManager {
    
    NSString *certFilePath = [[NSBundle mainBundle] pathForResource:@"server" ofType:@"cer"];
    if(certFilePath.length == 0) {NSLog(@"server.cer文件没找到");}
    
    NSData *certData = [NSData dataWithContentsOfFile:certFilePath];
    NSSet *certSet = [NSSet setWithObject:certData];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:certSet];
    
    if(_requestWay == requestWayHttpsBothwayValidation) {
        
        securityPolicy.allowInvalidCertificates = YES;//使用自建证书  默认NO
        securityPolicy.validatesDomainName = YES;//域名验证  默认YES
        
        __weak AFHTTPSessionManager *manager = (AFHTTPSessionManager *)sessionManager;
        __weak typeof(self)weakSelf = self;
        
        [manager setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition(NSURLSession*session, NSURLAuthenticationChallenge *challenge, NSURLCredential *__autoreleasing*_credential) {
            NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
            __autoreleasing NSURLCredential *credential =nil;
            if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
                if([manager.securityPolicy evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:challenge.protectionSpace.host]) {
                    credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
                    if(credential) {
                        disposition =NSURLSessionAuthChallengeUseCredential;
                    } else {
                        disposition =NSURLSessionAuthChallengePerformDefaultHandling;
                    }
                } else {
                    disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
                }
            } else {
                //client authentication
                SecIdentityRef identity = NULL;
                SecTrustRef trust = NULL;
                NSString *p12 = [[NSBundle mainBundle] pathForResource:@"client"ofType:@"p12"];
                NSFileManager *fileManager =[NSFileManager defaultManager];
                if(![fileManager fileExistsAtPath:p12]) {NSLog(@"client.p12文件没找到");}
                else {
                    
                    NSData *PKCS12Data = [NSData dataWithContentsOfFile:p12];
                    
                    if ([[weakSelf class]extractIdentity:&identity andTrust:&trust fromPKCS12Data:PKCS12Data])
                    {
                        SecCertificateRef certificate = NULL;
                        SecIdentityCopyCertificate(identity, &certificate);
                        const void*certs[] = {certificate};
                        CFArrayRef certArray =CFArrayCreate(kCFAllocatorDefault, certs,1,NULL);
                        credential =[NSURLCredential credentialWithIdentity:identity certificates:(__bridge  NSArray*)certArray persistence:NSURLCredentialPersistencePermanent];
                        disposition =NSURLSessionAuthChallengeUseCredential;
                    }
                }
            }
            *_credential = credential;
            return disposition;
        }];
    }
    return securityPolicy;
}

/**
 *  验证P12文件
 */
- (BOOL)extractIdentity:(SecIdentityRef*)outIdentity andTrust:(SecTrustRef *)outTrust fromPKCS12Data:(NSData *)inPKCS12Data {
    
    OSStatus securityError = errSecSuccess;
    //client certificate password
    NSString *clientPwd = @"";//请在此处补全p12文件密码
    if(clientPwd.length == 0) {NSLog(@"请补全p12文件密码");}
    NSDictionary*optionsDictionary = [NSDictionary dictionaryWithObject:clientPwd
                                                                 forKey:(__bridge id)kSecImportExportPassphrase];
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import((__bridge CFDataRef)inPKCS12Data,(__bridge CFDictionaryRef)optionsDictionary,&items);
    
    if(securityError == 0) {
        CFDictionaryRef myIdentityAndTrust =CFArrayGetValueAtIndex(items,0);
        const void*tempIdentity =NULL;
        tempIdentity= CFDictionaryGetValue (myIdentityAndTrust,kSecImportItemIdentity);
        *outIdentity = (SecIdentityRef)tempIdentity;
        const void*tempTrust =NULL;
        tempTrust = CFDictionaryGetValue(myIdentityAndTrust,kSecImportItemTrust);
        *outTrust = (SecTrustRef)tempTrust;
    } else {
        NSLog(@"p12文件验证失败 code %d",(int)securityError);
        return NO;
    }
    return YES;
}

@end
