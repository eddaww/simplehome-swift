//
//  RoomDetailsView.swift
//  simplehome
//
//  Created by Yitian Cai on 5/13/24.
//

// RoomDetailsView.swift

import SwiftUI


struct RoomDetailsView: View {
    var RoomData: RoomData 
    @State private var isACOn = false
    @State private var acTemperature: Double = 25
    @State private var isCurtainOpen = false
    @State private var isLightOn = false
    
    
    var body: some View {
        VStack {
            Image(systemName: "house")
                .resizable()
                .frame(width: 100, height: 100)
                .padding()
            

            Text("Temperature: \(String(format: "%.2f", RoomData.Temperature))°F")
            Text("Humidity: \(String(format: "%.2f", RoomData.Humidity))%")


            Toggle(isOn: $isACOn) {
                Label("AC", systemImage: "thermometer")
            }
                           
            HStack {
                Text("AC Temperature")
                Spacer()
                Text("\(Int(acTemperature))°F")
                        .foregroundColor(.gray)
                        .padding(.trailing)
            }
                Slider(value: $acTemperature, in: 16...30, step: 1)
                        .padding(.horizontal)
            
            
            Toggle(isOn: $isCurtainOpen) {
                Label("Curtains", systemImage: "blinds.horizontal")
            }

            Toggle(isOn: $isLightOn) {
                Label("Lights", systemImage: "lightbulb")
            }
            
            
            Spacer()
        }
        .padding()
        .navigationBarTitle(Text("Room ID: \(RoomData.ID)"), displayMode: .inline)
    }
}
