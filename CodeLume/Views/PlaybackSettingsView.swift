//
//  PlaybackSettingsView.swift
//  CodeLume
//
//  Created by Lyke on 2025/3/13.
//

import SwiftUI

struct PlaybackSettingsView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("General Settings")
                .font(.title3)
            Divider()
            Toggle(isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Is On@*/.constant(true)/*@END_MENU_TOKEN@*/) {
                HStack {
                    Label("Start at login", systemImage: "power.circle")
                    Spacer()
                }
                .padding(.leading)
            }
            .toggleStyle(.switch)
            Text("Playback Settings")
                .font(.title3)
            
            Divider()
            
            Toggle(isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Is On@*/.constant(true)/*@END_MENU_TOKEN@*/) {
                HStack {
                    Label("Pause the playback when there are other apps on the desktop", systemImage: "pause.rectangle")
                    Spacer()
                }
                .padding(.leading)
            }
            .toggleStyle(.switch)
            
            Toggle(isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Is On@*/.constant(true)/*@END_MENU_TOKEN@*/) {
                HStack {
                    Label("Pause the playback when the app is in full-screen mode", systemImage: "pause.rectangle.fill")
                    Spacer()
                }
                .padding(.leading)
            }
            .toggleStyle(.switch)
            
            Toggle(isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Is On@*/.constant(true)/*@END_MENU_TOKEN@*/) {
                HStack {
                    Label("Pause the playback when in battery-powered mode", systemImage: "battery.100")
                    Spacer()
                }
                .padding(.leading)
            }
            .toggleStyle(.switch)
            
            Toggle(isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Is On@*/.constant(true)/*@END_MENU_TOKEN@*/) {
                HStack {
                    Label("Pause the playback when in power-saving mode", systemImage: "battery.25")
                    Spacer()
                }
                .padding(.leading)
            }
            .toggleStyle(.switch)
        }
        .padding()
    }
}

#Preview {
    PlaybackSettingsView()
}
