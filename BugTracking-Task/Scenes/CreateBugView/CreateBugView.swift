//
//  CreateBugView.swift
//  BugTracking-Task
//
//  Created by Abdelhamid on 06/01/2025.
//

import SwiftUI

struct CreateBugView: View {
    
    @ObservedObject var viewModel: CreateBugViewModel
    @State private var bugDescription: String = ""
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented: Bool = false
    @State private var showActionSheet: Bool = false
    @State private var imageSource: UIImagePickerController.SourceType = .photoLibrary
    
    var userName: String {
        let userdefaultManager: UserDefaultsManaging = UserDefaultsManager()
        return userdefaultManager.loadUser()?.name ?? ""
    }
    
    init(viewModel: CreateBugViewModel, sharedImage: UIImage? = nil) {
        self.viewModel = viewModel
        self._selectedImage = State(initialValue: sharedImage) 
    }

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Hello, \(userName)")
                        .bold()
                    
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
                
                if viewModel.isLoading {
                    ProgressView {
                        Text("Loading...")
                    }
                }else {
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
            .alert(isPresented: .constant(viewModel.isUploadSuccessful || viewModel.errorMessage != nil)) {
                if viewModel.isUploadSuccessful {
                    return Alert(
                        title: Text("Success"),
                        message: Text("Bug uploaded successfully!"),
                        dismissButton: .default(Text("OK")) {
                            viewModel.isUploadSuccessful = false
                            selectedImage = nil
                            bugDescription = ""
                        }
                    )
                } else {
                    return Alert(
                        title: Text("Error"),
                        message: Text(viewModel.errorMessage ?? "An unknown error occurred"),
                        dismissButton: .default(Text("OK")) {
                            viewModel.errorMessage = nil // Reset error state
                        }
                    )
                }
            }
        }
    }

    
    private func submitBug() {
        if let image = selectedImage, !bugDescription.isEmpty {
            viewModel.uploadBugData(image: image, description: bugDescription)
        }
    }
}


#Preview {
    DependencyManager.createBugView()
}
