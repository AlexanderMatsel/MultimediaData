
//  PhotoTableViewController.m
//  MultimediaData
//
//  Created by Alexander on 26.10.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "PhotoTableViewController.h"
#import "PhotoTheme.h"
#import "Photo.h"
#import "Comment.h"
#import "AppDelegate.h"
#import "PhotoDetailViewController.h"

@interface PhotoTableViewController ()

@property (nonatomic,strong)NSArray* fetchedRecordsArray;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (IBAction)backButtonTapped:(id)sender;

@end

@implementation PhotoTableViewController

@synthesize searchResults;

static NSString *CellIdentifier = @"PhotoCellReuseID";


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.searchResults = [NSMutableArray arrayWithCapacity:44];
    [self.tableView reloadData];
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    
    self.fetchedRecordsArray = [[appDelegate getAllPhotoRecords]mutableCopy];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Изменить"
                                                                              style:self.editButtonItem.style
                                                                             target:self
                                                                             action:@selector(editButtonPressed)];
}


- (void)editButtonPressed
{
    self.tableView.editing = !self.tableView.editing;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [self.searchResults count];
    }
	else
	{
        return [self.fetchedRecordsArray count];
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  mark - Private Methods

- (IBAction)backButtonTapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:Nil];
}

#pragma mark - Table view data source



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    Photo *photo = [self.fetchedRecordsArray objectAtIndex:indexPath.row];
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        photo = [self.searchResults objectAtIndex:indexPath.row];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Фото: %@", photo.name];
    
    Comment *commentary = (Comment *)[[photo.comment allObjects] objectAtIndex:0];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Тема: %@, Комментарий: %@, Рейтинг: %@ ", photo.theme.name, commentary.name, photo.rating];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PhotoDetailViewController* detailController = [self.storyboard instantiateViewControllerWithIdentifier:@"PhotoDetailViewControllerIdentifier"];
    
    detailController.selectedPhoto = [self.fetchedRecordsArray objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:detailController animated:YES];
}




- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
        [self.managedObjectContext deleteObject:[self.fetchedRecordsArray objectAtIndex:indexPath.row]];
        NSError *error;
        if (![self.managedObjectContext save:&error])
        {
            NSLog(@"Couldn't save: %@", [error localizedDescription]);
        }
        
        AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
        self.fetchedRecordsArray = [appDelegate getAllPhotoRecords];
        
        [tableView endUpdates];
    }
}

#pragma mark -
#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    [self.searchResults removeAllObjects];
    for (Photo *photo in self.fetchedRecordsArray)
    {
        if ([scope isEqualToString:@"All"] || [photo.theme.name isEqualToString:scope])
        {
            NSComparisonResult result = [photo.theme.name compare:searchText
                                                                          options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)
                                                                            range:NSMakeRange(0, [searchText length])];
            if (result == NSOrderedSame)
            {
                [self.searchResults addObject:photo];
            }
        }
    }
}

#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:@"All"];
    return YES;
}
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:@"All"];
    return YES;
}

@end
