//
//  ContentView.swift
//  LiveActivityPractice
//
//  Created by BoMin Lee on 10/19/25.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
    @State private var connectionStatus: Bool = true
    @State private var activity: Activity<DynamicIslandWidgetAttributes>?
    
    var body: some View {
        NavigationStack {
            VStack {
                Button("Activate Live Activity") {
                    let dynamicIslandWidgetAttributes = DynamicIslandWidgetAttributes(name: "test")
                    let contentState = DynamicIslandWidgetAttributes.ContentState(value: 7, isConnected: connectionStatus)
                    do {
                        let newActivity = try Activity<DynamicIslandWidgetAttributes>.request(
                            attributes: dynamicIslandWidgetAttributes,
                            content: .init(state: contentState, staleDate: nil)
                        )
                        activity = newActivity
                        print(newActivity)
                    } catch {
                        print(error)
                    }
                }
                
                Toggle("Connection Status", isOn: $connectionStatus)
                    .onChange(of: connectionStatus) { _, newValue in
                        Task {
                            // 이미 시작된 액티비티가 없으면 가장 최근 액티비티를 찾아서 갱신을 시도
                            if activity == nil {
                                activity = Activity<DynamicIslandWidgetAttributes>.activities.first
                            }
                            
                            let newState = DynamicIslandWidgetAttributes.ContentState(
                                value: 7,
                                isConnected: newValue
                            )
                            
                            let content = ActivityContent(state: newState, staleDate: nil)
                            await activity?.update(content)
                        }
                    }
            }
            .padding()
            .task {
                // 앱 재실행 시에도 이어서 업데이트할 수 있도록 기존 액티비티를 잡아옵니다.
                if activity == nil {
                    activity = Activity<DynamicIslandWidgetAttributes>.activities.first
                }
            }
        }
        .navigationTitle("Live Activity")
    }
}

#Preview {
    ContentView()
}
