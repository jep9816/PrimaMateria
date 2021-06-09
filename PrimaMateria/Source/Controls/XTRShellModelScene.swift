//
//  XTRShellModelScene.swift
//  spritetest
//
//  Created by Jerry Porter on 6/8/17.
//  Copyright ©2021 xTrensa. All rights reserved.
//

import SpriteKit
import GameplayKit

class XTRShellModelScene: SKScene, SKPhysicsContactDelegate {

    var element: XTRElementModel?
    var electronRadius: CGFloat!
    var maxRadius: CGFloat!
    var origX: CGFloat!
    var shellRadiusOffset: CGFloat!
    var shellTextXOffset: CGFloat!
    let piConst = CGFloat.pi * 2.0

    init(size: CGSize, element: XTRElementModel) {
        super.init(size: size)

        self.element = element

        electronRadius = size.height / 60
        maxRadius = (size.height / 2.0) - electronRadius - electronRadius
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

        circleOfElectrons(number: kShellElectrons, radius: maxRadius - (shellRadiusOffset * 6.0), color: SKColor.red.withAlphaComponent(1.0)) // K
        circleOfElectrons(number: lShellElectrons, radius: maxRadius - (shellRadiusOffset * 5.0), color: SKColor.green.withAlphaComponent(1.0)) // L
        circleOfElectrons(number: mShellElectrons, radius: maxRadius - (shellRadiusOffset * 4.0), color: SKColor.blue.withAlphaComponent(1.0)) // M
        circleOfElectrons(number: nShellElectrons, radius: maxRadius - (shellRadiusOffset * 3.0), color: SKColor.cyan.withAlphaComponent(1.0)) // N
        circleOfElectrons(number: oShellElectrons, radius: maxRadius - (shellRadiusOffset * 2.0), color: SKColor.magenta.withAlphaComponent(1.0)) // O
        circleOfElectrons(number: pShellElectrons, radius: maxRadius - shellRadiusOffset, color: SKColor.yellow.withAlphaComponent(1.0)) // P
        circleOfElectrons(number: qShellElectrons, radius: maxRadius, color: SKColor.gray) // Q

        addChild(protonLabel)
        addChild(neutronLabel)
        addShellLabels()
    }

    func createColorEmboss() -> SKShader {
        let uniforms: [SKUniform] = [
            SKUniform(name: "u_strength", float: 1)
        ]

        let attributes = [
            SKAttribute(name: "a_size", type: .vectorFloat2)
        ]

        return SKShader(fromFile: "SHKEmbossColor", uniforms: uniforms, attributes: attributes)
    }

    func createWater() -> SKShader {
        let uniforms: [SKUniform] = [
            SKUniform(name: "u_speed", float: 3),
            SKUniform(name: "u_strength", float: 2.5),
            SKUniform(name: "u_frequency", float: 10)
        ]

        return SKShader(fromFile: "SHKWater", uniforms: uniforms)
    }

    func createLightGrid() -> SKShader {
        let uniforms: [SKUniform] = [
            SKUniform(name: "u_density", float: 8),
            SKUniform(name: "u_speed", float: 3),
            SKUniform(name: "u_group_size", float: 2),
            SKUniform(name: "u_brightness", float: 3)
            ]

        return SKShader(fromFile: "SHKLightGrid", uniforms: uniforms)
    }

    func createGrayEmboss() -> SKShader {
        let uniforms: [SKUniform] = [
            SKUniform(name: "u_strength", float: 1)
        ]

        let attributes = [
            SKAttribute(name: "a_size", type: .vectorFloat2)
        ]

        return SKShader(fromFile: "SHKEmbossGray", uniforms: uniforms, attributes: attributes)
    }

    func circleOfElectrons(number: Int, radius: CGFloat, color: SKColor) {
        let centerPoint = CGPoint(x: origX, y: (view?.frame.height)! / 2.0)
        let circlePath = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: 0.0, endAngle: CGFloat.pi * 2.0, clockwise: true)
        let shapeLayer = CAShapeLayer()
        let duration: CGFloat = radius / 3.5
        let clockwise = (number % 2) == 0

        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = size.height / 322.0
        shapeLayer.lineDashPattern = [10, 10]

        view?.layer.addSublayer(shapeLayer)

        for idx in 0...number {
            let electron = SKShapeNode(circleOfRadius: electronRadius)
            let followCirclePathAction: SKAction
            let angle: CGFloat = 2 * CGFloat.pi / CGFloat(number) * CGFloat(idx)
            let circleX = radius * cos(angle)
            let circleY = radius * sin(angle)
            let tempPath: UIBezierPath!

            electron.strokeColor = SKColor.black
            electron.fillColor = color
            electron.lineWidth = size.height / 322.0
            //electron.fillShader = createColorEmboss()
            electron.alpha = 1.0

            if clockwise {
                tempPath = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: angle, endAngle: piConst + angle, clockwise: true)
            } else {
                tempPath = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: piConst + angle, endAngle: angle, clockwise: false)
            }

            followCirclePathAction = SKAction.follow(tempPath.cgPath, asOffset: false, orientToPath: true, duration: TimeInterval(duration))

            electron.name = String(format: "circle%d", idx)
            electron.position = CGPoint(x: circleX + frame.midX, y: circleY + frame.midY)

            addChild(electron)
            electron.run(SKAction.repeatForever(followCirclePathAction))
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
