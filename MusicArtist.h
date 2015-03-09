//
//  MusicArtist.h
//  MultimediaData
//
//  Created by Alexander on 20.10.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Music;

@interface MusicArtist : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *music;
@end

@interface MusicArtist (CoreDataGeneratedAccessors)

- (void)addMusicObject:(Music *)value;
- (void)removeMusicObject:(Music *)value;
- (void)addMusic:(NSSet *)values;
- (void)removeMusic:(NSSet *)values;

@end
