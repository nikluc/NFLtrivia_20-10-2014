//
//  twoCategorySecondViewController.m
//  NFLtrivia
//
//  Created by administrator on 11/10/14.
//
//

#import "twoCategorySecondViewController.h"
#import "secondCategoryViewController.h"

@interface twoCategorySecondViewController ()

@end

@implementation twoCategorySecondViewController

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
    self.teamLogoView.text = self.photoName;
    NSLog(@"photooooo nameeee%@",self.photoName);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)selectedTeamQuestion:(id)sender {
}

- (IBAction)currentWeekQuestion:(id)sender {
    
    
    [self performSegueWithIdentifier:@"secondPush" sender:self];
    
    
    
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if ([segue.identifier isEqualToString:@"secondPush"]) {
        
        
        secondCategoryViewController *secondViewController = segue.destinationViewController;
        
        secondViewController.photoId = self.photoId;
        secondViewController.photoName = self.photoName;
        secondViewController.userId = self.userId;
        secondViewController.photoViewPro = self.photoViewPro;
      //  secondViewController.directTeamId= self.directTeamId;
        
        
        
        
        
    }
    
}

    

@end
