//
//  CreateBugView.swift
//  BugTracking-Task
//
//  Created by Abdelhamid on 06/01/2025.
//

import SwiftUI

struct CreateBugView: View {
    
    @State private var bugDescription: String = ""
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented: Bool = false
    @State private var showActionSheet: Bool = false
    @State private var imageSource: UIImagePickerController.SourceType = .photoLibrary

    var userName: String {
        let userdefaultManager: UserDefaultsManaging = UserDefaultsManager()
        return userdefaultManager.loadUser()?.name ?? ""
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Hello, \(userName)")
                    Spacer()
                }
                .padding()

                // Selected Image
                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(10)
                        .padding(.horizontal)
                } else {
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [5]))
                        .frame(height: 200)
                        .overlay(
                            Text("Tap to select or capture a bug image")
                                .foregroundColor(.gray)
                        )
                        .onTapGesture {
                            showActionSheet = true
                        }
                        .padding(.horizontal)
                }

                // Bug Description
                ZStack(alignment: .topLeading) {
                    // TextEditor
                    TextEditor(text: $bugDescription)
                        .frame(height: 100)
                        .padding(.horizontal, 4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )

                    // Placeholder
                    if bugDescription.isEmpty {
                        Text("Describe the bug...")
                            .foregroundColor(.gray)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                    }
                }
                .padding(.horizontal)

                Spacer()

                // Submit Button
                Button(action: submitBug) {
                    Text("Submit Bug")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .disabled(bugDescription.isEmpty || selectedImage == nil)
            }
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(title: Text("Select Image"), buttons: [
                    .default(Text("Take Photo")) {
                        imageSource = .camera
                        isImagePickerPresented = true
                    },
                    .default(Text("Choose from Gallery")) {
                        imageSource = .photoLibrary
                        isImagePickerPresented = true
                    },
                    .cancel()
                ])
            }
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(sourceType: imageSource, selectedImage: $selectedImage)
            }
        }
    }
    
    private func submitBug() {
        
    }
}

#Preview {
    CreateBugView()
}
