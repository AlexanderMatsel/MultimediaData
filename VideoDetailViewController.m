//
//  VideoDetailViewController.m
//  MultimediaData
//
//  Created by Alexander on 29.10.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "VideoDetailViewController.h"
#import "AppDelegate.h"
#import "Video.h"
#import "VideoGenre.h"
#import "VideoQuality.h"
#import "Comment.h"


@interface VideoDetailViewController ()

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSArray* fetchedRecordsArray;

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *qualityTextField;
@property (weak, nonatomic) IBOutlet UITextField *commentaryTextField;
@property (weak, nonatomic) IBOutlet UITextField *ratingTextField;
@property (weak, nonatomic) IBOutlet UITextField *genreTextField;

@end

@implementation VideoDetailViewController

- (void)initialSetup
{
    self.titleTextField.text = self.selectedVideo.title;
    self.qualityTextField.text = self.selectedVideo.quality.name;
    self.genreTextField.text = self.selectedVideo.genre.name;
    self.ratingTextField.text = self.selectedVideo.rating;
    
    NSArray *comments = [self.selectedVideo.comment allObjects];
    self.commentaryTextField.text = ((Comment*)[comments objectAtIndex:0]).name;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Готово"
                                                                              style:self.editButtonItem.style
                                                                             target:self
                                                                             action:@selector(doneButtonPressed)];
    
}


- (void)doneButtonPressed
{
    self.selectedVideo.title = self.titleTextField.text;
    self.selectedVideo.quality.name = self.qualityTextField.text;
    self.selectedVideo.genre.name = self.genreTextField.text;
    self.selectedVideo.rating = self.ratingTextField.text;
    
    NSArray* comments = [self.selectedVideo.comment allObjects];
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
    AppDelegate *appDelegate  = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    [self initialSetup];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
