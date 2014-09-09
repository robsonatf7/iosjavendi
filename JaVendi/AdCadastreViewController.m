//
//  AdCadastreViewController.m
//  JaVendi
//
//  Created by Robson Ribeiro on 9/8/14.
//  Copyright (c) 2014 rob. All rights reserved.
//

#import "AdCadastreViewController.h"
#import <MFSideMenu/MFSideMenu.h>

@interface AdCadastreViewController ()

@property (weak, nonatomic) IBOutlet UIButton *addImgOne;
@property (weak, nonatomic) IBOutlet UIButton *addImgTwo;
@property (weak, nonatomic) IBOutlet UIButton *addImgThree;
@property (weak, nonatomic) IBOutlet UIButton *addImgFour;
@property (weak, nonatomic) IBOutlet UIButton *addImgFive;
@property (weak, nonatomic) IBOutlet UIButton *addImgSix;

@end

@implementation AdCadastreViewController

@synthesize imagePicker;

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Menu"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(menuView)];
    self.navigationItem.leftBarButtonItem = menuButton;
    
    UIImage *btnImage = [UIImage imageNamed:@"add_photo_1.png"];
    
    [self.addImgOne   setImage:btnImage forState:UIControlStateNormal];
    [self.addImgOne addTarget:self action:@selector(pickImage) forControlEvents:UIControlEventTouchUpInside];
    
    [self.addImgTwo   setImage:btnImage forState:UIControlStateNormal];
    [self.addImgTwo addTarget:self action:@selector(pickImage) forControlEvents:UIControlEventTouchUpInside];
    
    [self.addImgThree setImage:btnImage forState:UIControlStateNormal];
    [self.addImgThree addTarget:self action:@selector(pickImage) forControlEvents:UIControlEventTouchUpInside];
    
    [self.addImgFour  setImage:btnImage forState:UIControlStateNormal];
    [self.addImgFour addTarget:self action:@selector(pickImage) forControlEvents:UIControlEventTouchUpInside];
    
    [self.addImgFive  setImage:btnImage forState:UIControlStateNormal];
    [self.addImgFive addTarget:self action:@selector(pickImage) forControlEvents:UIControlEventTouchUpInside];
    
    [self.addImgSix   setImage:btnImage forState:UIControlStateNormal];
    [self.addImgSix addTarget:self action:@selector(pickImage) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) menuView
{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}

- (IBAction)menuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}

- (void)pickImage
{
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(void)imagePickerCOntroller:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
}

@end
