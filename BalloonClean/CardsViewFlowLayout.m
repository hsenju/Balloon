//
//  CardsViewFlowLayout.m
//  Balloon
//
//  Created by Sean Wertheim on 6/3/14.
//
//

#import "CardsViewFlowLayout.h"

@implementation CardsViewFlowLayout

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    NSArray* layoutAttributesArray = [self layoutAttributesForElementsInRect:self.collectionView.bounds];
    
    if(layoutAttributesArray.count == 0)
        return proposedContentOffset;
    
    
    UICollectionViewLayoutAttributes* candidate = layoutAttributesArray.firstObject;
    for (UICollectionViewLayoutAttributes* layoutAttributes in layoutAttributesArray)
    {
        if (layoutAttributes.representedElementCategory != UICollectionElementCategoryCell)
            continue;
        
        
        if((velocity.y > 0.0 && layoutAttributes.center.y > candidate.center.y) ||
           (velocity.y <= 0.0 && layoutAttributes.center.y < candidate.center.y))
            candidate = layoutAttributes;
        
    }
    
    
    
    return CGPointMake(proposedContentOffset.x, candidate.center.y - self.collectionView.bounds.size.height * 0.5f);
}

@end
