//
//  twoCategoryViewController.m
//  NFLtrivia
//
//  Created by administrator on 10/10/14.
//
//

#import "twoCategoryViewController.h"
#import "firstCategoryViewController.h"

@interface twoCategoryViewController ()

@end

@implementation twoCategoryViewController
@synthesize photoId,userId,photoName;

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
    
    self.selectedFanLabel.text = photoName;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)currentWeekButton:(id)sender {
  
    
}

- (IBAction)selectedFanButton:(id)sender {
      [self performSegueWithIdentifier:@"firstCategory" sender:self];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if ([segue.identifier isEqualToString:@"firstCategory"]) {
        
        
        firstCategoryViewController *verifyViewController = segue.destinationViewController;
        
        verifyViewController.photoId = photoId;
        verifyViewController.userId = userId;
        verifyViewController.photoName = photoName;
        verifyViewController.photoViewPro = self.photoViewPro;
      //  verifyViewController.directTeamId = self.directTeamId;
        
        
        
        
        
    }
    
}




@end
