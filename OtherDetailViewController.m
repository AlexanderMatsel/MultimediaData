//
//  OtherDetailViewController.m
//  MultimediaData
//
//  Created by Alexander on 30.10.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "OtherDetailViewController.h"
#import "AppDelegate.h"
#import "OtherTheme.h"
#import "Other.h"
#import "Comment.h"

@interface OtherDetailViewController ()

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSArray* fetchedRecordsArray;

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *commentaryTextField;
@property (weak, nonatomic) IBOutlet UITextField *ratingTextField;
@property (weak, nonatomic) IBOutlet UITextField *genreTextField;

@end

@implementation OtherDetailViewController

- (void)initialSetup
{
    self.titleTextField.text = self.selectedOther.title;
    self.genreTextField.text = self.selectedOther.theme.name;
    self.ratingTextField.text = self.selectedOther.rating;
    
    NSArray *comments = [self.selectedOther.comment allObjects];
    self.commentaryTextField.text = ((Comment*)[comments objectAtIndex:0]).name;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Готово"
                                                                              style:self.editButtonItem.style
                                                                             target:self
                                                                             action:@selector(doneButtonPressed)];
    
}


- (void)doneButtonPressed
{
    self.selectedOther.title = self.titleTextField.text;
    self.selectedOther.theme.name = self.genreTextField.text;
    self.selectedOther.rating = self.ratingTextField.text;
    
    NSArray* comments = [self.selectedOther.comment allObjects];
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
