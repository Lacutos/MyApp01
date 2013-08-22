//
//  ListTableViewController.m
//  MyApp01
//
//  Created by Lacutos on 13/6/27.
//  Copyright (c) 2013年 Jason.Cai. All rights reserved.
//

#import "ListTableViewController.h"
#import "ListData.h"

@interface ListTableViewController ()
- (void)InitHeader;
- (void)AddTestData;
@end

@implementation ListTableViewController
@synthesize m_mtaData;
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
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//    [self InitHeader];
    if(nil == self.m_mtaData)
    {
        self.m_mtaData = [NSMutableArray array];
    }
    //測試碼
    [self AddTestData];
    //測試碼結束
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    return [self.m_mtaData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(nil != cell)
    {
        for(UIView* view in cell.subviews)
        {
            [view removeFromSuperview];
        }
    }
    ListData *Data = [self.m_mtaData objectAtIndex:indexPath.row];
    
    UILabel *LabelName = [[UILabel alloc]initWithFrame:CGRectMake(20,
                                                                 0,
                                                                 80,
                                                                  40)];
    [LabelName setText:Data.m_Name];
    [cell addSubview:LabelName];
    [LabelName release];
    
    UILabel *LabelAddr = [[UILabel alloc]initWithFrame:CGRectMake(20,
                                                                  50,
                                                                  200,
                                                                  40)];
    [cell addSubview:LabelAddr];
    [LabelAddr release];
    
    // Configure the cell...
    
    return cell;
}
- (void)dealloc
{
    if(nil != self.m_mtaData)
    {
        [self.m_mtaData removeAllObjects];
        [self.m_mtaData release];
    }
    [super dealloc];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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
//============================================================================================================
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}
//============================================================================================================
- (void)InitHeader
{
    
    UIView *HeaderView = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                                0,
                                                                320,
                                                                200)];
    
    
    
    self.tableView.tableHeaderView = HeaderView;
}
//============================================================================================================
- (void)AddTestData
{
    if(nil == self.m_mtaData)
    {
        self.m_mtaData = [NSMutableArray array];
    }
    
    ListData *TestData = [ListData alloc];
    TestData.m_Name = @"測試醫師";
    TestData.m_Addr = @"台北市中山區林森北路一段100號";

    [self.m_mtaData addObject:TestData];

}
//============================================================================================================
@end



























