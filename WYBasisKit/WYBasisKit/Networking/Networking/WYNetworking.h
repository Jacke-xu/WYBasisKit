//
//  WYNetworking.h
//  WYBasisKit
//
//  Created by  jacke-xu on 2018/6/26.
//  Copyright © 2018年 jacke-xu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

NS_ASSUME_NONNULL_BEGIN

///网络请求方式
typedef enum : NSUInteger {
    
    ///HTTP和CAHTTPS(无需额外配置  CAHTTPS：向正规CA机构购买的HTTPS服务)
    requestWayHttpAndCAHttps = 0,
    ///HTTPS单向验证(需要将一个服务端的cer文件放进工程HTTPSFiles目录下，即server.cer)
    requestWayHttpsSingleValidation,
    ///HTTPS双向验证(需要将一个服务端的cer文件与一个带密码的客户端p12文件放进工程HTTPSFiles目录下，即server.cer和client.p12)
    requestWayHttpsBothwayValidation,
    
} NetworkRequestWay;

///成功Block
typedef void (^ _Nullable Success)(id responseObject);

///失败Blcok
typedef void (^ _Nullable Failure)(NSError *error, NSString *errorStr);

///上传或者下载进度Block
typedef void (^ _Nullable Progress)(NSProgress * _Nullable progress);

///返回URL的Block
typedef NSURL * _Nullable (^ _Nullable Destination)(NSURL *targetPath, NSURLResponse *response);

///下载成功的Blcok
typedef void (^ _Nullable DownLoadSuccess)(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath);


#pragma mark -->上传模型
@interface WYUploadModle : NSObject

/**
 *  上传的图片的名字
 */
@property (nonatomic, copy) NSString *picName;

/**
 *  上传图片大小(kb)
 */
@property (nonatomic, assign) NSUInteger picSize;

/**
 *  上传的图片
 */
@property (nonatomic, strong, nullable) UIImage *pic;

/**
 *  上传的二进制文件
 */
@property (nonatomic, strong) NSData *picData;

/**
 *  上传的资源url
 */
@property (nonatomic, copy) NSString *url;

@end


#pragma mark -->网络请求API
@interface WYNetworking : NSObject
singleton_interface(WYNetworking)//单例声明

/**
 *  超时时间(默认10秒)
 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

/**
 *  可接受的响应内容类型
 */
@property (nonatomic, copy) NSSet <NSString *> *acceptableContentTypes;


/**
 *  设置网络的请求方式(默认HTTP)
 */
@property (nonatomic, assign) NetworkRequestWay requestWay;



/**
 *  GET请求(未返回请求进度)
 *
 *  @param URLString  请求的链接
 *  @param parameters 请求的参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
- (void)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure;


/**
 *  GET请求(有返回请求进度)
 *
 *  @param URLString  请求的链接
 *  @param parameters 请求的参数
 *  @param progress   进度的回调
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
- (void)GET:(NSString *)URLString parameters:(NSDictionary *)parameters progress:(Progress)progress success:(Success)success failure:(Failure)failure;


/**
 *  POST请求(未返回请求进度)
 *
 *  @param URLString  请求的链接
 *  @param parameters 请求的参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
- (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure;

/**
 *  POST请求(有返回请求进度)
 *
 *  @param URLString  请求的链接
 *  @param parameters 请求的参数
 *  @param progress   进度的回调
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
- (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters progress:(Progress)progress success:(Success)success failure:(Failure)failure;


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
- (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters andPicArray:(NSArray <WYUploadModle *>*)picArray progress:(Progress)progress success:(Success)success failure:(Failure)failure;


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
- (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters andPic:(WYUploadModle *)uploadModle progress:(Progress)progress success:(Success)success failure:(Failure)failure;


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
- (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters andPicUrl:(WYUploadModle *)uploadModle progress:(Progress)progress success:(Success)success failure:(Failure)failure;


/**
 *  下载
 *
 *  @param URLString       请求的链接
 *  @param progress        进度的回调
 *  @param destination     返回URL的回调
 *  @param downLoadSuccess 下载成功的回调
 *  @param failure         下载失败的回调
 */
- (NSURLSessionDownloadTask *)downLoadWithURL:(NSString *)URLString progress:(Progress)progress destination:(Destination)destination downLoadSuccess:(DownLoadSuccess)downLoadSuccess failure:(Failure)failure;


/**
 *  JSON序列化
 *
 *  @param object   需要序列化的数据
 */
+ (instancetype)JSONSerializer:(id)object;

@end

NS_ASSUME_NONNULL_END
