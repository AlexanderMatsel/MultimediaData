//
//  MusicDetailViewController.m
//  MultimediaData
//
//  Created by Alexander on 20.10.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "MusicDetailViewController.h"
#import "MusicAlbum.h"
#import "MusicArtist.h"
#import "MusicGenre.h"
#import "Music.h"
#import "Comment.h"
#import "AppDelegate.h"



@interface MusicDetailViewController ()

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong)NSArray* fetchedRecordsArray;

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *artistTextField;
@property (weak, nonatomic) IBOutlet UITextField *commentaryTextField;
@property (weak, nonatomic) IBOutlet UITextField *ratingTextField;
@property (weak, nonatomic) IBOutlet UITextField *genreTextField;
@property (weak, nonatomic) IBOutlet UITextField *albumTextField;

@end

@implementation MusicDetailViewController

- (void)initialSetup
{
    self.titleTextField.text = self.selectedMusic.title;
    self.artistTextField.text = self.selectedMusic.artist.name;
    self.genreTextField.text = self.selectedMusic.genre.name;
    self.ratingTextField.text = self.selectedMusic.rating;
    self.albumTextField.text = self.selectedMusic.album.name;
    
    NSArray *comments = [self.selectedMusic.comment allObjects];
    self.commentaryTextField.text = ((Comment*)[comments objectAtIndex:0]).name;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Готово"
                                                                              style:self.editButtonItem.style
                                                                             target:self
                                                                             action:@selector(doneButtonPressed)];
    
}


- (void)doneButtonPressed
{
    self.selectedMusic.title = self.titleTextField.text;
    self.selectedMusic.artist.name = self.artistTextField.text;
    self.selectedMusic.genre.name = self.genreTextField.text;
    self.selectedMusic.rating = self.ratingTextField.text;
    self.selectedMusic.album.name = self.albumTextField.text;
    
    NSArray* comments = [self.selectedMusic.comment allObjects];
    ((Comment*)[comments objectAtIndex:0]).name = self.commentaryTextField.text;
    
    NSError *error;
    if (![self.managedObjectContext save:&error])
    {
        NSLog(@"Couldn't save: %@", [error localizedDescription]);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate* appDelegate  = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    [self initialSetup];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
