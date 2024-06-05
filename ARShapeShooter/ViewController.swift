//
//  ViewController.swift
//  ARShapeShooter
//
//  Created by Carlo Namoca on 2024-06-03.
//

import UIKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var sceneView: ARSCNView!
    
    // Create a new scene
    let scene = SCNScene()
    
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        
        
        // TODO: - Game loop
        // Instruction is updated
        instructionsLabel.text = "Find: Blue Box"
        // Add shapes to the scene
        addShapes(to: scene)
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: sceneView)

        let hitTestResults = sceneView.hitTest(touchLocation, options: [:])
        if let hitTestResult = hitTestResults.first {
            
            let node = hitTestResult.node
            node.removeFromParentNode()
            
            // TODO: - Some test code here
            instructionsLabel.text = "Find: Red Sphere"
            addShapes(to: scene)

            // Add your shooting sound effect or scoring logic here
        }
    }
    
    func addShapes(to scene: SCNScene) {
        let boxGeometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        let boxNode = SCNNode(geometry: boxGeometry)
        boxNode.position = randomPosition()

        let sphereGeometry = SCNSphere(radius: 0.05)
        let sphereNode = SCNNode(geometry: sphereGeometry)
        sphereNode.position = randomPosition()

        scene.rootNode.addChildNode(boxNode)
        scene.rootNode.addChildNode(sphereNode)
    }
    
    func randomPosition() -> SCNVector3 {
        // Ensuring the objects are in front of the camera
        let x = Float.random(in: -0.5...0.5)
        let y = Float.random(in: -0.5...0.5)
        let z = Float.random(in: -1.0...0)
        return SCNVector3(x, y, z)
    }
        
    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // This is where you handle the added AR anchor.
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
    }
    
    
}

