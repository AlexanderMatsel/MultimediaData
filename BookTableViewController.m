//
//  BookTableViewController.m
//  MultimediaData
//
//  Created by Alexander on 08.10.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "BookTableViewController.h"
#import "BookViewController.h"
#import "Books.h"
#import "BooksGenre.h"
#import "BooksAuthor.h"
#import "Comment.h"
#import "BookDetailViewController.h"
#import "AppDelegate.h"

@interface BookTableViewController ()

@property (nonatomic,strong)NSArray* fetchedRecordsArray;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (IBAction)backButtonTapped:(id)sender;

@end

@implementation BookTableViewController

@synthesize searchResults;

static NSString *CellIdentifier = @"BookCellReuseID";

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
    
    
    self.fetchedRecordsArray = [[appDelegate getAllBooksRecords]mutableCopy];
    
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
    Books *book = [self.fetchedRecordsArray objectAtIndex:indexPath.row];
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        book = [self.searchResults objectAtIndex:indexPath.row];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Книга: %@, Автор: %@",book.title, book.author.name];

    Comment *commentary = (Comment *)[[book.comment allObjects] objectAtIndex:0];

     cell.detailTextLabel.text = [NSString stringWithFormat:@"Жанр: %@, Комментарий: %@, Рейтинг: %@ ", book.genre.name, commentary.name, book.rating];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    BookDetailViewController* detailController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewControllerIdentifier"];
    
    detailController.selectedBook = [self.fetchedRecordsArray objectAtIndex:indexPath.row];
   
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
        self.fetchedRecordsArray = [appDelegate getAllBooksRecords];
        
        [tableView endUpdates];
    }
}

#pragma mark -
#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    [self.searchResults removeAllObjects];
    for (Books *book in self.fetchedRecordsArray)
    {
        if ([scope isEqualToString:@"All"] || [book.genre.name isEqualToString:scope])
        {
            NSComparisonResult result = [book.genre.name compare:searchText
                                                          options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)
                                                            range:NSMakeRange(0, [searchText length])];
            if (result == NSOrderedSame)
            {
                [self.searchResults addObject:book];
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
