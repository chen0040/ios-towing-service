//
//  HistoryViewController.m
//  AAS
//
//  Created by Chen Xianshun on 20/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HistoryViewController.h"
#import "AccInfo.h"
#import "HistoryManager.h"
#import "HistoryCell.h"
#import "HistoryEntry.h"
#import "HistoryDetailViewController.h"

static NSString* NotificationNameHistoryChange=@"HistoryChangeNotification";
static NSString* const PushHistoryDetailSegueIdentifier=@"Push History Detail";

@interface HistoryViewController ()
-(void) reloadTableData;
-(void) historyManagerChanged:(NSDictionary*)change;
@end

@implementation HistoryViewController
@synthesize account=_account;
@synthesize historyManager=_historyManager;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
     
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleHistoryChanged:) name:NotificationNameHistoryChange object:nil];
}

- (void)handleHistoryChanged:(NSNotification*)notification
{
    [self reloadTableData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
     
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.historyManager addObserver:self forKeyPath:KVOHistoryChangeKey options:NSKeyValueObservingOptionNew context:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.historyManager removeObserver:self forKeyPath:KVOHistoryChangeKey];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.historyManager.histories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"History Cell";
    HistoryCell *cell = (HistoryCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    HistoryEntry* entry=[self.historyManager.histories objectAtIndex:indexPath.row];
    [cell configureWithHistoryEntry:entry];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.historyManager removeHistoryAtIndex:indexPath.row];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

-(void) reloadTableData
{
    [self.tableView reloadData];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:KVOHistoryChangeKey])
    {
        [self historyManagerChanged:change];
    }
}

-(void) historyManagerChanged:(NSDictionary *)change
{
    /*
    NSNumber* value=[change objectForKey:NSKeyValueChangeKindKey];
    NSIndexSet* indexes=[change objectForKey:NSKeyValueChangeIndexesKey];
    NSMutableArray* indexPaths=[[NSMutableArray alloc] initWithCapacity:[indexes count]];
    [indexes enumerateIndexesUsingBlock:^(NSUInteger indexValue, BOOL *stop) {
        NSIndexPath* indexPath=[NSIndexPath indexPathForRow: indexValue inSection: 0];
        [indexPaths addObject:indexPath];
    }];
    
    switch([value intValue])
    {
        case NSKeyValueChangeInsertion:
            [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSKeyValueChangeRemoval:
            [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSKeyValueChangeSetting:
            break;
        default:
            [NSException raise: NSInvalidArgumentException format:@"Change kind value %d not recognized", [value intValue]];
    }*/
    [self reloadTableData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:PushHistoryDetailSegueIdentifier])
    {
        HistoryDetailViewController* controller=segue.destinationViewController;
        controller.historyManager=self.historyManager;
        controller.account=self.account;
        controller.selectedIndex=[self.tableView indexPathForSelectedRow].row;
    }
}


@end
