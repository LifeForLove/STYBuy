//
//  STUser+CoreDataProperties.m
//  
//
//  Created by 高欣 on 2018/5/14.
//
//

#import "STUser+CoreDataProperties.h"

@implementation STUser (CoreDataProperties)

+ (NSFetchRequest<STUser *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"STUser"];
}

@dynamic userId;
@dynamic userState;

@end
