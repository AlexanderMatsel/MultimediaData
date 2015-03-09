//
//  OtherTableViewController.m
//  MultimediaData
//
//  Created by Alexander on 30.10.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "OtherTableViewController.h"
#import "OtherViewController.h"
#import "Other.h"
#import "OtherTheme.h"
#import "Comment.h"
#import "OtherDetailViewController.h"
#import "AppDelegate.h"

@interface OtherTableViewController ()

@property (nonatomic,strong)NSArray* fetchedRecordsArray;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (IBAction)backButtonTapped:(id)sender;

@end

@implementation OtherTableViewController

@synthesize searchResults;

static NSString *CellIdentifier = @"OtherCellReuseID";

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
    
    
    self.fetchedRecordsArray = [[appDelegate getAllOtherRecords]mutableCopy];
    
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
    Other *other = [self.fetchedRecordsArray objectAtIndex:indexPath.row];
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        other = [self.searchResults objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Файл: %@", other.title];
    
    Comment *commentary = (Comment *)[[other.comment allObjects] objectAtIndex:0];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Жанр: %@, Комментарий: %@, Рейтинг: %@ ", other.theme.name, commentary.name, other.rating];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    OtherDetailViewController* detailController = [self.storyboard instantiateViewControllerWithIdentifier:@"OtherDetailViewControllerIdentifier"];
    
    detailController.selectedOther = [self.fetchedRecordsArray objectAtIndex:indexPath.row];
    
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
        self.fetchedRecordsArray = [appDelegate getAllOtherRecords];
        
        [tableView endUpdates];
    }
}

#pragma mark -
#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    [self.searchResults removeAllObjects];
    for (Other *other in self.fetchedRecordsArray)
    {
        if ([scope isEqualToString:@"All"] || [other.theme.name isEqualToString:scope])
        {
            NSComparisonResult result = [other.theme.name compare:searchText
                                                          options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)
                                                            range:NSMakeRange(0, [searchText length])];
            if (result == NSOrderedSame)
            {
                [self.searchResults addObject:other];
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
