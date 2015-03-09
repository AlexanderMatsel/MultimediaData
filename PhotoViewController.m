//
//  PhotoViewController.m
//  MultimediaData
//
//  Created by Alexander on 26.10.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "PhotoViewController.h"
#import "Photo.h"
#import "Comment.h"
#import "PhotoTheme.h"
#import "AppDelegate.h"


@interface PhotoViewController ()<UITextFieldDelegate>

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;


@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *commentaryTextField;
@property (weak, nonatomic) IBOutlet UITextField *ratingTextField;
@property (weak, nonatomic) IBOutlet UITextField *genreTextField;

- (IBAction)backButtonTapped:(id)sender;
- (IBAction)addPhotoEntry:(id)sender;
- (IBAction)showPhoto:(id)sender;

@end

@implementation PhotoViewController


-(IBAction)addPhotoEntry:(id)sender
{
    Photo *photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo"
                                                inManagedObjectContext:self.managedObjectContext];
    
    photo.name = self.titleTextField.text;
    photo.rating = self.ratingTextField.text;
    
    NSString *genreName = self.genreTextField.text;
    
    NSFetchRequest *r = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([PhotoTheme class])];
    NSPredicate *namePredicate = [NSPredicate predicateWithFormat:@"name == %@", genreName];
    r.predicate = namePredicate;
    
    PhotoTheme *theme = [[self.managedObjectContext executeFetchRequest:r error:nil] lastObject];
    if (!theme)
    {
        theme = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([PhotoTheme class])
                                               inManagedObjectContext:self.managedObjectContext];
        theme.name = genreName;
    }
    photo.theme = theme;
    
    
    Comment *commentary = [NSEntityDescription insertNewObjectForEntityForName:@"Comment"
                                                        inManagedObjectContext:self.managedObjectContext];
    commentary.name = self.commentaryTextField.text;
    photo.comment = [NSSet setWithObject:commentary];
    
    
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

- (IBAction)showPhoto:(id)sender
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
        [self.titleTextField becomeFirstResponder];
    }
    else if ([textField isEqual:self.genreTextField])
    {
        [self.commentaryTextField becomeFirstResponder];
    }
    
    else if ([textField isEqual:self.commentaryTextField])
    {
        [self.ratingTextField resignFirstResponder];
    }
    return YES;
}
@end
