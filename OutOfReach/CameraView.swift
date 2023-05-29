//
//  ContentView.swift
//  asdfghjkl
//
//  Created by Intan Saliya Utomo on 06/05/23.
//

import SwiftUI
import ARKit
import RealityKit
import Combine

struct CameraView : View {
    
    @State private var isGameOverPresented = false
    @State private var isGhostNearby = false
    @State private var dangerOpacity = 0.0
    @State private var arView = ARView(frame: .zero)
    @State private var runString: String = ""
    @State private var GhostNearbyString: String = ""
    @EnvironmentObject var countTimer: CountDownObject
//    @ObservedObject var myObject = CountDownObject()
//    @State private var countDown = 0
//    @State private var timerStatus = true
//    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            ZStack {
                ZStack{
                    ARViewContainer(isGameOverPresented: $isGameOverPresented, isGhostNearby: $isGhostNearby, dangerOpacity: $dangerOpacity, arView: $arView, runString: $runString, GhostNearbyString: $GhostNearbyString)
                        .edgesIgnoringSafeArea(.all)
                    Rectangle()
                        .fill(RadialGradient(colors: [.clear, .black], center: .center, startRadius: 0, endRadius: 400))
                        .opacity(0.7)
                        .ignoresSafeArea()
                    Rectangle()
                        .fill(RadialGradient(colors: [.clear, .red], center: .center, startRadius: 0, endRadius: 800))
                        .opacity(dangerOpacity)
                        .ignoresSafeArea()
                    VStack {
                        Text("\(countTimer.countDownCGenerator(countDown: countTimer.countDown, iterateCount: countTimer.iterateCount))s")
                            .font(.system(size: 44))
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding(.top, 100)
                            .onReceive(countTimer.timer) { _ in
                                if countTimer.countDown >= 0 && (countTimer.isTimerOn) {
                                    countTimer.countDown += 1
                                } else {
                                    countTimer.isTimerOn = false
                                }
                            }
                        Spacer()
                    }
                    VStack {
                        Text(runString) //runString
                            .foregroundColor(.red)
                            .font(.system(size: 72))
                            .fontWeight(.heavy)
                        Text(GhostNearbyString) //GhostNearbyString
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                            .fontWeight(.heavy)
                    }
                    NavigationLink(destination: GameOver(), isActive: $isGameOverPresented) {
                            EmptyView()
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .hidden()
                }
                .onAppear(perform: {
                    print("backsound")
                    playSound(sound: "GameBacksound", type: "mp3")
                    
                    countTimer.countDown = 0
                    print("sebelumm : \(countTimer.isTimerOn)")
                    countTimer.isTimerOn = true
                    print("sesudah : \(countTimer.isTimerOn)")
                })
            }
            
        }
        .navigationViewStyle(.stack)
        .navigationBarBackButtonHidden()
    }
}

//struct ResetCountTimerModifier: ViewModifier {
//    @EnvironmentObject var countTimer: CountDownObject
//
//    func body(content: Content) -> some View {
//        content
//            .onAppear {
//                countTimer.countDown = 0
//                countTimer.isTimerOn = true
//            }
//    }
//}

struct GhostNearbyView: View {
    var body: some View {
        Text("Ghost is nearby!")
            .foregroundColor(.red)
            .fontWeight(.black)
    }
}

struct PlayerFoundView: View {
    var body: some View {
        VStack {
            Text("OH NO!")
                .foregroundColor(.red)
                .fontWeight(.black)
                .font(Font.custom("IMFellEnglishSC-Regular", size: 16))
            Text("You're found")
                .foregroundColor(.red)
                .fontWeight(.heavy)
                .font(.system(size: 28))
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    
//    let arView = ARView(frame: .zero)
    var ghostPlacementTimer: Timer?
    var ghostAnchor: AnchorEntity?
    @Binding var isGameOverPresented: Bool
    @Binding var isGhostNearby: Bool
    @Binding var dangerOpacity: Double
    @Binding var arView: ARView
    @Binding var runString: String
    @Binding var GhostNearbyString: String
    @EnvironmentObject var countTimer: CountDownObject
//    @Binding var countDownTimer: Int
//    @Binding var countDown: Int
//    @Binding var timerStatu: Bool
    
    func makeUIView(context: Context) -> ARView {
        arView.session.delegate = context.coordinator
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        if uiView != arView {
            return
        }
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        uiView.session.run(configuration)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, ARSessionDelegate {
        var parent: ARViewContainer
        @Published var isObjectPointed: Bool = false
        var distanceThreshold: Float = 3.0 // Adjust the distance threshold as needed
        
        init(_ parent: ARViewContainer) {
            self.parent = parent
            super.init()
            moveGhostToRandomPosition()
            startGhostPlacementTimer()
        }
        
        func session(_ session: ARSession, didUpdate frame: ARFrame) {
            guard let currentFrame = session.currentFrame,
                  let objectPosition = parent.ghostAnchor?.position else {
                return
            }
            
            let cameraTransform = currentFrame.camera.transform
            let cameraForward = -simd_make_float3(cameraTransform.columns.2)
            let cameraPosition = simd_make_float3(cameraTransform.columns.3)
            
            // Calculate the distance between the ghost and the camera
            let distance = simd_distance(objectPosition, cameraPosition)
            
            let cameraToObject = objectPosition - cameraPosition
            let dotProduct = dot(normalize(cameraForward), normalize(cameraToObject))
            
            let isObjectPointed = dotProduct > 0.8 // Adjust the threshold as needed
            
            if isObjectPointed {
                // Object is pointed by the camera
                print("---------------------")
            } else {
                // Object is not pointed by the camera
                print("                     ")
            }
            
            if distance <= distanceThreshold {
                // Ghost is within the specified distance threshold
                print("Ghost is nearby!")
                parent.isGhostNearby = true
                parent.dangerOpacity = 0.5
                parent.runString = "RUN!"
                parent.GhostNearbyString = "Slenderman is reaching!"
                
                // Show an alert or perform any other action here
                if isObjectPointed {
                    // Object is pointed by the camera
                    print("000000000000000000000")
                    print("Game Over!")
                    // Present the GameOver view
                    self.parent.runString = "OH NO!"
                    self.parent.GhostNearbyString = "Slenderman reached you"
                    self.parent.countTimer.isTimerOn = false
                    print(self.parent.countTimer.isTimerOn)
                    Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
                        self.parent.isGameOverPresented = true
                    }
                } else {
                    // Object is not pointed by the camera
                    print("                     ")
                }
                
            } else {
                parent.isGhostNearby = false
                parent.dangerOpacity = 0.0
                parent.runString = ""
                parent.GhostNearbyString = ""
            }
            
            // Calculate the direction vector from the ghost to the camera
            let direction = normalize(cameraPosition - objectPosition)
            
            // Update the ghost position
            var speed: Float = 0.01 // Adjust the ghost speed as needed
            if parent.countTimer.countDownCGenerator(countDown: parent.countTimer.countDown, iterateCount:  parent.countTimer.iterateCount) % 10 == 0 { // Add speed every 10 sec
                speed += 0.005
            }
            parent.ghostAnchor?.position += direction * speed
            
            print(parent.countTimer.isTimerOn)
        }
        
        func startGhostPlacementTimer() {
            parent.ghostPlacementTimer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { _ in
                self.moveGhostToRandomPosition()
            }
        }
        
        func moveGhostToRandomPosition() {
            let randomPosition = randomPositionInScene()
            let ghostEntity: Entity
            if let anchorEntity = parent.ghostAnchor {
                anchorEntity.position = randomPosition
            } else {
                ghostEntity = try! Entity.load(named: "Slenderman.usdz")
                let anchorEntity = AnchorEntity()
                anchorEntity.addChild(ghostEntity)
                anchorEntity.position = randomPosition
                parent.arView.scene.addAnchor(anchorEntity)
                parent.ghostAnchor = anchorEntity
            }
            
//            ghostEntity.components.set(BillboardComponent())
//            ghostEntity.look(at: parent.arView.cameraTransform.translation, from: ghostEntity.position, relativeTo: parent.arView.scene)
//            ghostEntity.look(at: parent.arView.cameraTransform.translation, from: ghostEntity.position, relativeTo: anchorEntity)
        }
        
        func randomPositionInScene() -> SIMD3<Float> {
            let minX: Float = -10.0
            let maxX: Float = 10.0
            let minZ: Float = -10.0
            let maxZ: Float = 10.0
            
            let randomX = Float.random(in: minX...maxX)
            let randomZ = Float.random(in: minZ...maxZ)
            let y = 0.0 // Adjust the vertical position if needed
            
            print(SIMD3<Float>(randomX, Float(y), randomZ))
            return SIMD3<Float>(randomX, Float(y), randomZ)
        }
    }
}

#if DEBUG
struct CameraView_Previews : PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
#endif
