//
//  Music.h
//  MultimediaData
//
//  Created by Alexander on 20.10.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comment, MusicAlbum, MusicArtist, MusicGenre;

@interface Music : NSManagedObject

@property (nonatomic, retain) NSString * rating;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) MusicAlbum *album;
@property (nonatomic, retain) MusicArtist *artist;
@property (nonatomic, retain) NSSet *comment;
@property (nonatomic, retain) MusicGenre *genre;
@end

@interface Music (CoreDataGeneratedAccessors)

- (void)addCommentObject:(Comment *)value;
- (void)removeCommentObject:(Comment *)value;
- (void)addComment:(NSSet *)values;
- (void)removeComment:(NSSet *)values;

@end
