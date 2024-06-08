//
//  DetailView.swift
//  OurSolarSystem
//
//  Created by Rahul Sharma on 07/06/24.
//

import Foundation
import SwiftUI

struct DetailView: View {
    @State var title: String

    @Environment(\.dismissWindow) private var dismissWindow
    var body: some View {
        VStack(spacing: 50) {
            if title.contains("sun") {
                Text("Sun The only Star!!")
                    .font(.extraLargeTitle)
                    .bold()

                Text("The Sun is the largest object in our solar system. Its diameter is about 865,000 miles (1.4 million kilometers). Its gravity holds the solar system together, keeping everything from the biggest planets to the smallest bits of debris in orbit around it.\nEven though the Sun is the center of our solar system and essential to our survival, it’s only an average star in terms of its size.")
                    .font(.title)

            } else if title.contains("mercury") {
                Text("Mercury: Closest to Sun")
                    .font(.extraLargeTitle)
                    .bold()

                Text("The planet is visible to the unaided eye and as such as has long been known to humans.\n We know it by the name given by the Romans, after their swift-footed messenger god Mercury. The planet was first observed through the newly invented telescope in 1631 by astronomers Galileo Galilei and Thomas Harriot, according to NASA Science. ")
                    .font(.title)
            }


            Button {
                dismissWindow(id: "DetailView")
            } label: {
                Text("dismiss")
            }
        }
    }
}
