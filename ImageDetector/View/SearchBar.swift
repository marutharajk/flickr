//
//  SearchBar.swift
//  ImageDetector
//
//  Created by Marutharaj K on 17/09/21.
//

import SwiftUI

// MARK: - Categories -

/// Extends String to define user interface image and speech error
private extension String {
    static let assetClose = "img_close"
    static let searchPlaceHolder = "Search..."
    static let speechErrorMessage = "Access Denied by User"
    static let speechErrorSheetTitle = "Speech Error"
    static let speechErrorSheetButtonTitle = "Reinstall the App"

}

// MARK: - Type - SearchBar -

/**
 SearchBar will get search tags from the user by keyboard or voice
 */
struct SearchBar: View {
    @Binding var text: String

    @State private var isEditing = false
    @State var actionPop: Bool = false
    @EnvironmentObject var speech: Speech

    var body: some View {
        HStack {
            
            TextField(String.searchPlaceHolder, text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if isEditing {
                            Button(action: {
                                self.text = ""
                            },
                            label: {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            })
                        }
                    }
                )
                .padding(.horizontal, 10.0)
                .onTapGesture {
                    self.isEditing = true
                }
            
            Button(action: {
                self.speechButtonTapped()
            }, label: {
                Image(uiImage: #imageLiteral(resourceName: "img_mic"))
                    .renderingMode(.original)
                    .background(speech.isRecording ? Circle().foregroundColor(.red).frame(width: 25.0, height: 25.0) : Circle().foregroundColor(.rgb(237, 240, 245)).frame(width: 25.0, height: 25.0))
            })
                .padding(.trailing, 16.0)
                .actionSheet(isPresented: $actionPop) {
                    ActionSheet(title: Text(String.speechErrorSheetTitle), message: Text(String.speechErrorMessage), buttons: [ActionSheet.Button.destructive(Text(String.speechErrorSheetButtonTitle))])
                }
            
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
                    
                    // Dismiss the keyboard
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                },
                label: {
                    Image(.assetClose)
                        .renderingMode(.template)
                        .foregroundColor(.darkBlackColor)
                })
                    .padding(.trailing, 10.0)
                    .transition(.move(edge: .trailing))
                    .animation(.default)
            }
        }
    }
}

private extension SearchBar {
    
    func speechButtonTapped() {
        
        if speech.getSpeechStatus() == .denied {
            actionPop.toggle()
        } else {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.3, blendDuration: 0.3)) { speech.isRecording.toggle()
            }
            
            speech.isRecording ? speech.startRecording() : speech.stopRecording()
            
            if !speech.isRecording {
                text = speech.outputText
            }
        }
    }
}

#if DEBUG
struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
#endif
