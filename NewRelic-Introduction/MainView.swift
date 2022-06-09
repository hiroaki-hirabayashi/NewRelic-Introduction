//
//  MainView.swift
//  NewRelic-Introduction
//
//  Created by Hiroaki-Hirabayashi on 2022/06/06.
//

import SwiftUI
import NewRelic

struct MainView: View {
    var body: some View {
        Button {
            NewRelicManager.shared.crashNow(logMessage: "手動クラッシュ")
        } label: {
            Text("NewRelicの手動クラッシュ")
                .font(.system(size: 32))
        }
        
        Button {
            fatalError("通常のエラー想定")
        } label: {
            Text("fatalError")
                .font(.system(size: 32))
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
