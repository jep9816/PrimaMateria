//
//  GameScene.swift
//  spritetest
//
//  Created by Jerry Porter on 6/8/17.
//  Copyright © 2017 Gulfstream. All rights reserved.
//

import SpriteKit
import GameplayKit

let ballRadius : CGFloat = 5.0
let shellTextXOffset : CGFloat = 12.0

class XTRShellModelScene: SKScene, SKPhysicsContactDelegate {
    
    var element: XTRElement?
    
    init(size: CGSize, element: XTRElement) {
        super.init(size: size)
        self.element = element
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didMove(to view: SKView) {
        let protons = self.element?.value(forKeyPath: ELEMENT_NUMBER_OF_PROTONS)!
        let neutrons = self.element?.value(forKeyPath: ELEMENT_NUMBER_OF_NEUTRONS)!
        let kShellElectrons = (self.element?.kShellElectrons.isEmpty)! ? 0 : Int((self.element?.kShellElectrons)!)!
        let lShellElectrons = (self.element?.lShellElectrons.isEmpty)! ? 0 : Int((self.element?.lShellElectrons)!)!
        let mShellElectrons = (self.element?.mShellElectrons.isEmpty)! ? 0 : Int((self.element?.mShellElectrons)!)!
        let nShellElectrons = (self.element?.nShellElectrons.isEmpty)! ? 0 : Int((self.element?.nShellElectrons)!)!
        let oShellElectrons = (self.element?.oShellElectrons.isEmpty)! ? 0 : Int((self.element?.oShellElectrons)!)!
        let pShellElectrons = (self.element?.pShellElectrons.isEmpty)! ? 0 : Int((self.element?.pShellElectrons)!)!
        let qShellElectrons = (self.element?.qShellElectrons.isEmpty)! ? 0 : Int((self.element?.qShellElectrons)!)!
        
        let maxRadius = (view.frame.size.height / 2) - ballRadius - ballRadius
        let protonLabel = SKLabelNode(text: "\(String(describing: protons!))P")
        let neutronLabel = SKLabelNode(text: "\(String(describing: neutrons!))N")
        
        protonLabel.position = CGPoint(x: 161, y: 161)
        protonLabel.fontSize = 12
        protonLabel.horizontalAlignmentMode = .center
        protonLabel.color = SKColor.black
        protonLabel.fontName = "Verdana-Bold"
        protonLabel.fontColor = SKColor.black
        
        neutronLabel.position = CGPoint(x: 161, y: 151)
        neutronLabel.fontSize = 12
        neutronLabel.horizontalAlignmentMode = .center
        neutronLabel.color = SKColor.black
        neutronLabel.fontName = "Verdana-Bold"
        neutronLabel.fontColor = SKColor.black
        
        backgroundColor = SKColor.white
        
        circleOfDots(numberOfCircles: kShellElectrons, radius: maxRadius - 120, color: SKColor.red) // K
        circleOfDots(numberOfCircles: lShellElectrons, radius: maxRadius - 100, color: SKColor.green) // L
        circleOfDots(numberOfCircles: mShellElectrons, radius: maxRadius - 80, color: SKColor.blue) // M
        circleOfDots(numberOfCircles: nShellElectrons, radius: maxRadius - 60, color: SKColor.cyan) // N
        circleOfDots(numberOfCircles: oShellElectrons, radius: maxRadius - 40, color: SKColor.magenta) // O
        circleOfDots(numberOfCircles: pShellElectrons, radius: maxRadius - 20, color: SKColor.yellow) // P
        circleOfDots(numberOfCircles: qShellElectrons, radius: maxRadius, color: SKColor.gray) // Q

        addChild(protonLabel)
        addChild(neutronLabel)
        addShellLabels()
    }
    
    func circleOfDots(numberOfCircles: Int, radius: CGFloat, color: SKColor) {
        let centerPoint = CGPoint(x: (view?.frame.width)! / 2, y: (view?.frame.height)! / 2)
        let circlePath = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        let shapeLayer = CAShapeLayer()
        let duration = Double(radius / 3.5)
        let clockwise = (numberOfCircles % 2 == 0)
        
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.darkGray.cgColor
        shapeLayer.lineWidth = 0.5
        shapeLayer.lineDashPattern = [10, 10]
        
        view?.layer.addSublayer(shapeLayer)
        
        for i in 0...numberOfCircles {
            let circle = SKShapeNode(circleOfRadius: ballRadius)
            circle.strokeColor = SKColor.black
            circle.fillColor = color
            circle.lineWidth = 0.5
            
            //let circle = SKLabelNode(text: "⚫️")
            //circle.fontSize = 5
            //circle.horizontalAlignmentMode = .center
            //circle.verticalAlignmentMode = .center
            
            let angle = 2 * Double.pi / Double(numberOfCircles) * Double(i)
            let circleX = radius * cos(CGFloat(angle))
            let circleY = radius * sin(CGFloat(angle))
            let tempPath : UIBezierPath!
            
            if clockwise {
                tempPath = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: CGFloat(angle), endAngle: CGFloat((Double.pi * 2) + angle), clockwise: true)
            } else {
                tempPath = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: CGFloat((Double.pi * 2) + angle), endAngle: CGFloat(angle), clockwise: false)
            }
            let followCirclePath = SKAction.follow(tempPath.cgPath, asOffset: false, orientToPath: true, duration: duration)
            
            circle.name = String(format:"circle%d",i)
            circle.position = CGPoint(x: circleX + frame.midX, y: circleY + frame.midY)
            
            addChild(circle)
            circle.run(SKAction.repeatForever(followCirclePath))
        }
    }
    
    func addShellLabels() {
        addShellLabel(at: CGPoint(x: 161, y: shellTextXOffset + 120), text: "K")
        addShellLabel(at: CGPoint(x: 161, y: shellTextXOffset + 100), text: "L")
        addShellLabel(at: CGPoint(x: 161, y: shellTextXOffset + 80), text: "M")
        addShellLabel(at: CGPoint(x: 161, y: shellTextXOffset + 60), text: "N")
        addShellLabel(at: CGPoint(x: 161, y: shellTextXOffset + 40), text: "O")
        addShellLabel(at: CGPoint(x: 161, y: shellTextXOffset + 20), text: "P")
        addShellLabel(at: CGPoint(x: 161, y: shellTextXOffset), text: "Q")
    }
    
    func addShellLabel(at: CGPoint, text: String) {
        let aLabel = SKLabelNode(text: text)
        aLabel.position = at
        aLabel.fontSize = 10
        aLabel.horizontalAlignmentMode = .center
        aLabel.color = SKColor.darkGray
        aLabel.fontName = "Verdana"
        aLabel.fontColor = SKColor.darkGray
        addChild(aLabel)
    }
    
}
