//
//  SearchViewController.h
//  JaVendi
//
//  Created by Robson Ribeiro on 9/3/14.
//  Copyright (c) 2014 rob. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    PickerViewValueTypePrices,
    PickerViewValueTypeCategories
} PickerViewValueType;

@interface SearchViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)cancel:(id)sender;

@end
