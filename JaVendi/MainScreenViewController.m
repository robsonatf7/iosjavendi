//
//  MainScreenViewController.m
//  JaVendi
//
//  Created by Robson Ribeiro on 9/2/14.
//  Copyright (c) 2014 rob. All rights reserved.
//

#import "MainScreenViewController.h"
#import <MFSideMenu/MFSideMenu.h>
@interface MainScreenViewController ()

@end

@implementation MainScreenViewController {
    NSMutableArray *array;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    array = [[NSMutableArray alloc]init];
    
    [array addObject:@"icon_baby.png"];
    [array addObject:@"icon_car.png"];
    [array addObject:@"icon_bike.png"];
    [array addObject:@"icon_guitar.png"];
    [array addObject:@"icon_house.png"];
    [array addObject:@"icon_joystick.png"];
    [array addObject:@"icon_pc.png"];
    [array addObject:@"icon_phone.png"];
    [array addObject:@"icon_shirt.png"];
    [array addObject:@"icon_tablet.png"];
    [array addObject:@"icon_tv.png"];
    [array addObject:@"icon_other.png"];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [array count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    UILabel *label = (UILabel *)[cell viewWithTag:100];
    UIImageView *image = (UIImageView *)[cell viewWithTag:150];
    
    [cell.layer setBorderWidth:2.0f];
    [cell.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    image.image = [UIImage imageNamed:[array objectAtIndex:indexPath.row]];
    label.text = [array objectAtIndex:indexPath.row];
    
    return cell;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}

- (IBAction)searchButtonPressed:(id)sender {
}
@end
