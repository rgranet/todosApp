//
//  TodoListView.swift
//  todos
//
//  Created by Ruben Granet on 30/08/2022.
//

import SwiftUI

struct TodoListView: View {
    @State var todoList:[Todo] = []
    @State var searchFilter = ""
    var body: some View {
        NavigationView{
            List {
                ForEach ($todoList){$todo in
                    if searchFilter.isEmpty || todo.title.lowercased().contains(searchFilter.lowercased()){
                        TodoRow(todo: todo).onTapGesture {
                            todo.completed.toggle()
                        }
                        .listRowSeparator(.hidden)
                        .swipeActions(allowsFullSwipe:false) {
                            Button(role: .destructive) {
                                if let index = todoList.firstIndex(of: todo){
                                    withAnimation {
                                        _ = todoList.remove(at: index)
                                    }
                                }
                            } label: {
                                Label("Supprimer", systemImage: "trash")
                            }
                        }
                        .swipeActions(edge: .leading){
                            Button {
                                todo.isImportant.toggle()
                            } label: {
                                Label("Important", systemImage: "star")
                            }
                        }
                    }
                }
            }.navigationTitle("💻 Todos")
            .task {
                await loadTodoList()
            }.refreshable {
                await loadTodoList()
            }
            .searchable(text: $searchFilter){
                switch searchFilter.count{
                case 0:
                    Text("🚀").searchCompletion("fusée")
                    Text("☀️").searchCompletion("soleil")
                case 1:
                    Text("🐎").searchCompletion("cheval")
                    Text("💻").searchCompletion("ordinateur")
                default:
                    Text("📱").searchCompletion("iPhone")
                }
            }
        }
    }
    
    func loadTodoList() async {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos") else
        { return }
        do {
            let (response,_) = try await URLSession.shared.data(from: url)
            todoList = try JSONDecoder().decode([Todo].self, from: response)
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
    }
}

