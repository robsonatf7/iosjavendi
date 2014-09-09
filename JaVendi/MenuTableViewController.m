//
//  MenuTableViewController.m
//  JaVendi
//
//  Created by Robson Ribeiro on 9/4/14.
//  Copyright (c) 2014 rob. All rights reserved.
//

#import <MFSideMenu/MFSideMenu.h>
#import "MenuTableViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"

@interface MenuTableViewController ()

@property (nonatomic, strong) NSArray *menuArray;

@property (nonatomic) BOOL session;

@end

@implementation MenuTableViewController

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
    [self reloadMenuView];
    self.tableView.scrollEnabled = NO;    
}

- (void) reloadMenuView
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.session = appDelegate.session;
    
    if (self.session)
        self.menuArray = @[@"Home", @"Novo anúncio", @"Meus anúncios", @"Favoritos", @"Perfil", @"Configurações"];
    else
        self.menuArray = @[@"Home", @"Login", @"Cadastro"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.menuArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.menuArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.session) {
        switch (indexPath.row) {
            case 0:
                {
                    UINavigationController *home = [[UINavigationController alloc] initWithRootViewController:[[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                        instantiateViewControllerWithIdentifier:@"MainScreenViewController"]];
                    [self.menuContainerViewController setCenterViewController:home];
                    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
                    break;
                }
            case 1:
                {
                    UINavigationController *adCadastre = [[UINavigationController alloc] initWithRootViewController:[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"AdCadastreViewController"]];
                    [self.menuContainerViewController setCenterViewController:adCadastre];
                    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
                    break;
                }
            case 2:
                
                break;
            case 3:
                
                break;
            case 4:
                
                break;
            default:
                break;
        }
    } else {
        switch (indexPath.row) {
            case 0:
            {
                UINavigationController *home = [[UINavigationController alloc] initWithRootViewController:[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MainScreenViewController"]];
                [self.menuContainerViewController setCenterViewController:home];
                [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
                
                break;
            }
            case 1:
            {
                [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
                UINavigationController *login = [[UINavigationController alloc] initWithRootViewController:[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginViewController"]];
                [[self.menuContainerViewController centerViewController] presentViewController:login animated:YES completion:nil];
                
//                UINavigationController *login = [[UINavigationController alloc] initWithRootViewController:[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginViewController"]];
//                [self.menuContainerViewController setCenterViewController:login];
//                [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
                break;
            }
            case 2:
            {
                UINavigationController *cadastreVC = [[UINavigationController alloc] initWithRootViewController:[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CadastreTableViewController"]];
                [self.menuContainerViewController setCenterViewController:cadastreVC];
                [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
                
                break;
            }
            default:
                break;
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
