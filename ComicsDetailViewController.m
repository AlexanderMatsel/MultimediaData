//
//  ComicsDetailViewController.m
//  MultimediaData
//
//  Created by Alexander on 30.10.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "ComicsDetailViewController.h"
#import "AppDelegate.h"
#import "ComicsPublisher.h"
#import "Comics.h"
#import "Comment.h"

@interface ComicsDetailViewController ()

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong)NSArray* fetchedRecordsArray;

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *authorTextField;
@property (weak, nonatomic) IBOutlet UITextField *commentaryTextField;
@property (weak, nonatomic) IBOutlet UITextField *ratingTextField;

@end

@implementation ComicsDetailViewController

- (void)initialSetup
{
    self.titleTextField.text = self.selectedComics.title;
    self.authorTextField.text = self.selectedComics.publisher.name;
    self.ratingTextField.text = self.selectedComics.rating;
    
    NSArray *comments = [self.selectedComics.comment allObjects];
    self.commentaryTextField.text = ((Comment*)[comments objectAtIndex:0]).name;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Готово"
                                                                              style:self.editButtonItem.style
                                                                             target:self
                                                                             action:@selector(doneButtonPressed)];
    
}


- (void)doneButtonPressed
{
    self.selectedComics.title = self.titleTextField.text;
    self.selectedComics.publisher.name = self.authorTextField.text;
    self.selectedComics.rating = self.ratingTextField.text;
    
    NSArray* comments = [self.selectedComics.comment allObjects];
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
