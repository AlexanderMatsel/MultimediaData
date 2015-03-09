//
//  Books.h
//  MultimediaData
//
//  Created by Alexander on 09.10.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BooksAuthor.h"
#import "BooksGenre.h"
#import "Comment.h"

@interface Books : NSManagedObject

@property (nonatomic, retain) NSString * rating;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) BooksAuthor *author;
@property (nonatomic, retain) BooksGenre *genre;
@property (nonatomic, retain) NSSet *comment;
@end

@interface Books (CoreDataGeneratedAccessors)

- (void)addCommentObject:(Comment *)value;
- (void)removeCommentObject:(Comment *)value;
- (void)addComment:(NSSet *)values;
- (void)removeComment:(NSSet *)values;

@end
