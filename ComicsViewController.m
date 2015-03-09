//
//  ComicsViewController.m
//  MultimediaData
//
//  Created by Alexander on 30.10.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "ComicsViewController.h"
#import "AppDelegate.h"
#import "Comment.h"
#import "Comics.h"
#import "ComicsPublisher.h"


@interface ComicsViewController ()<UITextFieldDelegate>


@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;


@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *authorTextField;
@property (weak, nonatomic) IBOutlet UITextField *commentaryTextField;
@property (weak, nonatomic) IBOutlet UITextField *ratingTextField;


- (IBAction)backButtonTapped:(id)sender;
- (IBAction)addComicsEntry:(id)sender;
- (IBAction)showComics:(id)sender;


@end

@implementation ComicsViewController

-(IBAction)addComicsEntry:(id)sender
{
    Comics *comics = [NSEntityDescription insertNewObjectForEntityForName:@"Comics"
                                                inManagedObjectContext:self.managedObjectContext];
    
    comics.title = self.titleTextField.text;
    comics.rating = self.ratingTextField.text;
    
    NSString *authorName = self.authorTextField.text;
    
    NSFetchRequest *r = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([ComicsPublisher class])];
    NSPredicate *namePredicate = [NSPredicate predicateWithFormat:@"name == %@",authorName];
    r.predicate = namePredicate;
    
    ComicsPublisher *author = [[self.managedObjectContext executeFetchRequest:r error:nil] lastObject];
    if (!author)
    {
        author = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([ComicsPublisher class])
                                               inManagedObjectContext:self.managedObjectContext];
        author.name = authorName;
    }
    comics.publisher = author;
    
    
    
    Comment *commentary = [NSEntityDescription insertNewObjectForEntityForName:@"Comment"
                                                        inManagedObjectContext:self.managedObjectContext];
    commentary.name = self.commentaryTextField.text;
    comics.comment = [NSSet setWithObject:commentary];
    
    
    NSError *error;
    if (![self.managedObjectContext save:&error])
    {
        NSLog(@"Couldn't save: %@", [error localizedDescription]);
    }
    
    self.titleTextField.text = @"";
    self.authorTextField.text = @"";
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

- (IBAction)showComics:(id)sender
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

@end
