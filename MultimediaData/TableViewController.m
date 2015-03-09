//
//  TableViewController.m
//  MultimediaData
//
//  Created by Alexander on 05.11.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "TableViewController.h"
#import "PhotoTheme.h"
#import "Photo.h"
#import "Comment.h"
#import "AppDelegate.h"
#import "Other.h"
#import "OtherTheme.h"
#import "Books.h"
#import "Video.h"
#import "VideoGenre.h"
#import "VideoQuality.h"
#import "Music.h"
#import "MusicAlbum.h"
#import "MusicArtist.h"
#import "MusicGenre.h"
#import "OtherTheme.h"
#import "Other.h"
#import "Comics.h"
#import "ComicsPublisher.h"


@interface TableViewController ()

@property (nonatomic,strong)NSArray* fetchedRecordsArray;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (IBAction)backButtonTapped:(id)sender;

@end

@implementation TableViewController

static NSString *CellIdentifier = @"CellReuseID";


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    NSMutableArray *data = [NSMutableArray array];
    [data addObjectsFromArray:[appDelegate getAllPhotoRecords]];
    [data addObjectsFromArray:[appDelegate getAllBooksRecords]];
    [data addObjectsFromArray:[appDelegate getAllMusicRecords]];
    [data addObjectsFromArray:[appDelegate getAllComicsRecords]];
    [data addObjectsFromArray:[appDelegate getAllOtherRecords]];
    [data addObjectsFromArray:[appDelegate getAllVideoRecords]];

    self.fetchedRecordsArray = data;
    
}


- (void)editButtonPressed
{
    self.tableView.editing = !self.tableView.editing;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.fetchedRecordsArray count];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  mark - Private Methods

- (IBAction)backButtonTapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:Nil];
}

#pragma mark - Table view data source


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.font = [UIFont systemFontOfSize:12.0];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:11.0];
    id dataObject = [self.fetchedRecordsArray objectAtIndex:indexPath.row];
    if ([dataObject isKindOfClass:[Photo class]])
    {
        Photo *photo = dataObject;
        Comment *commentary = (Comment *)[[photo.comment allObjects] objectAtIndex:0];
        cell.textLabel.text = [NSString stringWithFormat:@"Фото: %@", photo.name];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Тема: %@, Комментарий: %@, Рейтинг: %@ ", photo.theme.name, commentary.name, photo.rating];
    }
    
    else if ([dataObject isKindOfClass:[Books class]])
    {
        Books *book = dataObject;
        cell.textLabel.text = [NSString stringWithFormat:@"Книга: %@, Автор: %@",book.title, book.author.name];
        
        Comment *commentary = (Comment *)[[book.comment allObjects] objectAtIndex:0];
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Жанр: %@, Комментарий: %@, Рейтинг: %@ ", book.genre.name, commentary.name, book.rating];
    }
    
    else if ([dataObject isKindOfClass:[Video class]])
    {
        Video *video = dataObject;
        cell.textLabel.text = [NSString stringWithFormat:@"Видеофайл: %@, Качество: %@", video.title, video.quality.name];
        
        Comment *commentary = (Comment *)[[video.comment allObjects] objectAtIndex:0];
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Жанр: %@, Комментарий: %@, Рейтинг: %@ ", video.genre.name, commentary.name, video.rating];
    }
    
    else if ([dataObject isKindOfClass:[Music class]])
    {
        Music *music = dataObject;
        cell.textLabel.text = [NSString stringWithFormat:@"Песня: %@, Исполнитель: %@", music.title, music.artist.name];
        
        Comment *commentary = (Comment *)[[music.comment allObjects] objectAtIndex:0];
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Жанр: %@, Альбом: %@, Комментарий: %@, Рейтинг: %@", music.genre.name, music.album.name, commentary.name, music.rating];
    }
    
    else if ([dataObject isKindOfClass:[Other class]])
    {
        Other *other = dataObject;
        cell.textLabel.text = [NSString stringWithFormat:@"Файл: %@", other.title];
        
        Comment *commentary = (Comment *)[[other.comment allObjects] objectAtIndex:0];
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Жанр: %@, Комментарий: %@, Рейтинг: %@ ", other.theme.name, commentary.name, other.rating];
    }
    
    else if ([dataObject isKindOfClass:[Comics class]])
    {
        Comics *comics = dataObject;
        cell.textLabel.text = [NSString stringWithFormat:@"Комикс: %@, Издатель: %@", comics.title, comics.publisher.name];
        
        Comment *commentary = (Comment *)[[comics.comment allObjects] objectAtIndex:0];
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Комментарий: %@, Рейтинг: %@ ", commentary.name, comics.rating];
    }
    
    return cell;
}


@end
