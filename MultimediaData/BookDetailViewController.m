//
//  BookDetailViewController.m
//  MultimediaData
//
//  Created by Alexander on 09.10.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "BookDetailViewController.h"
#import "AppDelegate.h"
#import "BooksAuthor.h"
#import "Books.h"
#import "BooksGenre.h"
#import "Comment.h"

@interface BookDetailViewController ()

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong)NSArray* fetchedRecordsArray;

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *authorTextField;
@property (weak, nonatomic) IBOutlet UITextField *commentaryTextField;
@property (weak, nonatomic) IBOutlet UITextField *ratingTextField;
@property (weak, nonatomic) IBOutlet UITextField *genreTextField;

@end

@implementation BookDetailViewController

- (void)initialSetup
{
    self.titleTextField.text = self.selectedBook.title;
    self.authorTextField.text = self.selectedBook.author.name;
    self.genreTextField.text = self.selectedBook.genre.name;
    self.ratingTextField.text = self.selectedBook.rating;
    
    NSArray *comments = [self.selectedBook.comment allObjects];
    self.commentaryTextField.text = ((Comment*)[comments objectAtIndex:0]).name;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Готово"
                                                                             style:self.editButtonItem.style
                                                                            target:self
                                                                            action:@selector(doneButtonPressed)];
    
}


- (void)doneButtonPressed
{
    self.selectedBook.title = self.titleTextField.text;
    self.selectedBook.author.name = self.authorTextField.text;
    self.selectedBook.genre.name = self.genreTextField.text;
    self.selectedBook.rating = self.ratingTextField.text;
    
    NSArray* comments = [self.selectedBook.comment allObjects];
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
