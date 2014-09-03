//
//  SearchViewController.m
//  JaVendi
//
//  Created by Robson Ribeiro on 9/3/14.
//  Copyright (c) 2014 rob. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
@property (strong, nonatomic) NSArray *options;
@property (strong, nonatomic) NSMutableArray *parametersArray;

// Picker View
@property (weak, nonatomic) IBOutlet UIView *fadeView;
@property (weak, nonatomic) IBOutlet UIView *pickerViewHolder;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
- (IBAction)cancelPickerView:(id)sender;
- (IBAction)donePickerView:(id)sender;
@end

@implementation SearchViewController

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
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // We don't our table view to scroll
    self.tableView.scrollEnabled = NO;
    
    self.options = [NSArray arrayWithObjects:@"Palavra-Chave", @"Categoria", @"Preço de:", @"Preço até:", nil];
    self.parametersArray = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        [self.parametersArray insertObject:@"Selecionar" atIndex:i];
    }
}

#pragma mark - UITableView DataSource

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
        } else {
            switch (indexPath.row) {
                case 1:
                    [self showPickerView];
                    break;
                    
                default:
                    break;
            }
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

#pragma mark - Actions

- (void)search {
    NSLog(@"search pressed");
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Picker View

- (IBAction)cancelPickerView:(id)sender {
}

- (IBAction)donePickerView:(id)sender {
}

- (void)showPickerView
{
    [UIView animateWithDuration:0.2f delay:0.f options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self.view bringSubviewToFront:self.fadeView];
        self.fadeView.alpha = 0.5f;
    } completion:^(BOOL finished) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3f];
        self.pickerViewHolder.frame = CGRectMake(0,
                                                 375,
                                                 self.pickerViewHolder.frame.size.width,
                                                 self.pickerViewHolder.frame.size.height);
        [self.view bringSubviewToFront:self.pickerViewHolder];
        [UIView commitAnimations];
//        [UIView animateWithDuration:105.2f delay:0.f options:UIViewAnimationOptionCurveEaseIn animations:^{
//            self.pickerViewHolder.frame = CGRectMake(0,
//                                                     375,
//                                                     self.pickerViewHolder.frame.size.width,
//                                                     self.pickerViewHolder.frame.size.height);
//            [self.view bringSubviewToFront:self.pickerViewHolder];
//        } completion:nil];
    }];

}

- (void)hidePickerView
{
    
}

@end
