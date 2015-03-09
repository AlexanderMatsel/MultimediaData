//
//  MusicViewController.m
//  MultimediaData
//
//  Created by Alexander on 17.10.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "MusicViewController.h"
#import "AppDelegate.h"
#import "MusicAlbum.h"
#import "Music.h"
#import "MusicArtist.h"
#import "MusicGenre.h"
#import "Comment.h"


@interface MusicViewController ()<UITextFieldDelegate>

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;


@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *artistTextField;
@property (weak, nonatomic) IBOutlet UITextField *commentaryTextField;
@property (weak, nonatomic) IBOutlet UITextField *ratingTextField;
@property (weak, nonatomic) IBOutlet UITextField *genreTextField;
@property (weak, nonatomic) IBOutlet UITextField *albumTextField;


- (IBAction)addMusicEntry:(id)sender;
- (IBAction)showMusic:(id)sender;

@end

@implementation MusicViewController


-(IBAction)addMusicEntry:(id)sender
{
    Music *music = [NSEntityDescription insertNewObjectForEntityForName:@"Music"
                                                inManagedObjectContext:self.managedObjectContext];
    
    music.title = self.titleTextField.text;
    music.rating = self.ratingTextField.text;
    
    NSString *artistName = self.artistTextField.text;
    NSString *genreName = self.genreTextField.text;
    NSString *albumName = self.albumTextField.text;
    
    NSFetchRequest *r = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([MusicArtist class])];
    NSPredicate *namePredicate = [NSPredicate predicateWithFormat:@"name == %@",artistName];
    r.predicate = namePredicate;
    
    MusicArtist *artist = [[self.managedObjectContext executeFetchRequest:r error:nil] lastObject];
    if (!artist)
    {
        artist = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([MusicArtist class])
                                               inManagedObjectContext:self.managedObjectContext];
        artist.name = artistName;
    }
    music.artist = artist;
    
    r = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([MusicGenre class])];
    namePredicate = [NSPredicate predicateWithFormat:@"name == %@", genreName];
    r.predicate = namePredicate;
    MusicGenre *genre = [[self.managedObjectContext executeFetchRequest:r error:nil] lastObject];
    if (!genre)
    {
        genre = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([MusicGenre class])
                                              inManagedObjectContext:self.managedObjectContext];
        genre.name = genreName;
    }
    music.genre = genre;
    
    r = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([MusicAlbum class])];
    namePredicate = [NSPredicate predicateWithFormat:@"name == %@", albumName];
    r.predicate = namePredicate;
    MusicAlbum *album = [[self.managedObjectContext executeFetchRequest:r error:nil] lastObject];
    if (!album)
    {
        album = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([MusicAlbum class])
                                              inManagedObjectContext:self.managedObjectContext];
        album.name = albumName;
    }
    music.album = album;

    
    
    Comment *commentary = [NSEntityDescription insertNewObjectForEntityForName:@"Comment"
                                                        inManagedObjectContext:self.managedObjectContext];
    commentary.name = self.commentaryTextField.text;
    music.comment = [NSSet setWithObject:commentary];
    
    
    NSError *error;
    if (![self.managedObjectContext save:&error])
    {
        NSLog(@"Couldn't save: %@", [error localizedDescription]);
    }
    
    self.titleTextField.text = @"";
    self.artistTextField.text = @"";
    self.genreTextField.text = @"";
    self.commentaryTextField.text = @"";
    self.ratingTextField.text = @"";
    self.albumTextField.text = @"";
    
    [self.view endEditing:YES];
    
}


- (IBAction)showMusic:(id)sender
{
    
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
	
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    
    self.managedObjectContext = appDelegate.managedObjectContext;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - UITextfield Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:self.title])
    {
        [self.artistTextField becomeFirstResponder];
    }
    else if ([textField isEqual:self.albumTextField])
    {
        [self.commentaryTextField becomeFirstResponder];
    }
    
    else if ([textField isEqual:self.artistTextField])
    {
        [self.genreTextField becomeFirstResponder];
    }
    else if ([textField isEqual:self.genreTextField])
    {
        [self.albumTextField becomeFirstResponder];
    }
    else if ([textField isEqual:self.commentaryTextField])
    {
        [self.ratingTextField becomeFirstResponder];
    }
    else if ([textField isEqual:self.ratingTextField])
    {
        [self.ratingTextField resignFirstResponder];
    }
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
