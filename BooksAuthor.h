//
//  BooksAuthor.h
//  MultimediaData
//
//  Created by Alexander on 09.10.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Books;

@interface BooksAuthor : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *books;
@end

@interface BooksAuthor (CoreDataGeneratedAccessors)

- (void)addBooksObject:(Books *)value;
- (void)removeBooksObject:(Books *)value;
- (void)addBooks:(NSSet *)values;
- (void)removeBooks:(NSSet *)values;

@end
