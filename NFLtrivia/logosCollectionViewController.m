//
//  logosCollectionViewController.m
//  NFLtrivia
//
//  Created by administrator on 11/09/14.
//
//

#import "logosCollectionViewController.h"
#import "myCell.h"
#import "individualLogoViewController.h"

@interface logosCollectionViewController ()

@end

@implementation logosCollectionViewController

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
    self.nflLogos = [@[@"nfl1.jpg",
                    @"nfl2.jpg",
                    @"nfl3.jpg",
                    @"nfl4.jpg",
                    @"nfl5.jpg",
                    @"nfl6.jpg",
                    @"nfl7.jpg",
                    @"nfl8.jpg",
                    @"nfl9.jpg",
                       @"nfl10.jpg",
                       @"nfl11.jpg",
                       @"nfl12.jpg",
                       @"nfl13.jpg",
                       @"nfl14.jpg",
                       @"nfl15.jpg",
                       @"nfl16.jpg",
                       @"nfl17.jpg",
                       @"nfl18.jpg",
                       @"nfl19.jpg",
                    @"nfl20.jpg",
                       @"nfl21.jpg",
                       @"nfl22.jpg",
                       @"nfl23.jpg",
                       @"nfl24.jpg",
                       @"nfl25.jpg",
                       @"nfl26.png",
                       @"nfl27.jpg",
                       @"nfl28.jpg",
                       @"nfl29.png",
                       @"nfl30.jpg",
                       @"nfl31.jpg",
                       @"nfl32.jpg"] mutableCopy];

[self.navigationController setNavigationBarHidden:YES];
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) prefersStatusBarHidden {
    return YES;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.nflLogos.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    myCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"logoCell" forIndexPath:indexPath];
    
    
    long row = [indexPath row];
    
    UIImage *image = [UIImage imageNamed:self.nflLogos[row]];
    cell.imageView.image = image;
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    
   
    
    UICollectionViewCell *datasetCell =[collectionView cellForItemAtIndexPath:indexPath];
    datasetCell.backgroundColor = [UIColor blueColor]; // highlight selection
    
    NSString *nameSelected = [self.nflLogos objectAtIndex:indexPath.row];
    NSLog(@"nameSelected: %@ ...", nameSelected);
  
    individualLogoViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"individualLogo"];
    [self.navigationController pushViewController:secondViewController animated:YES];
    
    
   
    secondViewController.photoViewPro = nameSelected;
    
    
    
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

@end
