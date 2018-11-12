//
//  DesignedView.swift
//  UIBezierPathExample
//
//  Created by VAndrJ on 11/12/18.
//  Copyright © 2018 VAndrJ. All rights reserved.
//

import UIKit

@IBDesignable
class DesignedView: UIView {
    
    private let minimumPossibleHeight: CGFloat = 70
    @IBInspectable
    var pathColor: UIColor = .black { didSet { setNeedsDisplay() }}
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: minimumPossibleHeight)
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureUI()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configureUI()
    }
    
    override func draw(_ rect: CGRect) {
        pathColor.setFill()
        // MARK: - значения взяты "на глаз" и необходимо заменить на значения по дизайну
        let path = UIBezierPath()
        let startPoint = CGPoint(x: rect.minX, y: rect.minY)
        path.move(to: startPoint)
        let sideCurveEnd = CGPoint(x: 50, y: 30)
        let sideCurveCP = CGPoint(x: startPoint.x, y: sideCurveEnd.y)
        path.addQuadCurve(to: sideCurveEnd, controlPoint: sideCurveCP) 
        let centerArcBegin = CGPoint(x: rect.midX - 45, y: sideCurveEnd.y)
        path.addLine(to: centerArcBegin)
        let centerFirstArcEnd = CGPoint(x: centerArcBegin.x + 15, y: centerArcBegin.y + 10)
        let centerFirstArcCP = CGPoint(x: centerFirstArcEnd.x - 5, y: centerArcBegin.y)
        path.addQuadCurve(to: centerFirstArcEnd, controlPoint: centerFirstArcCP)
        let centerSecondArcEnd = CGPoint(x: rect.midX, y: centerFirstArcEnd.y + 20)
        let centerSecondArcCP = CGPoint(x: centerFirstArcEnd.x + 5, y: centerFirstArcEnd.y + 10)
        let centerSecondArcCP2 = CGPoint(x: centerFirstArcEnd.x + 15, y: centerSecondArcEnd.y)
        path.addCurve(to: centerSecondArcEnd, controlPoint1: centerSecondArcCP, controlPoint2: centerSecondArcCP2)
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.close()
        path.fill()
        // MARK: - отражаем часть, так как симметрична, дабы не расписывать.
        let mirrorPath = path
        mirrorPath.apply(CGAffineTransform(scaleX: -1, y: 1))
        mirrorPath.apply(CGAffineTransform(translationX: rect.width, y: 0))
        mirrorPath.fill()
    }
    
    // MARK: - Configuration
    
    private func configureUI() {
        backgroundColor = .clear
        heightAnchor.constraint(greaterThanOrEqualToConstant: minimumPossibleHeight).isActive = true
        layer.shadowColor = UIColor.orange.cgColor
        layer.shadowRadius = 10
        layer.shadowOffset = .zero
        layer.shadowOpacity = 1
    }
}
