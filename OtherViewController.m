//
//  OtherViewController.m
//  MultimediaData
//
//  Created by Alexander on 30.10.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "OtherViewController.h"
#import "AppDelegate.h"
#import "Comment.h"
#import "Other.h"
#import "OtherTheme.h"



@interface OtherViewController ()

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;


@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *commentaryTextField;
@property (weak, nonatomic) IBOutlet UITextField *ratingTextField;
@property (weak, nonatomic) IBOutlet UITextField *genreTextField;

- (IBAction)backButtonTapped:(id)sender;
- (IBAction)addOtherEntry:(id)sender;
- (IBAction)showOther:(id)sender;


@end

@implementation OtherViewController

-(IBAction)addOtherEntry:(id)sender
{
    Other *other = [NSEntityDescription insertNewObjectForEntityForName:@"Other"
                                                inManagedObjectContext:self.managedObjectContext];
    
    other.title = self.titleTextField.text;
    other.rating = self.ratingTextField.text;
    
    NSString *genreName = self.genreTextField.text;
    
    NSFetchRequest *r = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([OtherTheme class])];
    NSPredicate *namePredicate = [NSPredicate predicateWithFormat:@"name == %@", genreName];
    r.predicate = namePredicate;
    
    OtherTheme *genre = [[self.managedObjectContext executeFetchRequest:r error:nil] lastObject];
    if (!genre)
    {
        genre = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([OtherTheme class])
                                               inManagedObjectContext:self.managedObjectContext];
        genre.name = genreName;
    }
    other.theme = genre;
    
    Comment *commentary = [NSEntityDescription insertNewObjectForEntityForName:@"Comment"
                                                        inManagedObjectContext:self.managedObjectContext];
    commentary.name = self.commentaryTextField.text;
    other.comment = [NSSet setWithObject:commentary];
    
    
    NSError *error;
    if (![self.managedObjectContext save:&error])
    {
        NSLog(@"Couldn't save: %@", [error localizedDescription]);
    }
    
    self.titleTextField.text = @"";
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

- (IBAction)showOther:(id)sender
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
        [self.genreTextField becomeFirstResponder];
    }
    else if ([textField isEqual:self.genreTextField])
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
