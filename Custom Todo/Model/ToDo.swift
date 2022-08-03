//
//  ToDo.swift
//  Custom Todo
//
//  Created by Pierpaolo Mariani on 18/07/22.
//
import RealmSwift
import Foundation

class Todo : Object  {
    @Persisted var text : String = ""
    @Persisted var priority : Int = 0
    @Persisted var tag : String = ""
    @Persisted var date : String = ""
}
