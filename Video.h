//
//  Video.h
//  MultimediaData
//
//  Created by Alexander on 29.10.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comment, VideoGenre, VideoQuality;

@interface Video : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * rating;
@property (nonatomic, retain) VideoGenre *genre;
@property (nonatomic, retain) VideoQuality *quality;
@property (nonatomic, retain) NSSet *comment;
@end

@interface Video (CoreDataGeneratedAccessors)

- (void)addCommentObject:(Comment *)value;
- (void)removeCommentObject:(Comment *)value;
- (void)addComment:(NSSet *)values;
- (void)removeComment:(NSSet *)values;

@end
