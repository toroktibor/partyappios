//
//  PickerForSearchView.m
//  bcsapat
//
//  Created by hallgato on 1/17/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "PickerForSearchView.h"
#import "MenuSearchView.h"

@interface PickerForSearchView ()

@end

@implementation PickerForSearchView
@synthesize typePicker,types,result;

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
	// Do any additional setup after loading the view.
    
    //a types tömbben tároljuk a lehetesőg, amelyek közül lehet pickelni
    types = [[NSArray alloc] initWithObjects:@"Étterem", @"Kocsma", @"Kávézó",nil];
    
    typePicker.delegate = self;
    typePicker.dataSource = self;
    typePicker.showsSelectionIndicator = YES;
    [self.view addSubview:typePicker];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ok:(id)sender {
    
    MenuSearchView *MenuSearchView=
    [self.storyboard instantiateViewControllerWithIdentifier:@"MenuSearchView"];
    [MenuSearchView.clubType setText:result];
    [self dismissViewControllerAnimated:YES completion:nil];
}



//meg mondja hány oszlopból tudjunk választani
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}


//megmondja hány lehetőség közül lehet választani
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return types.count;
}

//pick a lehetőségek közül
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString * picked = nil;
    
    for (int i=0; i<types.count; ++i) {
        if (i==row) {
            picked=[types objectAtIndex:i];
        }
    }
    
    return picked;
}

//a result válozóban elhelyezzük a pickelt lehetőséget
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    result = [types objectAtIndex:row];
    
}

@end
