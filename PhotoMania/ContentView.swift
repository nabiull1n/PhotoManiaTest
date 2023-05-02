//
//  ContentView.swift
//  PhotoMania
//
//  Created by Денис Набиуллин on 02.05.2023.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var image: Image?
    func fetchNewImage() {
        guard let url = URL(string: "https://picsum.photos/200/300") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async {
                guard let uiImage = UIImage(data: data) else {
                    return
                }
                self.image = Image(uiImage: uiImage)
            }
        }
        task.resume()
    }
}

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    var body: some View {
        NavigationView {
            VStack {
                
                Spacer()
                
                if let image = viewModel.image {
                    image
                        .resizable()
                        .frame(width: 200, height: 300)
                        .padding()
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .padding()
                }
                
                Spacer()
                
                Button(action: {
                    viewModel.fetchNewImage()
                }, label: {
                    Text("New Image")
                        .bold()
                        .frame(width: 190, height: 40)
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding()
                })
            }
            .navigationTitle("Photo Mania")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
