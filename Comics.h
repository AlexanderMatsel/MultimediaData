//
//  Comics.h
//  MultimediaData
//
//  Created by Alexander on 30.10.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ComicsPublisher, Comment;

@interface Comics : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * rating;
@property (nonatomic, retain) ComicsPublisher *publisher;
@property (nonatomic, retain) NSSet *comment;
@end

@interface Comics (CoreDataGeneratedAccessors)

- (void)addCommentObject:(Comment *)value;
- (void)removeCommentObject:(Comment *)value;
- (void)addComment:(NSSet *)values;
- (void)removeComment:(NSSet *)values;

@end
