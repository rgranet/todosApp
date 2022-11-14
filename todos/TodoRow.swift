//
//  TodoRowView.swift
//  todos
//
//  Created by Ruben Granet on 30/08/2022.
//

import SwiftUI

struct TodoRow: View {
    let todo:Todo
    var body: some View {
        HStack{
            if todo.isImportant{
                Image(systemName: "star")
            }
            Text(todo.title)
                .font(.headline)
            Spacer()
            if todo.completed {
                Image(systemName: "checkmark")
            }
        }.padding()
    }
}

struct TodoRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            TodoRow(todo: Todo(id : 1, title: "Finir le cours", completed: false))
            TodoRow(todo: Todo(id : 2, title: "Finir le cours", completed: true))
        }.previewLayout(.fixed(width: 600, height: 100))
    }
}
