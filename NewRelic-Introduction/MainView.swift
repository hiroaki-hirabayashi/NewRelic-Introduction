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
            NewRelic.crashNow()
        } label: {
            Text("NewRelic.crashNow")
                .font(.system(size: 32))
        }

    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
