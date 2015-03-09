//
//  PhotoDetailViewController.m
//  MultimediaData
//
//  Created by Alexander on 26.10.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "PhotoDetailViewController.h"
#import "AppDelegate.h"
#import "Photo.h"
#import "PhotoTheme.h"
#import "Comment.h"



@interface PhotoDetailViewController ()

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong)NSArray* fetchedRecordsArray;

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *commentaryTextField;
@property (weak, nonatomic) IBOutlet UITextField *ratingTextField;
@property (weak, nonatomic) IBOutlet UITextField *genreTextField;

@end

@implementation PhotoDetailViewController

- (void)initialSetup
{
    self.titleTextField.text = self.selectedPhoto.name;
    self.genreTextField.text = self.selectedPhoto.theme.name;
    self.ratingTextField.text = self.selectedPhoto.rating;
    
    NSArray *comments = [self.selectedPhoto.comment allObjects];
    self.commentaryTextField.text = ((Comment*)[comments objectAtIndex:0]).name;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Готово"
                                                                              style:self.editButtonItem.style
                                                                             target:self
                                                                             action:@selector(doneButtonPressed)];
    
}


- (void)doneButtonPressed
{
    self.selectedPhoto.name = self.titleTextField.text;
    self.selectedPhoto.theme.name = self.genreTextField.text;
    self.selectedPhoto.rating = self.ratingTextField.text;
    
    NSArray* comments = [self.selectedPhoto.comment allObjects];
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