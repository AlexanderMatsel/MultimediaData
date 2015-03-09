//
//  Other.h
//  MultimediaData
//
//  Created by Alexander on 03.11.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comment, OtherTheme;

@interface Other : NSManagedObject

@property (nonatomic, retain) NSString * rating;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *comment;
@property (nonatomic, retain) OtherTheme *theme;
@end

@interface Other (CoreDataGeneratedAccessors)

- (void)addCommentObject:(Comment *)value;
- (void)removeCommentObject:(Comment *)value;
- (void)addComment:(NSSet *)values;
- (void)removeComment:(NSSet *)values;

@end
