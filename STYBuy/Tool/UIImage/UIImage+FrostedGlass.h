//
//  UIImage+FrostedGlass.h
//  JiaFan
//
//  Created by apple on 2016/11/5.
//  Copyright © 2016年 吴帅. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Accelerate/Accelerate.h>
@interface UIImage (FrostedGlass)


+ (UIImage *)creatNewImgWithImageName:(NSString *)imgName;

//毛玻璃效果
//-(UIImage*)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor*)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage*)maskImage;

//指定宽度按比例缩放
+(UIImage *) imageCompressForWidthScale:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;
+ (UIImage *)createImageWithColor:(UIColor *)color;
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;
@end
