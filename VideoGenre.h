//
//  VideoGenre.h
//  MultimediaData
//
//  Created by Alexander on 29.10.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Video;

@interface VideoGenre : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *video;
@end

@interface VideoGenre (CoreDataGeneratedAccessors)

- (void)addVideoObject:(Video *)value;
- (void)removeVideoObject:(Video *)value;
- (void)addVideo:(NSSet *)values;
- (void)removeVideo:(NSSet *)values;

@end
