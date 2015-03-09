//
//  ComicsPublisher.h
//  MultimediaData
//
//  Created by Alexander on 30.10.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comics;

@interface ComicsPublisher : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *comics;
@end

@interface ComicsPublisher (CoreDataGeneratedAccessors)

- (void)addComicsObject:(Comics *)value;
- (void)removeComicsObject:(Comics *)value;
- (void)addComics:(NSSet *)values;
- (void)removeComics:(NSSet *)values;

@end
