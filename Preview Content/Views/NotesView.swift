import SwiftUI

struct NotesView: View {
    @State private var notes = [Note]() // List of notes
    @State private var noteText = "" // Text for new or editing note
    @State private var isEditing = false // Flag to check if the user is editing a note
    @State private var noteToEdit: Note? // The note currently being edited
    @State private var summarizedText = "" // Store the summary result
    @AppStorage("isDarkMode") private var isDarkMode = false // Store dark mode setting
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Header with Light/Dark Mode Toggle and Icons
                HStack {
                    Text("My Notes")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.leading)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    // Dark Mode Toggle with Icons to the Right
                    HStack {
                        Toggle(isOn: $isDarkMode) {
                            Text("")
                        }
                        .toggleStyle(SwitchToggleStyle(tint: isDarkMode ? .yellow : .blue))
                        
                        // Sun/Moon Icon to the Right of Toggle
                        if isDarkMode {
                            Image(systemName: "moon.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.yellow)
                        } else {
                            Image(systemName: "sun.max.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.trailing, 8)
                }
                .padding(.vertical)
                
                // Text Editor for Adding or Editing Note
                TextEditor(text: $noteText)
                    .frame(height: 100)
                    .padding()
                    .background(isDarkMode ? Color.black.opacity(0.8) : Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 8)
                    .padding(.horizontal)
                
                // Save Button
                Button(action: {
                    if isEditing, let note = noteToEdit {
                        // If we are editing, update the note
                        updateNote(note)
                    } else {
                        // Otherwise, add a new note
                        addNote()
                    }
                    noteText = "" // Clear the input field
                }) {
                    Text(isEditing ? "Update Note" : "Add Note")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(isEditing ? Color.orange : Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding()
                
                // Summarize Button
                Button(action: {
                    summarizeText(text: noteText) // Call the summarize function
                }) {
                    Text("Summarize Note")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding()

                // Display the summarized text
                if !summarizedText.isEmpty {
                    Text("Summary: \(summarizedText)")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .padding()
                }
                
                // List of notes
                List {
                    ForEach(notes) { note in
                        NavigationLink(destination: EditNoteView(note: note, notes: $notes)) {
                            Text(note.text)
                                .font(.body)
                                .lineLimit(2) // Limiting lines for neatness
                                .padding()
                                .background(isDarkMode ? Color.gray.opacity(0.7) : Color.white)
                                .cornerRadius(12)
                                .shadow(radius: 5)
                        }
                    }
                    .onDelete(perform: deleteNotes) // Swipe to delete functionality
                }
                .padding()
                .listStyle(PlainListStyle())
                
                Spacer()
            }
            .navigationTitle("Notes")
            .navigationBarTitleDisplayMode(.inline)
            .preferredColorScheme(isDarkMode ? .dark : .light) // Apply dark or light mode
        }
        .background(isDarkMode ? Color.black : Color.white) // Ensure background color is updated
    }
    
    // Add a new note
    func addNote() {
        let newNote = Note(text: noteText)
        notes.append(newNote) // Add to list
    }
    
    // Update the selected note
    func updateNote(_ note: Note) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index].text = noteText // Update the note's text
        }
    }
    
    // Delete a specific note
    func deleteNote(_ note: Note) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes.remove(at: index) // Remove the note from the array
        }
    }
    
    // Function for swipe-to-delete functionality
    func deleteNotes(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets) // Remove the notes at the given offset
    }
    
    // Summarize the text using a simple extractive method
    func summarizeText(text: String) {
        let sentences = splitTextIntoSentences(text)
        let sentenceScores = calculateSentenceScores(sentences)
        let topSentences = getTopSentences(sentenceScores, sentences)
        
        summarizedText = topSentences.joined(separator: " ")
    }

    // Split the text into sentences
    func splitTextIntoSentences(_ text: String) -> [String] {
        // Simple split by period, you can use more advanced tokenizers for better sentence segmentation
        return text.split(separator: ".").map { String($0).trimmingCharacters(in: .whitespaces) }
    }
    
    // Calculate the importance of each sentence using a basic heuristic
    func calculateSentenceScores(_ sentences: [String]) -> [Int: Int] {
        var sentenceScores: [Int: Int] = [:]
        
        for (index, sentence) in sentences.enumerated() {
            let wordCount = sentence.split(separator: " ").count
            // Score based on word count or any other heuristic (e.g., TF-IDF, frequency)
            sentenceScores[index] = wordCount
        }
        
        return sentenceScores
    }
    
    // Get the top N sentences based on score
    func getTopSentences(_ sentenceScores: [Int: Int], _ sentences: [String]) -> [String] {
        // Sort sentences by their score and select top 3 for the summary
        let sortedSentenceIndexes = sentenceScores.sorted { $0.value > $1.value }
        let topIndexes = sortedSentenceIndexes.prefix(3).map { $0.key }
        
        return topIndexes.map { sentences[$0] }
    }
}

struct EditNoteView: View {
    var note: Note
    @Binding var notes: [Note] // Binding to the original notes array
    @State private var noteText: String
    @Environment(\.presentationMode) var presentationMode // To dismiss the view after deleting or updating
    
    init(note: Note, notes: Binding<[Note]>) {
        self.note = note
        _notes = notes
        _noteText = State(initialValue: note.text)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            TextEditor(text: $noteText)
                .frame(height: 150)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 8)
                .padding(.horizontal)
            
            HStack {
                // Update Button
                Button(action: {
                    updateNote()
                }) {
                    Text("Update Note")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                }
                
                Spacer()
                
                // Delete Button
                Button(action: {
                    deleteNote()
                }) {
                    Text("Delete Note")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                }
            }
            .padding()
        }
        .navigationTitle("Edit Note")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func updateNote() {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index].text = noteText // Update the note's text
            presentationMode.wrappedValue.dismiss() // Go back to the notes list
        }
    }
    
    func deleteNote() {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes.remove(at: index) // Remove the note from the array
            presentationMode.wrappedValue.dismiss() // Go back to the notes list
        }
    }
}

struct Note: Identifiable {
    let id = UUID() // Unique identifier for each note
    var text: String
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView()
    }
}
