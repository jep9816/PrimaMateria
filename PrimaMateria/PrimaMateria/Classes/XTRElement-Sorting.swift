//
//  XTRElement-Sorting.swift
//  PrimaMateria
//
//  Created by Jerry Porter on 4/22/16.
//  Copyright © 2016 xTrensa. All rights reserved.
//

extension XTRElement {
    func _compareInt(first: Int, second: Int) -> NSComparisonResult {
        if (first < second) {
            return NSComparisonResult.OrderedAscending
        } else if (first > second) {
            return NSComparisonResult.OrderedDescending
        } else {
            return NSComparisonResult.OrderedSame
        }
    }
    
    func _compareFloat(first: CGFloat, second: CGFloat) -> NSComparisonResult {
        if (first < second) {
            return NSComparisonResult.OrderedAscending
        } else if (first > second) {
            return NSComparisonResult.OrderedDescending
        }else {
            return NSComparisonResult.OrderedSame
        }
    }
    
    func atomicNumberComparison(anElement:  XTRElement) -> NSComparisonResult {
        return self._compareInt(self.atomicNumber().integerValue, second: anElement.atomicNumber().integerValue)
    }
    
    func atomicMassComparison(anElement:  XTRElement) -> NSComparisonResult {
        return self._compareFloat(self.atomicMass() as CGFloat, second: anElement.atomicMass() as CGFloat)
    }
    
    func boilingPointComparison(anElement:  XTRElement) -> NSComparisonResult {
        return self._compareFloat(self.boilingPoint() as CGFloat, second: anElement.boilingPoint() as CGFloat)
    }
    
    func densityComparison(anElement:  XTRElement) -> NSComparisonResult {
        return self._compareFloat(self.density() as CGFloat, second: anElement.density() as CGFloat)
    }
    
    func groupComparison(anElement:  XTRElement) -> NSComparisonResult {
        return self._compareInt(self.group()!.integerValue, second: anElement.group()!.integerValue)
    }
    
    func meltingPointComparison(anElement:  XTRElement) -> NSComparisonResult {
        return self._compareFloat(self.meltingPoint() as CGFloat, second: anElement.meltingPoint() as CGFloat)
    }
    
    func nameComparison(anElement:  XTRElement) -> NSComparisonResult {
        return self.name()!.compare(anElement.name()!, options: NSStringCompareOptions.CaseInsensitiveSearch)
    }

    func periodComparison(anElement:  XTRElement) -> NSComparisonResult {
        return self._compareInt(self.period()!.integerValue, second: anElement.period()!.integerValue)
    }
    
    func seriesComparison(anElement:  XTRElement) -> NSComparisonResult {
        return self.series()!.compare(anElement.series()!, options: NSStringCompareOptions.CaseInsensitiveSearch)
    }
    
    func symbolComparison(anElement:  XTRElement) -> NSComparisonResult {
        return self.symbol()!.compare(anElement.symbol()!, options:NSStringCompareOptions.CaseInsensitiveSearch)
    }
}