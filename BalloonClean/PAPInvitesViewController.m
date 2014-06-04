//
//  PAPInvitesViewController.m
//  Balloon
//
//  Created by Sean Wertheim on 6/3/14.
//
//

#import "PAPInvitesViewController.h"
#import "PAPCardView.h"
#import "ParseInviteManager.h"
#import "Invite.h"
#import "PAPCardView.h"
#import "CountdownLabel.h"
#import "CardsViewFlowLayout.h"

@interface PAPInvitesViewController () <UICollectionViewDataSource, UICollectionViewDelegate, PAPCardViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) ParseInviteManager *inviteManager;
@property (strong, nonatomic) NSMutableArray *invites;

@end

@implementation PAPInvitesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        // additional setup here if required.
    }
    return self;
}

-(void)setupCollectionView{
    CardsViewFlowLayout *layout=[[CardsViewFlowLayout alloc] init];
    [layout setItemSize:CGSizeMake(230, 316)];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [layout setSectionInset:UIEdgeInsetsMake(10, 0, 10, 0)];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 230, 316) collectionViewLayout:layout];
    self.collectionView.pagingEnabled = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    
    self.collectionView.contentInset = UIEdgeInsetsMake((self.view.frame.size.height - 316)/2, 0, (self.view.frame.size.height - 316)/2, 0);
    [self.collectionView registerNib:[UINib nibWithNibName:@"PAPCardView" bundle:nil] forCellWithReuseIdentifier:@"CardCellIdentifier"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.inviteManager = [[ParseInviteManager alloc] init];
    self.invites = [[NSMutableArray alloc] init];
    
    [self.inviteManager queryForInvites:^(BOOL finished){
        if(finished){
            for(Invite *invite in self.inviteManager.invites){
                PAPCardView *currentCard = [[PAPCardView alloc] init];
                currentCard.recipientLabel.text = @"Sean";
                currentCard.senderLabel.text = invite.sender;
                currentCard.messageLabel.text = invite.message;
                currentCard.locationLabel.text = invite.location;
                currentCard.expirationLabel = [[CountdownLabel alloc] initWithEventDate:invite.repsondByDate tolerance:1000];
                [self.invites addObject:currentCard];
            }
            [self setupCollectionView];
        }
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView {
    // _data is a class member variable that contains one array per section.
    return self.invites.count;
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PAPCardView *cell = (PAPCardView*)[collectionView dequeueReusableCellWithReuseIdentifier:@"CardCellIdentifier" forIndexPath:indexPath];
    
    cell.delegate = self;
    
    Invite *currentInvite = self.inviteManager.invites[indexPath.section];
    
    cell.recipientLabel.text = @"Sean";
    cell.senderLabel.text = currentInvite.sender;
    cell.messageLabel.text = currentInvite.message;
    cell.locationLabel.text = currentInvite.location;
    cell.expirationLabel = [[CountdownLabel alloc] initWithEventDate:currentInvite.repsondByDate tolerance:1000];
    
    return cell;
}

#pragma mark PAPCardViewDelegate Methods

-(void)dismissLeftPAPCardView:(PAPCardView *)cardView{
    
}

-(void)dismissRightPAPCardView:(PAPCardView *)cardView{
    
}

@end
