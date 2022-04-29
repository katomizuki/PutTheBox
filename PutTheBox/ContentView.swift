//
//  ContentView.swift
//  PutTheBox
//
//  Created by ミズキ on 2022/04/29.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    var body: some View {
        return ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)

        let anchor = AnchorEntity()
        anchor.position = simd_make_float3(0, -0.5, -1)
        let box = ModelEntity(mesh: .generateBox(size: simd_make_float3(0.3, 0.1, 0.2), cornerRadius: 0.03))
        var material = SimpleMaterial(color: .blue,
                                      isMetallic: true)
        material.metallic = 1
        box.transform = Transform(pitch: 0, yaw: 1, roll: 0)
        box.model?.materials = [material]
        anchor.addChild(box)
        arView.scene.anchors.append(anchor)
        
        let anchorEntity = AnchorEntity(world: [0, -1, -2])
        let plane = ModelEntity(mesh: .generatePlane(width: 0.2, height: 0.3))
        let planeMaterial = SimpleMaterial(color: .yellow, isMetallic: true)
        let unlitMaterial = UnlitMaterial(color: .yellow)
        plane.model?.materials = [unlitMaterial]
        plane.transform = Transform(pitch: 0, yaw: 1, roll: 0)
        anchorEntity.addChild(plane)
        arView.scene.anchors.append(anchorEntity)
 
        let spereEntity = AnchorEntity()
        spereEntity.position = simd_make_float3(0, -0.5, -3)
        let spererMaterial = SimpleMaterial(color: .purple, isMetallic: true)
        let occulsionMaterial = OcclusionMaterial()
        let spere = ModelEntity(mesh: .generateSphere(radius: 0.1), materials: [occulsionMaterial])
        spereEntity.addChild(spere)
        arView.scene.anchors.append(spereEntity)
        
        let textAnchor = AnchorEntity()
        textAnchor.position = simd_make_float3(0, -0.5, -1)
        let text = ModelEntity(mesh: .generateText("Reality",font: .systemFont(ofSize: 0.1,weight: .bold),containerFrame: .zero, alignment: .center))
        text.transform = Transform(pitch: 0, yaw: 0.3, roll: 0)
        anchor.addChild(text)
        arView.scene.anchors.append(anchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
