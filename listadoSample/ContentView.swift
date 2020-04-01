//
//  ContentView.swift
//  listadoSample
//
//  Created by miguel tomairo on 3/31/20.
//  Copyright © 2020 rapser. All rights reserved.
//

import SwiftUI
import Combine

class DataSource: ObservableObject {
    
    @Published var picture = [String]()
    
    init() {
        let fm = FileManager.default
        
        if let path = Bundle.main.resourcePath, let items = try? fm.contentsOfDirectory(atPath: path) {
            
            for item in items{
                if item .hasPrefix("Arte"){
                    picture.append(item)
                }
            }
        }
    }
}

struct ContentView: View {
    
    @ObservedObject var datasource = DataSource()
    
    var body: some View {
        
        NavigationView{
            List(datasource.picture, id: \.self){ picture in
                
                NavigationLink(destination: DetailView(selectedImage: picture)) {
                    Text(picture)
                }
                
            }.navigationBarTitle(Text("Galería"))
        }
   
    }
}

struct DetailView: View {
    
    @State private var hidesNavigationBar = false
    var selectedImage: String
    
    var body: some View {
        let img = UIImage(named: selectedImage)!
        return Image(uiImage: img)
        .resizable()
        .aspectRatio(1024/768, contentMode: .fit)
        .navigationBarTitle(Text(selectedImage), displayMode: .inline)
        .navigationBarHidden(hidesNavigationBar)
            .onTapGesture {
                self.hidesNavigationBar.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
