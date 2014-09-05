//
//  UserTableViewController.m
//  JaVendi
//
//  Created by Robson Ribeiro on 9/5/14.
//  Copyright (c) 2014 rob. All rights reserved.
//

#import <MFSideMenu/MFSideMenu.h>
#import "UserTableViewController.h"
#import "AppDelegate.h"

@interface UserTableViewController ()

@property (nonatomic) BOOL session;

@end

@implementation UserTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Menu"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(menuView)];
    self.navigationItem.leftBarButtonItem = menuButton;
    self.tableView.scrollEnabled = NO;
    AppDelegate *appDelegate = [[AppDelegate alloc] init];
    self.session = appDelegate.session;
}

- (void) menuView
{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cadastreCell" forIndexPath:indexPath];
    
    UITextField *textfield = (UITextField *)[cell viewWithTag:10];
    textfield.delegate = self;
    textfield.tag = indexPath.row;
    
    switch (indexPath.row) {
        case 0:
            textfield.placeholder = @"Nome Completo";
            break;
        case 1:
            textfield.placeholder = @"E-mail";
            break;
            
        case 2:
        {
            textfield.placeholder = @"Senha";
            textfield.secureTextEntry = YES;
            break;
        }
        case 3:
        {
            textfield.placeholder = @"Confirma Senha";
            textfield.secureTextEntry = YES;
            break;
        }
        case 4:
        {
            textfield.placeholder = @"Telefone";
            textfield.keyboardType = UIKeyboardTypePhonePad;
            break;
        }
        case 5:
        {
            UIButton *cadastreButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,cell.frame.size.width, cell.frame.size.height)];
            [cadastreButton setBackgroundColor:[UIColor lightGrayColor]];
            if (self.session)
            {
                [cadastreButton setTitle:@"Salvar" forState:UIControlStateNormal];
            }
            else
            {
                [cadastreButton setTitle:@"Cadastrar" forState:UIControlStateNormal];
            }
            
            
            [cadastreButton addTarget:self action:@selector(cadastre) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:cadastreButton];
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (void)cadastre
{
    NSLog(@"cadastre tapped");
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
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

@end
