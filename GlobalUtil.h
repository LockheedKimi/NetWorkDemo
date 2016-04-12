//
//  GlobalUtil.h
//  Wanna
//
//  Created by apple on 15/4/10.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SDWebImageManager.h>
#import "MBProgressHUD.h"

@interface GlobalUtil : NSObject


//获取城市字符UTF8编码
+ (NSString*)getDataUTF8:(NSString *)string;


+ (NSDictionary *)dictionaryWithjsonData:(NSData *)jsonData;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)JsonString;

//验证手机号是否合法
+ (BOOL) validateMobile:(NSString *)mobile;



//密码
+ (BOOL) validatePassword:(NSString *)passWord;

//邮箱
+ (BOOL) validateEmail:(NSString *)email;

//昵称
+ (BOOL) validateNickname:(NSString *)nickname;

//用户名
+ (BOOL) validateUserName:(NSString *)name;
//字符串编码转换
+(NSString *)changeUrlToUTF:(NSString *)nurl;

//计算文件大小
+(long long)fileSizeAtPath:(NSString*) filePath;

//计算文件夹大小
+(float) folderSizeAtPath:(NSString*) folderPath;

//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

//显示toast
+ (MBProgressHUD*)HUDShowMessage:(NSString*)msg addedToView:(UIView*)view;

+ (MBProgressHUD *)HUDShowLoadingInView:(UIView *)view;

//自定义navagition item
+ (UIBarButtonItem*)createBarButtonItemWithTitle:(NSString*)buttonTitle target:(id)target action:(SEL)action;

//自定义navagition item
+ (UIBarButtonItem*)createBarButtonItemWithImage:(NSString*)imageNa target:(id)target action:(SEL)action tag:(NSInteger)tag;

//缩放UIImage
+ (UIImage*)scaleImage:(UIImage*)image toNewSize:(CGSize)size;

+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;

//从URL获取图片（缓存版）
+ (void)downloadImageWithURLCache:(NSString*)url completed:(SDWebImageCompletionBlock)completedBlock;

//将钱从分转成元及字符串，自动判断是否应该有小数
+ (NSString*)getMoneyString:(NSInteger)money;

#pragma mark - 清理集合（Array & Dictionary）中的NSNull
+ (void)deepCleanCollection:(id<NSFastEnumeration>)collection;
//图片压缩
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;
//字符串，转换json格式  dic

@end



