//
//  BookViewController.m
//  MultimediaData
//
//  Created by Alexander on 30.09.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "BookViewController.h"
#import "AppDelegate.h"
#import "Comment.h"
#import "Books.h"
#import "BooksAuthor.h"
#import "BooksGenre.h"

@interface BookViewController ()<UITextFieldDelegate>


@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;


@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *authorTextField;
@property (weak, nonatomic) IBOutlet UITextField *commentaryTextField;
@property (weak, nonatomic) IBOutlet UITextField *ratingTextField;
@property (weak, nonatomic) IBOutlet UITextField *genreTextField;

- (IBAction)backButtonTapped:(id)sender;
- (IBAction)addBookEntry:(id)sender;
- (IBAction)showPhoneBook:(id)sender;

@end

@implementation BookViewController


-(IBAction)addBookEntry:(id)sender
{
    Books *book = [NSEntityDescription insertNewObjectForEntityForName:@"Books"
                                                     inManagedObjectContext:self.managedObjectContext];
    
    book.title = self.titleTextField.text;
    book.rating = self.ratingTextField.text;
    
    NSString *authorName = self.authorTextField.text;
    NSString *genreName = self.genreTextField.text;
    
    NSFetchRequest *r = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([BooksAuthor class])];
    NSPredicate *namePredicate = [NSPredicate predicateWithFormat:@"name == %@",authorName];
    r.predicate = namePredicate;
    
    BooksAuthor *author = [[self.managedObjectContext executeFetchRequest:r error:nil] lastObject];
    if (!author)
    {
        author = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([BooksAuthor class])
                                               inManagedObjectContext:self.managedObjectContext];
        author.name = authorName;
    }
    book.author = author;
    
    r = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([BooksGenre class])];
    namePredicate = [NSPredicate predicateWithFormat:@"name == %@", genreName];
    r.predicate = namePredicate;
    BooksGenre *genre = [[self.managedObjectContext executeFetchRequest:r error:nil] lastObject];
    if (!genre)
    {
        genre = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([BooksGenre class])
                                              inManagedObjectContext:self.managedObjectContext];
        genre.name = genreName;
    }
    book.genre = genre;
    
    
    Comment *commentary = [NSEntityDescription insertNewObjectForEntityForName:@"Comment"
                                                        inManagedObjectContext:self.managedObjectContext];
    commentary.name = self.commentaryTextField.text;
    book.comment = [NSSet setWithObject:commentary];

    
    NSError *error;
    if (![self.managedObjectContext save:&error])
    {
        NSLog(@"Couldn't save: %@", [error localizedDescription]);
    }
    
    self.titleTextField.text = @"";
    self.authorTextField.text = @"";
    self.genreTextField.text = @"";
    self.commentaryTextField.text = @"";
    self.ratingTextField.text = @"";
   
    [self.view endEditing:YES];
    
}



- (IBAction)backButtonTapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:Nil];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)showPhoneBook:(id)sender
{
    
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
        [self.authorTextField becomeFirstResponder];
    }
    else if ([textField isEqual:self.authorTextField])
    {
        [self.commentaryTextField becomeFirstResponder];
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
