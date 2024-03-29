//
//  MainScreenViewController.h
//  JaVendi
//
//  Created by Robson Ribeiro on 9/2/14.
//  Copyright (c) 2014 rob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainScreenViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *categoriesCollectionView;

- (IBAction)menuButtonPressed:(id)sender;

- (IBAction)searchButtonPressed:(id)sender;

@end
