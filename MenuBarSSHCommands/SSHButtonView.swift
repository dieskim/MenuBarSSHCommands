import SwiftUI

struct SSHButtonView: View {
    @State private var buttons = [
        SSHButton(title: "Button 1", command: "ssh user@host1"),
        SSHButton(title: "Button 2", command: "ssh user@host2"),
        SSHButton(title: "Button 3", command: "ssh user@host3")
    ]
    
    @State private var isEditing = false
    @State private var newButtonTitle = ""
    @State private var newButtonCommand = ""
    
    struct RedMenu: MenuStyle {
        func makeBody(configuration: Configuration) -> some View {
            Menu(configuration)
                .foregroundColor(.red)
        }
    }
    
    var body: some View {
        
            
            Menu("Copy") {
                Button("Copy", action: test)
                Button("Copy Formatted", action: test)
                Button("Copy Library Path", action: test)
                Menu("Copy") {
                    Button("Copy", action: test)
                    Button("Copy Formatted", action: test)
                    Button("Copy Library Path", action: test)
                }
            }
        
        VStack {
            ForEach(buttons, id: \.self) { button in
                HStack {
                    Button(button.title, action: {
                        executeSSHCommand(command: button.command)
                    })
                    if isEditing {
                        Button(action: {
                            deleteButton(offsets: IndexSet([buttons.firstIndex(of: button)!]))
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .onDelete(perform: deleteButton)
        }
        Button(action: {
            isEditing.toggle()
        }) {
            Image(systemName: isEditing ? "checkmark.circle.fill" : "pencil")
        }
        if isEditing {
            VStack {
                TextField("Button Title", text: $newButtonTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("SSH Command", text: $newButtonCommand)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    addButton()
                }) {
                    Image(systemName: "plus")
                }
            }
        }
    }

    private func addButton() {
        buttons.append(SSHButton(title: newButtonTitle, command: newButtonCommand))
        newButtonTitle = ""
        newButtonCommand = ""
    }
    
    private func deleteButton(offsets: IndexSet) {
        buttons.remove(atOffsets: offsets)
    }
    
    private func executeSSHCommand(command: String) {
        // Perform actions to execute the SSH command
        print("Executing SSH command: \(command)")
    }
    
    struct SSHButton: Equatable, Identifiable, Hashable {
        let id = UUID()
        let title: String
        let command: String
    }
    
    private func test() {

        print("test")
    }
}
