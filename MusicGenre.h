//
//  MusicGenre.h
//  MultimediaData
//
//  Created by Alexander on 20.10.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Music;

@interface MusicGenre : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *music;
@end

@interface MusicGenre (CoreDataGeneratedAccessors)

- (void)addMusicObject:(Music *)value;
- (void)removeMusicObject:(Music *)value;
- (void)addMusic:(NSSet *)values;
- (void)removeMusic:(NSSet *)values;

@end
