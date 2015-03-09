//
//  AppDelegate.h
//  MultimediaData
//
//  Created by Alexander on 30.09.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;


-(NSArray *) getAllBooksRecords;
-(NSArray *) getAllMusicRecords;
-(NSArray *) getAllPhotoRecords;
-(NSArray *) getAllVideoRecords;
-(NSArray *) getAllComicsRecords;
-(NSArray *) getAllOtherRecords;


@end
