//
//  ImmersiveView.swift
//  OurSolarSystem
//
//  Created by Rahul Sharma on 04/06/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {

    @Environment(\.dismissWindow) var dismissWindow
    @Environment(\.openWindow) var openWindow

    @State var lastGestureValue = CGFloat(0)
    
    @State var sun = Entity()

    var body: some View {
        RealityView { content in

            async let sun = Entity(named: "Sun", in: realityKitContentBundle)
            async let mercury = Entity(named: "Mercury", in: realityKitContentBundle)
            async let venus = Entity(named: "Venus", in: realityKitContentBundle)
            async let earth = Entity(named: "Earth", in: realityKitContentBundle)
            async let mars = Entity(named: "Mars", in: realityKitContentBundle)
            async let jupiter = Entity(named: "Jupiter", in: realityKitContentBundle)
            async let saturn = Entity(named: "Saturn", in: realityKitContentBundle)
            async let uranus = Entity(named: "Uranus", in: realityKitContentBundle)
            async let neptune = Entity(named: "Neptune", in: realityKitContentBundle)
            async let pluto = Entity(named: "Pluto", in: realityKitContentBundle)

            if let sun = await try? sun,
                let mercury = await try? mercury,
                let venus = await try? venus,
                let earth = await try? earth,
                let mars = await try? mars,
                let jupiter = await try? jupiter,
                let saturn = await try? saturn,
               let uranus = await try? uranus,
                let neptune = await try? neptune,
                let pluto = await try? pluto
            {
                self.sun = sun
                content.add(sun)
                content.add(mercury)
                content.add(venus)
                content.add(earth)
                content.add(mars)
                content.add(jupiter)
                content.add(saturn)
                content.add(uranus)
                content.add(neptune)
                content.add(pluto)


                sun.position = [0, 0.75, 0]
                sun.scale = [2, 2, 2]
                mercury.position = [0.5, 0.75, 0]
                venus.position = [1, 0.75, 0]
                earth.position = [1.5, 0.75, 0]
                mars.position = [2, 0.75, 0]
                jupiter.position = [2.5, 0.75, 0]
                saturn.position = [3, 0.75, 0]
                uranus.position = [3.5, 0.75, 0]
                neptune.position = [4, 0.75, 0]
                pluto.position = [4.5, 0.75, 0]

                // Add an ImageBas edLight for the immersive content
                guard let resource = try? await EnvironmentResource(named: "ImageBasedLight") else { return }
                let iblComponent = ImageBasedLightComponent(source: .single(resource), intensityExponent: 0.25)
                sun.components.set(iblComponent)
                sun.components.set(ImageBasedLightReceiverComponent(imageBasedLight: sun))
                
                mercury.components.set(iblComponent)
                mercury.components.set(ImageBasedLightReceiverComponent(imageBasedLight: mercury))

                venus.components.set(iblComponent)
                venus.components.set(ImageBasedLightReceiverComponent(imageBasedLight: venus))

                earth.components.set(iblComponent)
                earth.components.set(ImageBasedLightReceiverComponent(imageBasedLight: earth))

                mars.components.set(iblComponent)
                mars.components.set(ImageBasedLightReceiverComponent(imageBasedLight: mars))

                jupiter.components.set(iblComponent)
                jupiter.components.set(ImageBasedLightReceiverComponent(imageBasedLight: jupiter))

                saturn.components.set(iblComponent)
                saturn.components.set(ImageBasedLightReceiverComponent(imageBasedLight: saturn))

                uranus.components.set(iblComponent)
                uranus.components.set(ImageBasedLightReceiverComponent(imageBasedLight: uranus))

                neptune.components.set(iblComponent)
                neptune.components.set(ImageBasedLightReceiverComponent(imageBasedLight: neptune))
                
                pluto.components.set(iblComponent)
                pluto.components.set(ImageBasedLightReceiverComponent(imageBasedLight: pluto))
                
                sun.components.set(InputTargetComponent())
                sun.generateCollisionShapes(recursive: true)

                mercury.components.set(InputTargetComponent())
                mercury.generateCollisionShapes(recursive: true)
                
                venus.components.set(InputTargetComponent())
                venus.generateCollisionShapes(recursive: true)

                mars.components.set(InputTargetComponent())
                mars.generateCollisionShapes(recursive: true)

            }
        }
        .gesture(TapGesture()
        .targetedToAnyEntity()
        .onEnded { value in
                print("entity tapped")
            self.openWindow(id: "DetailView", value: value.entity.name)
            }
        )
        .gesture(DragGesture()
            .targetedToAnyEntity()
            .onChanged { value in
                let entity = value.entity
                print("entity name \(entity.name)")
                if entity.name.contains("sun") {
                    let timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in

                        let orientation = Rotation3D(entity.orientation(relativeTo: nil))
                        let newOrientation: Rotation3D

                        if (value.location.x >= lastGestureValue) {
                            newOrientation = orientation.rotated(by: .init(angle: .degrees(0.5), axis: .y))
                        } else {
                            newOrientation = orientation.rotated(by: .init(angle: .degrees(-0.5), axis: .y))
                        }
                        entity.setOrientation(.init(newOrientation), relativeTo: nil)
                        lastGestureValue = value.location.x
                    }
                    timer.fire()
                } else if entity.name.contains("mercury") {
                    sun.addChild(entity)
                    var transform = entity.transform
                    transform.translation = [0.3, 0, 0]
                    // define an orbit animation

                    let animationDefinition = OrbitAnimation(duration: 5, axis: [0, 1, 0], startTransform: transform, bindTarget: .transform, repeatMode: .repeat)
                    let animationResouurce = try! AnimationResource.generate(with: animationDefinition)
                    entity.playAnimation(animationResouurce)
                }
                else if entity.name.contains("venus") {
                    sun.addChild(entity)
                    var transform = entity.transform
                    transform.translation = [0.6, 0, 0]
                    // define an orbit animation

                    let animationDefinition = OrbitAnimation(duration: 5, axis: [0, 1, 0], startTransform: transform, bindTarget: .transform, repeatMode: .repeat)
                    let animationResouurce = try! AnimationResource.generate(with: animationDefinition)
                    entity.playAnimation(animationResouurce)
                }
                else if entity.name.contains("mars") {
                    sun.addChild(entity)
                    var transform = entity.transform
                    transform.translation = [0.9, 0, 0]
                    // define an orbit animation

                    let animationDefinition = OrbitAnimation(duration: 5, axis: [0, 1, 0], startTransform: transform, bindTarget: .transform, repeatMode: .repeat)
                    let animationResouurce = try! AnimationResource.generate(with: animationDefinition)
                    entity.playAnimation(animationResouurce)
                }
            }
        )
        .onAppear {
            dismissWindow(id: "Content")
        }
    }
}

#Preview {
    ImmersiveView()
        .previewLayout(.sizeThatFits)
}
