//
//  STUser+CoreDataProperties.h
//  
//
//  Created by 高欣 on 2018/5/14.
//
//

#import "STUser+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface STUser (CoreDataProperties)

+ (NSFetchRequest<STUser *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *userId;
@property (nonatomic) int16_t userState;

@end

NS_ASSUME_NONNULL_END
