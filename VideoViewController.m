//
//  VideoViewController.m
//  MultimediaData
//
//  Created by Alexander on 29.10.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "VideoViewController.h"
#import "AppDelegate.h"
#import "Comment.h"
#import "Video.h"
#import "VideoGenre.h"
#import "VideoQuality.h"

@interface VideoViewController ()<UITextFieldDelegate>


@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;


@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *qualityTextField;
@property (weak, nonatomic) IBOutlet UITextField *commentaryTextField;
@property (weak, nonatomic) IBOutlet UITextField *ratingTextField;
@property (weak, nonatomic) IBOutlet UITextField *genreTextField;

- (IBAction)backButtonTapped:(id)sender;
- (IBAction)addVideoEntry:(id)sender;
- (IBAction)showVideo:(id)sender;

@end

@implementation VideoViewController

-(IBAction)addVideoEntry:(id)sender
{
    Video *video = [NSEntityDescription insertNewObjectForEntityForName:@"Video"
                                                inManagedObjectContext:self.managedObjectContext];
    
    video.title = self.titleTextField.text;
    video.rating = self.ratingTextField.text;
    
    NSString *qualityName = self.qualityTextField.text;
    NSString *genreName = self.genreTextField.text;
    
    NSFetchRequest *r = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([VideoQuality class])];
    NSPredicate *namePredicate = [NSPredicate predicateWithFormat:@"name == %@",qualityName];
    r.predicate = namePredicate;
    
    VideoQuality *quality = [[self.managedObjectContext executeFetchRequest:r error:nil] lastObject];
    if (!quality)
    {
        quality = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([VideoQuality class])
                                               inManagedObjectContext:self.managedObjectContext];
        quality.name = qualityName;
    }
    video.quality = quality;
    
    r = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([VideoGenre class])];
    namePredicate = [NSPredicate predicateWithFormat:@"name == %@", genreName];
    r.predicate = namePredicate;
    VideoGenre *genre = [[self.managedObjectContext executeFetchRequest:r error:nil] lastObject];
    if (!genre)
    {
        genre = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([VideoGenre class])
                                              inManagedObjectContext:self.managedObjectContext];
        genre.name = genreName;
    }
    video.genre = genre;
    
    
    Comment *commentary = [NSEntityDescription insertNewObjectForEntityForName:@"Comment"
                                                        inManagedObjectContext:self.managedObjectContext];
    commentary.name = self.commentaryTextField.text;
    video.comment = [NSSet setWithObject:commentary];
    
    
    NSError *error;
    if (![self.managedObjectContext save:&error])
    {
        NSLog(@"Couldn't save: %@", [error localizedDescription]);
    }
    
    self.titleTextField.text = @"";
    self.qualityTextField.text = @"";
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

- (IBAction)showVideo:(id)sender
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
        [self.qualityTextField becomeFirstResponder];
    }
    else if ([textField isEqual:self.qualityTextField])
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
