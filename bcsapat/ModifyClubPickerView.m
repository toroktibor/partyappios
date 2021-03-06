//
//  ModifyClubPickerView.m
//  bcsapat
//
//  Created by hallgato on 2/2/14.
//  Copyright (c) 2014 hallgato. All rights reserved.
//

#import "ModifyClubPickerView.h"
#import "Session.h"

@interface ModifyClubPickerView ()

@end

@implementation ModifyClubPickerView
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
    
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bricskok.png"]];
    
    //a types tömbben tároljuk a lehetesőg, amelyek közül lehet pickelni
    types = [[NSArray alloc] initWithObjects:@"Bármelyik",@"Étterem", @"Kocsma", @"Kávézó",@"Pub",@"Club",@"Sport közpönt",@"Disco",nil];
    
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
    
    [[Session getInstance]setClubTypeForPicer:result];
    
}

@end
