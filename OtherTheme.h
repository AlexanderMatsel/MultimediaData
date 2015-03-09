//
//  OtherTheme.h
//  MultimediaData
//
//  Created by Alexander on 03.11.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Other;

@interface OtherTheme : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *other;
@end

@interface OtherTheme (CoreDataGeneratedAccessors)

- (void)addOtherObject:(Other *)value;
- (void)removeOtherObject:(Other *)value;
- (void)addOther:(NSSet *)values;
- (void)removeOther:(NSSet *)values;

@end
