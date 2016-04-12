//
//  GlobalUtil.m
//  Wanna
//
//  Created by apple on 15/4/10.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "GlobalUtil.h"
#import "MBProgressHUD.h"


@implementation GlobalUtil

+ (MBProgressHUD*)HUDShowMessage:(NSString*)msg addedToView:(UIView*)view
{
   MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    HUD.labelText = msg;
    HUD.mode = MBProgressHUDModeText;
    
    //指定距离中心点的X轴和Y轴的偏移量，如果不指定则在屏幕中间显示
//        HUD.yOffset = SCREEN_HEIGHT/2-50;
        //HUD.xOffset = 100.0f;
    
    [HUD showAnimated:YES whileExecutingBlock:^{
        sleep(1);
    } completionBlock:^{
        [HUD removeFromSuperview];
       
    }];
    return HUD;
}

+ (MBProgressHUD *)HUDShowLoadingInView:(UIView *)view{
    MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    HUD.removeFromSuperViewOnHide = YES;
    [HUD show:YES];
    return HUD;
}

//获取城市字符UTF8编码
+ (NSString*)getDataUTF8:(NSString *)string
{
    NSString *dataUTF8 = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return dataUTF8;
}

+ (UIBarButtonItem*)createBarButtonItemWithTitle:(NSString*)buttonTitle target:(id)target action:(SEL)action
{
    UIBarButtonItem* item = nil;
    item = [[UIBarButtonItem alloc] initWithTitle:buttonTitle
                                            style:UIBarButtonItemStylePlain
                                           target:target
                                           action:action];
    [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor darkGrayColor],  NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    return item;
}
+ (UIBarButtonItem*)createBarButtonItemWithImage:(NSString*)imageNa target:(id)target action:(SEL)action tag:(NSInteger)tag{
    UIButton *btn2=[[UIButton alloc] initWithFrame:CGRectMake(0, 5, 28, 28)];
    [btn2 setImage:[UIImage imageNamed:imageNa] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:imageNa] forState:UIControlStateHighlighted];
    [btn2 setTag:tag];
    [btn2 setContentMode:UIViewContentModeCenter];
    [btn2 addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *bar2=[[UIBarButtonItem alloc] initWithCustomView:btn2];
    
    
    return bar2;
}

//邮箱
+ (BOOL) validateEmail:(NSString *)email

{
  
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
      return [emailTest evaluateWithObject:email];

}

//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile

{
       //手机号以开头，八个 \d 数字字符
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|4[0-9]|7[0-9]|8[0235-9])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:mobile];
    
    
 
}

//用户名
+ (BOOL) validateUserName:(NSString *)name

{
    NSString *regi=@"^[\u4E00-\u9FFF]+$";
    NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",regi];
    BOOL a=[pre evaluateWithObject:name];
    if (a==YES) {
        return a;
    }
    NSString *userNameRegex = @"^[A-Za-z]+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
 
}

//密码
+ (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9_]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}

//昵称
+ (BOOL) validateNickname:(NSString *)nickname

{
  
    NSString *nicknameRegex = @"^[\u4E00-\u9FA5A-Za-z0-9_]{2,15}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}
//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

//字符串转换
+(NSString *)changeUrlToUTF:(NSString *)nurl{
//   NSString *murl=[nurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString* murl =[nurl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:nurl]];
      NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);//gbk code-->utf8 code
    NSData*data = [murl dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString*utf8str = [[NSString alloc] initWithData:data encoding:enc];
    return utf8str;
}

//计算文件大小
+(long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

//计算文件夹大小
+(float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath])
        return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

+ (UIImage *)scaleImage:(UIImage *)image toNewSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"
                                  keysAndValues:kCIInputImageKey, inputImage,
                        @"inputRadius", @(blur), nil];
    
    CIImage *outputImage = filter.outputImage;
    CIContext *context = [CIContext contextWithOptions:nil]; // save it to self.context
    CGImageRef outImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage* output = [UIImage imageWithCGImage:outImage];
    CGImageRelease(outImage);
    return output;
}

+ (void)downloadImageWithURLCache:(NSString*)url completed:(SDWebImageCompletionBlock)completedBlock{
    [[SDImageCache sharedImageCache] queryDiskCacheForKey:url done:^(UIImage *image, SDImageCacheType cacheType){
        if (image) {
            completedBlock(image,nil,cacheType,nil);
        }else{
            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:url] options:SDWebImageRetryFailed progress:nil
                                                          completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                                              if (image) {
                                                                  [[SDImageCache sharedImageCache] storeImage:image forKey:url];
                                                              }
                                                              completedBlock(image,error,cacheType,imageURL);
                                                          }];
            
        }
    }];
}

+ (NSString*)getMoneyString:(NSInteger)money{
    if (money % 100 == 0) {
        return [NSString stringWithFormat:@"￥%.0f", money / 100.0];
    } else {
        return [NSString stringWithFormat:@"￥%.02f", money / 100.0];
    }
}

+ (void)deepCleanCollection:(id<NSFastEnumeration>)collection{
    id instance = collection;
    if ([instance isKindOfClass:[NSMutableDictionary class]]) {
        NSMutableDictionary* dict = instance;
        [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if ([obj conformsToProtocol:@protocol(NSFastEnumeration)]) {
                [self deepCleanCollection:obj];
            } else {
                if (obj == [NSNull null]) {
                    [dict setValue:@"" forKey:key];
                }
            }
        }];
    } else if ([instance isKindOfClass:[NSMutableArray class]]) {
        NSMutableArray* array = instance;
        [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj conformsToProtocol:@protocol(NSFastEnumeration)]) {
                [self deepCleanCollection:obj];
            } else {
                if (obj == [NSNull null]) {
                    [array replaceObjectAtIndex:idx withObject:@""];
                }
            }
        }];
    }
}



//图片压缩
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}

+ (NSDictionary *)dictionaryWithjsonData:(NSData *)jsonData
{
    if (jsonData == nil) {
        
        return nil;
        
    }
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)JsonString
{
    if (JsonString == nil) {
        
        return nil;
        
    }
    NSData *jsonData = [JsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
}


@end

