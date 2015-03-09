//
//  Comment.h
//  MultimediaData
//
//  Created by Alexander on 30.10.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Books, Comics, Music, Other, Photo, Video;

@interface Comment : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Books *book;
@property (nonatomic, retain) Music *music;
@property (nonatomic, retain) Photo *photo;
@property (nonatomic, retain) Video *video;
@property (nonatomic, retain) Comics *comics;
@property (nonatomic, retain) Other *other;

@end
