//
//  UIImage+FrostedGlass.m
//  JiaFan
//
//  Created by apple on 2016/11/5.
//  Copyright © 2016年 吴帅. All rights reserved.
//

#import "UIImage+FrostedGlass.h"

@implementation UIImage (FrostedGlass)
//-(UIImage*)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor*)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage*)maskImage
//{
//    // Check pre-conditions.
//    if(self.size.width <1||self.size.height <1){
//        NSLog(@"*** error: invalid size: (%.2f x %.2f). Both dimensions must be >= 1: %@",self.size.width,self.size.height,self);
//        return nil;
//    }
//    if(!self.CGImage){
//        NSLog(@"*** error: image must be backed by a CGImage: %@",self);
//        return nil;
//    }
//    if(maskImage &&!maskImage.CGImage){
//        NSLog(@"*** error: maskImage must be backed by a CGImage: %@", maskImage);
//        return nil;
//    }
//    CGRect imageRect ={CGPointZero,self.size };
//    UIImage*effectImage =self;
//    BOOL hasBlur = blurRadius > __FLT_EPSILON__;
//    BOOL hasSaturationChange = fabs(saturationDeltaFactor -1.)> __FLT_EPSILON__;
//    if(hasBlur || hasSaturationChange){
//        UIGraphicsBeginImageContextWithOptions(self.size, NO,[[UIScreen mainScreen] scale]);
//        CGContextRef effectInContext =UIGraphicsGetCurrentContext();
//        CGContextScaleCTM(effectInContext,1.0,-1.0);
//        CGContextTranslateCTM(effectInContext,0,-self.size.height);
//        CGContextDrawImage(effectInContext, imageRect,self.CGImage);
//        vImage_Buffer effectInBuffer;
//        effectInBuffer.data =CGBitmapContextGetData(effectInContext);
//        effectInBuffer.width =CGBitmapContextGetWidth(effectInContext);
//        effectInBuffer.height =CGBitmapContextGetHeight(effectInContext);
//        effectInBuffer.rowBytes =CGBitmapContextGetBytesPerRow(effectInContext);
//        UIGraphicsBeginImageContextWithOptions(self.size, NO,[[UIScreen mainScreen] scale]);
//        CGContextRef effectOutContext =UIGraphicsGetCurrentContext();
//        vImage_Buffer effectOutBuffer;
//        effectOutBuffer.data =CGBitmapContextGetData(effectOutContext);
//        effectOutBuffer.width =CGBitmapContextGetWidth(effectOutContext);
//        effectOutBuffer.height =CGBitmapContextGetHeight(effectOutContext);
//        effectOutBuffer.rowBytes =CGBitmapContextGetBytesPerRow(effectOutContext);
//        if(hasBlur){
//            // A description of how to compute the box kernel width from the Gaussian
//            // radius (aka standard deviation) appears in the SVG spec:
//            // http://www.w3.org/TR/SVG/filters.html#feGaussianBlurElement
//            //
//            // For larger values of 's' (s >= 2.0), an approximation can be used: Three
//            // successive box-blurs build a piece-wise quadratic convolution kernel, which
//            // approximates the Gaussian kernel to within roughly 3%.
//            //
//            // let d = floor(s * 3*sqrt(2*pi)/4 + 0.5)
//            //
//            // ... if d is odd, use three box-blurs of size 'd', centered on the output pixel.
//            //
//            CGFloat inputRadius = blurRadius *[[UIScreen mainScreen] scale];
//            NSUInteger radius = floor(inputRadius *3.* sqrt(2* M_PI)/4+0.5);
//            if(radius %2!=1){
//                radius +=1;// force radius to be odd so that the three box-blur methodology works.
//            }
//            vImageBoxConvolve_ARGB8888(&effectInBuffer,&effectOutBuffer, NULL,0,0, radius, radius,0, kvImageEdgeExtend);
//            vImageBoxConvolve_ARGB8888(&effectOutBuffer,&effectInBuffer, NULL,0,0, radius, radius,0, kvImageEdgeExtend);
//            vImageBoxConvolve_ARGB8888(&effectInBuffer,&effectOutBuffer, NULL,0,0, radius, radius,0, kvImageEdgeExtend);
//        }
//        BOOL effectImageBuffersAreSwapped = NO;
//        if(hasSaturationChange){
//            CGFloat s = saturationDeltaFactor;
//            CGFloat floatingPointSaturationMatrix[]={
//                0.0722+0.9278* s,0.0722-0.0722* s,0.0722-0.0722* s,0,
//                0.7152-0.7152* s,0.7152+0.2848* s,0.7152-0.7152* s,0,
//                0.2126-0.2126* s,0.2126-0.2126* s,0.2126+0.7873* s,0,
//                0,0,0,1,
//            };
//            const int32_t divisor =256;
//            NSUInteger matrixSize =sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
//            int16_t saturationMatrix[matrixSize];
//            for(NSUInteger i =0; i < matrixSize;++i){
//                saturationMatrix[i]=(int16_t)roundf(floatingPointSaturationMatrix[i]* divisor);
//            }
//            if(hasBlur){
//                vImageMatrixMultiply_ARGB8888(&effectOutBuffer,&effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
//                effectImageBuffersAreSwapped = YES;
//            }
//            else{
//                vImageMatrixMultiply_ARGB8888(&effectInBuffer,&effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
//            }
//        }
//        if(!effectImageBuffersAreSwapped)
//            effectImage =UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        if(effectImageBuffersAreSwapped)
//            effectImage =UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//    }
//    // Set up output context.
//    UIGraphicsBeginImageContextWithOptions(self.size, NO,[[UIScreen mainScreen] scale]);
//    CGContextRef outputContext =UIGraphicsGetCurrentContext();
//    CGContextScaleCTM(outputContext,1.0,-1.0);
//    CGContextTranslateCTM(outputContext,0,-self.size.height);
//    // Draw base image.
//    CGContextDrawImage(outputContext, imageRect,self.CGImage);
//    // Draw effect image.
//    if(hasBlur){
//        CGContextSaveGState(outputContext);
//        if(maskImage){
//            CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
//        }
//        CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
//        CGContextRestoreGState(outputContext);
//    }
//    // Add in color tint.
//    if(tintColor){
//        CGContextSaveGState(outputContext);
//        CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
//        CGContextFillRect(outputContext, imageRect);
//        CGContextRestoreGState(outputContext);
//    }
//    // Output image is ready.
//    UIImage*outputImage =UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return outputImage;
//}

+(UIImage *) imageCompressForWidthScale:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth{
    
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) == NO){
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            
        }else if(widthFactor < heightFactor){
            
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    return newImage;
}
/**
 * 将UIColor变换为UIImage
 *
 **/
+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}


//按比例缩放图片 并且不改变图片的质量
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize{
    
    if([[UIScreen mainScreen] scale] == 2.0){ // @2x
        
        UIGraphicsBeginImageContextWithOptions(reSize,NO, 2.0);
        
    }else if([[UIScreen mainScreen]scale] == 3.0){ // @3x ( iPhone 6plus 、iPhone6s plus)
        
        UIGraphicsBeginImageContextWithOptions(reSize,NO, 3.0);
        
    }else{
        
        UIGraphicsBeginImageContext(reSize);
        
    }
    
    // 绘制改变大小的图片
    
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    
    // 从当前context中创建一个改变大小后的图片
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    
    return scaledImage;
}


+ (UIImage *)creatNewImgWithImageName:(NSString *)imgName
{
    UIImage * img = [UIImage imageNamed:imgName];
    //开启图片上下文
    UIGraphicsBeginImageContext(img.size);
    //将图片绘制到上下文中
    [img drawInRect:CGRectMake(0, 0, img.size.width, img.size.height)];
    //将新的图片从上下文中导出
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}




@end
