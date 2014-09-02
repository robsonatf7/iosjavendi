//
//  SearchTableViewController.m
//  JaVendi
//
//  Created by Robson Ribeiro on 9/2/14.
//  Copyright (c) 2014 rob. All rights reserved.
//

#import "SearchTableViewController.h"

@interface SearchTableViewController () <UIAlertViewDelegate>
@property (strong, nonatomic) NSArray *options;
@property (strong, nonatomic) NSMutableArray *parametersArray;
@end

@implementation SearchTableViewController

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
    
    self.options = [NSArray arrayWithObjects:@"Palavra-Chave", @"Categoria", @"Preço de:", @"Preço até:", nil];
    self.parametersArray = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        [self.parametersArray insertObject:@"Selecionar" atIndex:i];
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return self.options.count;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"Cell"];
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = [self.options objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [self.parametersArray objectAtIndex:indexPath.row];
    } else {
        UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
        [searchButton setBackgroundColor:[UIColor lightGrayColor]];
        [searchButton setTitle:@"Buscar" forState:UIControlStateNormal];
        [searchButton addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:searchButton];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UIAlertView *keywordInput = [[UIAlertView alloc] initWithTitle:@"Palavra-Chave"
                                                                   message:@"Digite uma palavra-chave para a sua busca:"
                                                                  delegate:self
                                                         cancelButtonTitle:@"Cancelar"
                                                         otherButtonTitles:@"OK", nil];
            [keywordInput setAlertViewStyle:UIAlertViewStylePlainTextInput];
            [[keywordInput textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeDefault];
            [keywordInput setTag:0];
            [keywordInput show];
        }
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 0) {
        if (buttonIndex != alertView.cancelButtonIndex) {
            [self.parametersArray replaceObjectAtIndex:0 withObject:[alertView textFieldAtIndex:0].text];
        }
        [self.tableView reloadData];
    }
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
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)search {
    NSLog(@"search pressed");
}

@end
