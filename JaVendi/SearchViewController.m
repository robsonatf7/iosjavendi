//
//  SearchViewController.m
//  JaVendi
//
//  Created by Robson Ribeiro on 9/3/14.
//  Copyright (c) 2014 rob. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) NSArray *options;
@property (strong, nonatomic) NSMutableArray *parametersArray;
@property (strong, nonatomic) NSMutableArray *pickerViewData;

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
    
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
    // Adding gesture recognizer on Fade View to dismiss it on click
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePickerView)];
    [singleTap setNumberOfTapsRequired:1];
    [self.fadeView addGestureRecognizer:singleTap];
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
                    [self setupPickerViewDataForType:PickerViewValueTypeCategories];
                    [self comeInPickerViewAnimation];
                    self.pickerView.tag = 1;
                    break;
                    
                case 2:
                    [self setupPickerViewDataForType:PickerViewValueTypePrices];
                    [self comeInPickerViewAnimation];
                    self.pickerView.tag = 2;
                    break;
                    
                case 3:
                    [self setupPickerViewDataForType:PickerViewValueTypePrices];
                    [self comeInPickerViewAnimation];
                    self.pickerView.tag = 3;
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

- (void)setupPickerViewDataForType:(PickerViewValueType)valueType
{
    self.pickerViewData = [NSMutableArray array];
    if(valueType == PickerViewValueTypePrices) {
        for (int i = 1; i <= 10; i++) [self.pickerViewData addObject:[NSString stringWithFormat:@"R$ %i", (i * 100)]];
    } else if (valueType ==  PickerViewValueTypeCategories) {
        [self.pickerViewData addObject:@"Informática"];
        [self.pickerViewData addObject:@"Jogos e Consoles"];
    }
    [self.pickerView reloadAllComponents];
}

- (IBAction)cancelPickerView:(id)sender {
    [self hidePickerView];
}

- (IBAction)donePickerView:(id)sender {
    id object = [self.pickerViewData objectAtIndex:[self.pickerView selectedRowInComponent:0]];
    [self.parametersArray replaceObjectAtIndex:self.pickerView.tag withObject:object];
    [self.tableView reloadData];
    [self hidePickerView];
}

#pragma mark - PickerView Delegate

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.pickerViewData count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.pickerViewData objectAtIndex:row];
}

#pragma mark - PickerView Animation

- (void)comeInPickerViewAnimation
{
    self.fadeView.frame = CGRectMake(0, 0, self.fadeView.frame.size.width, self.fadeView.frame.size.height);
    
    [UIView beginAnimations:nil context:@selector(showPickerView)];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	[UIView setAnimationDuration:0.2];
    self.fadeView.backgroundColor =[[UIColor blackColor] colorWithAlphaComponent:0.5f];
	[UIView commitAnimations];
}

- (void)animationFinished:(NSString*)animationID finished:(BOOL)finished context:(void*)context
{
	if (context) {
		[self performSelector:context];
	}
}

- (void)showPickerView
{
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	[UIView setAnimationDuration:0.3f];
//    self.pickerViewHolder.frame = CGRectMake(0,
//                                             338,
//                                             self.pickerViewHolder.frame.size.width,
//                                             self.pickerViewHolder.frame.size.height);
    self.pickerViewHolder.frame = CGRectMake(0,
                                             self.view.frame.size.height - self.pickerViewHolder.frame.size.height,
                                             self.pickerViewHolder.frame.size.width,
                                             self.pickerViewHolder.frame.size.height);

	[UIView commitAnimations];
}

- (void)hidePickerView
{
    [UIView beginAnimations:nil context:@selector(comeOutPickerViewAnimation)];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	[UIView setAnimationDuration:0.2];
//    self.pickerViewHolder.frame = CGRectMake(0,
//                                             568,
//                                             self.pickerViewHolder.frame.size.width,
//                                             self.pickerViewHolder.frame.size.height);
    self.pickerViewHolder.frame = CGRectMake(0,
                                             self.view.frame.size.height,
                                             self.pickerViewHolder.frame.size.width,
                                             self.pickerViewHolder.frame.size.height);
	[UIView commitAnimations];
}

- (void)comeOutPickerViewAnimation
{
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	[UIView setAnimationDuration:0.2];
    self.fadeView.backgroundColor = [UIColor clearColor];
	[UIView commitAnimations];
    
    self.fadeView.frame = CGRectMake(0,
                                     self.view.frame.size.height,
                                     self.fadeView.frame.size.width,
                                     self.fadeView.frame.size.height);
}

@end
