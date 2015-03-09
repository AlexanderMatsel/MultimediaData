//
//  Photo.h
//  MultimediaData
//
//  Created by Alexander on 26.10.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comment, PhotoTheme;

@interface Photo : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * rating;
@property (nonatomic, retain) NSSet *comment;
@property (nonatomic, retain) PhotoTheme *theme;
@end

@interface Photo (CoreDataGeneratedAccessors)

- (void)addCommentObject:(Comment *)value;
- (void)removeCommentObject:(Comment *)value;
- (void)addComment:(NSSet *)values;
- (void)removeComment:(NSSet *)values;

@end
