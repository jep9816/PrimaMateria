//
//  XTRShellModelScene.swift
//  spritetest
//
//  Created by Jerry Porter on 6/8/17.
//  Copyright © 2018 xTrensa. All rights reserved.
//

import SpriteKit
import GameplayKit

class XTRShellModelScene: SKScene, SKPhysicsContactDelegate {
    
    var element: XTRElementModel?
    var ballRadius: CGFloat!
    var maxRadius: CGFloat!
    var origX: CGFloat!
    var shellRadiusOffset: CGFloat!
    var shellTextXOffset: CGFloat!

    init(size: CGSize, element: XTRElementModel) {
        super.init(size: size)
        
        self.element = element
        
        ballRadius = size.height / 64.4
        maxRadius = (size.height / 2.0) - ballRadius - ballRadius
        origX = size.height / 2.0
        shellRadiusOffset = size.height / 16.1
        shellTextXOffset = size.height / 24.7
   }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didMove(to view: SKView) {
        let protons = element?.value(forKeyPath: ELEMENT_NUMBER_OF_PROTONS)!
        let neutrons = element?.value(forKeyPath: ELEMENT_NUMBER_OF_NEUTRONS)!
        let kShellElectrons = (element?.kShellElectrons.isEmpty)! ? 0: Int((element?.kShellElectrons)!)!
        let lShellElectrons = (element?.lShellElectrons.isEmpty)! ? 0: Int((element?.lShellElectrons)!)!
        let mShellElectrons = (element?.mShellElectrons.isEmpty)! ? 0: Int((element?.mShellElectrons)!)!
        let nShellElectrons = (element?.nShellElectrons.isEmpty)! ? 0: Int((element?.nShellElectrons)!)!
        let oShellElectrons = (element?.oShellElectrons.isEmpty)! ? 0: Int((element?.oShellElectrons)!)!
        let pShellElectrons = (element?.pShellElectrons.isEmpty)! ? 0: Int((element?.pShellElectrons)!)!
        let qShellElectrons = (element?.qShellElectrons.isEmpty)! ? 0: Int((element?.qShellElectrons)!)!
        
        let protonLabel = SKLabelNode(text: "\(String(describing: protons!))P")
        let neutronLabel = SKLabelNode(text: "\(String(describing: neutrons!))N")
        
        protonLabel.position = CGPoint(x: origX, y: origX + (size.height / 90))
        protonLabel.fontSize = size.height / 28.8
        protonLabel.horizontalAlignmentMode = .center
        protonLabel.color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        protonLabel.fontName = "Verdana-Bold"
        protonLabel.fontColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        neutronLabel.position = CGPoint(x: origX, y: origX - (size.height / 32))
        neutronLabel.fontSize = size.height / 28.8
        neutronLabel.horizontalAlignmentMode = .center
        neutronLabel.color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        neutronLabel.fontName = "Verdana-Bold"
        neutronLabel.fontColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        backgroundColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 0.7)
        
        circleOfDots(numberOfCircles: kShellElectrons, radius: maxRadius - (shellRadiusOffset * 6.0), color: SKColor.red.withAlphaComponent(1.0)) // K
        circleOfDots(numberOfCircles: lShellElectrons, radius: maxRadius - (shellRadiusOffset * 5.0), color: SKColor.green.withAlphaComponent(1.0)) // L
        circleOfDots(numberOfCircles: mShellElectrons, radius: maxRadius - (shellRadiusOffset * 4.0), color: SKColor.blue.withAlphaComponent(1.0)) // M
        circleOfDots(numberOfCircles: nShellElectrons, radius: maxRadius - (shellRadiusOffset * 3.0), color: SKColor.cyan.withAlphaComponent(1.0)) // N
        circleOfDots(numberOfCircles: oShellElectrons, radius: maxRadius - (shellRadiusOffset * 2.0), color: SKColor.magenta.withAlphaComponent(1.0)) // O
        circleOfDots(numberOfCircles: pShellElectrons, radius: maxRadius - shellRadiusOffset, color: SKColor.yellow.withAlphaComponent(1.0)) // P
        circleOfDots(numberOfCircles: qShellElectrons, radius: maxRadius, color: SKColor.gray) // Q

        addChild(protonLabel)
        addChild(neutronLabel)
        addShellLabels()
    }
    
    func circleOfDots(numberOfCircles: Int, radius: CGFloat, color: SKColor) {
        let centerPoint = CGPoint(x: origX, y: (view?.frame.height)! / 2.0)
        let circlePath = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: 0.0, endAngle: CGFloat.pi * 2.0, clockwise: true)
        let shapeLayer = CAShapeLayer()
        let duration = Double(radius / 3.5)
        let clockwise = (numberOfCircles % 2) == 0
        
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = size.height / 322.0
        shapeLayer.lineDashPattern = [10, 10]
        
        view?.layer.addSublayer(shapeLayer)
        
        for idx in 0...numberOfCircles {
            let circle = SKShapeNode(circleOfRadius: ballRadius)
            let followCirclePath: SKAction
            let angle = 2 * Double.pi / Double(numberOfCircles) * Double(idx)
            let circleX = radius * cos(CGFloat(angle))
            let circleY = radius * sin(CGFloat(angle))
            let tempPath: UIBezierPath!

            circle.strokeColor = SKColor.black
            circle.fillColor = color
            circle.lineWidth = size.height / 322.0
            
            if clockwise {
                tempPath = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: CGFloat(angle), endAngle: (CGFloat.pi * 2) + CGFloat(angle), clockwise: true)
            } else {
                tempPath = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: (CGFloat.pi * 2) + CGFloat(angle), endAngle: CGFloat(angle), clockwise: false)
            }
            
            followCirclePath = SKAction.follow(tempPath.cgPath, asOffset: false, orientToPath: true, duration: duration)
            
            circle.name = String(format: "circle%d", idx)
            circle.position = CGPoint(x: circleX + frame.midX, y: circleY + frame.midY)
            
            addChild(circle)
            circle.run(SKAction.repeatForever(followCirclePath))
        }
    }
    
    func addShellLabels() {
        addShellLabel(atLocation: CGPoint(x: origX, y: shellTextXOffset + (shellRadiusOffset * 6.0)), text: "K")
        addShellLabel(atLocation: CGPoint(x: origX, y: shellTextXOffset + (shellRadiusOffset * 5.0)), text: "L")
        addShellLabel(atLocation: CGPoint(x: origX, y: shellTextXOffset + (shellRadiusOffset * 4.0)), text: "M")
        addShellLabel(atLocation: CGPoint(x: origX, y: shellTextXOffset + (shellRadiusOffset * 3.0)), text: "N")
        addShellLabel(atLocation: CGPoint(x: origX, y: shellTextXOffset + (shellRadiusOffset * 2.0)), text: "O")
        addShellLabel(atLocation: CGPoint(x: origX, y: shellTextXOffset + shellRadiusOffset), text: "P")
        addShellLabel(atLocation: CGPoint(x: origX, y: shellTextXOffset), text: "Q")
    }
    
    func addShellLabel(atLocation: CGPoint, text: String) {
        let aLabel = SKLabelNode(text: text)
        aLabel.position = atLocation
        aLabel.fontSize = size.height / 32.0
        aLabel.horizontalAlignmentMode = .center
        aLabel.color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        aLabel.fontName = "Verdana"
        aLabel.fontColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        addChild(aLabel)
    }
    
}
