import SwiftUI
import Foundation

struct ContentView: View {
    @State private var weatherText = "Weather: 25°C"
    @State private var isRaining = false
    @StateObject
    var viewModel = FirebaseDAO()
    
    var body: some View {
            NavigationView {
                ScrollView {
                    VStack(spacing: 20) {
                        WeatherView(weatherText: weatherText, isRaining: isRaining)
                            .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height / 3)
                            .background(isRaining ? Color.blue.opacity(0.2) : Color.yellow.opacity(0.5))
                            .cornerRadius(20)
                            .padding()
                        
                        
                        
                        
//                        VStack{
//                            if !viewModel.listObject.isEmpty{
//                            ForEach(viewModel.listObject, id: \.self) { object
//                                in
//                                VStack {
//                                    Text(String(object.ID))  // Convert Int to String
//                                    Text(String(object.Humidity))  // Convert Double to String
//                                    Text(String(object.Temperature))  // Convert Double to String
//                                    Text(String(object.Count))  // Convert Int to String
//                                }.padding()
//
//                            }
//                            }else{
//                                Text("do nothing")                            }
//                        }
//
//                        Button {
//                            viewModel.observeListObject()
//                        } label: {
//                            Text("Fetch Value")
//                        }

                        
                       
                        ForEach(viewModel.listObject.chunked(into: 2), id: \.self) { row in
                            HStack(spacing: 20) {
                                ForEach(row, id: \.self) { RoomData in
                                    NavigationLink(destination: RoomDetailsView(RoomData: RoomData)) {
                                        RoomButtonView(RoomData: RoomData)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
                .onAppear {
                    viewModel.observeListObject()
                    isRaining = true
                }
                .navigationTitle("my simple house") 
            }
        }
    
}



    
struct WeatherView: View {
    var weatherText: String
    var isRaining: Bool
    var body: some View {
        HStack {
            Image(systemName: isRaining ? "cloud.rain.fill" : "sun.max.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(isRaining ? .blue : .yellow)
            
            Text(weatherText)
                .font(.title)
                .foregroundColor(isRaining ? .blue : .yellow)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(isRaining ? Color.gray.opacity(0.3) : Color.yellow.opacity(0.5))
        .cornerRadius(20)
        .padding(10)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 4)
        )
    }
}



struct RoomButtonView: View {
    var RoomData: RoomData
    
    var body: some View {
        VStack {
            Image(systemName: "house")
                .resizable()
                .frame(width: 50, height: 50)
            
            Text("Room ID: \(RoomData.ID)")
                .font(.headline)
            
            Text("Temperature: \(String(format: "%.2f", RoomData.Temperature ))°F, Humidity: \(String(format: "%.2f", RoomData.Humidity))%")
                .font(.subheadline)
                .padding(.top)
        }
        .padding()
        .foregroundColor(.white)
        .background(roomButtonColor)
        .cornerRadius(8)
        .overlay(

            RoundedRectangle(cornerRadius: 4)  

                .stroke(roomButtonBorderColor, lineWidth: 8)
                .padding(4)
        )
    }
    
    private var roomButtonColor: Color {
        if RoomData.Temperature > 74 {
            return Color.pink.opacity(0.7)
        } else {
            return Color.blue.opacity(0.7)
        }
    }

    private var roomButtonBorderColor: Color {
        if RoomData.Humidity < 40 {
            return Color.pink.opacity(0.7)
        } else {
            return .gray
        }
    }
}


extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
 
