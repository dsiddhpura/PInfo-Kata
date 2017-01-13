//
//  Calculate.swift
//  Kata
//
//  Created by Dharmesh Siddhpura on 1/12/17.
//  Copyright © 2017 Dharmesh Siddhpura. All rights reserved.
//

//: Playground - noun: a place where people can play

import Foundation

let Default_Column = 0
var max_row_count = 0
var max_column_count = 0

struct Cell
{
    var point: Point
    var value: Int
    
    //var isVisited: Bool
    
    init(pt: Point, value: Int)
    {
        self.point = pt
        self.value = value
    }
}

//This class will act like a Queue of cells (you can say checkpoints on the route)
class Path
{
    var pathMap = [Cell]()
    var totalWeight: Int = 0
    var isSucceed: Bool
    
    init()
    {
        //This will indicate whether this particular path has made its way till the end (last column)
        isSucceed = true
    }
    
    func addCell(cell: Cell)
    {
        pathMap.append(cell)
        totalWeight = totalWeight + cell.value
    }
    
    func getIndexPath() -> String
    {
        var path = ""
        for cell in pathMap
        {
            path = path + "\(cell.point.x + 1) "
        }
        
        return path
    }
    
    func getValuePath() -> String
    {
        var path = ""
        for cell in pathMap
        {
            path = path + "\(cell.value) "
        }
        
        return path
    }
}

struct Point
{
    var x: Int
    var y: Int
}

func find(array: [[Int]], entryPoint: Point) -> (Bool, Int, String)
{
    let cellPath = Path()
    
    if (array.count <= entryPoint.x)
    {
        showAlert(title: "Invalid", message: "Index out of bound", vc: nil)
        
        return (false, 0, "Index out of bounds")
    }
    
    let value = array[entryPoint.x][entryPoint.y]
    
    let cell = Cell(pt: entryPoint, value: value)
    cellPath.addCell(cell: cell)
    
    max_row_count = array.count
    max_column_count = array[entryPoint.x].count
    
    var currentPoint = entryPoint
    
    /* We can make below section ('for' loop) recursive for tracing different routes and each route can be added in below variable "listOfPaths"
     which will act like a Queue of paths.
     
     var listOfPaths: [Path]
     
     Depending upon cells visited we can compare the route for different paths. And each path will have a property called total weight by which
     we can compare the weights of different paths anytime.
     */
    
    for j in 1..<max_column_count
    {
        var topRow: Int = 0
        var currentRow: Int = 0
        var bottomRow: Int = 0
        
        topRow = currentPoint.x - 1
        
        if(topRow < 0)
        {
            topRow = max_row_count - 1
        }
        
        currentRow = currentPoint.x
        
        bottomRow = currentPoint.x + 1
        
        if(bottomRow > max_row_count - 1)
        {
            bottomRow = 0
        }
        
        let nextRowIndex = findMinValueIndex(array: array, first: topRow, second: currentRow, third: bottomRow, column: j)
        let nextCellValue = array[nextRowIndex][j]
        
        if cellPath.totalWeight + nextCellValue > 50
        {
            //Current Path is failed to reach last column
            cellPath.isSucceed = false
            break
        }
        
        currentPoint.x = nextRowIndex
        currentPoint.y = j + 1
        
        let cell = Cell(pt: currentPoint, value: nextCellValue)
        cellPath.addCell(cell: cell)
    }
    
    let path = cellPath.getIndexPath()
    print("\(cellPath.isSucceed)" + "\n\(cellPath.totalWeight)" + "\n\(path)")
    
    return (cellPath.isSucceed, cellPath.totalWeight, path)
}

func compute(cell: Cell)
{
    
}

func findMinValueIndex(array: [[Int]], first: Int, second: Int, third: Int, column: Int) -> Int
{
    if(array[first][column] <= array[second][column])
    {
        if(array[first][column] < array[third][column])
        {
            return first
        }
            
        else
        {
            return third
        }
    }
        
    else
    {
        if(array[second][column] <= array[third][column])
        {
            return second
        }
            
        else
        {
            return third
        }
    }
}

/*find(array: [ [3,4,1,2,8,6],
              [6,1,8,2,7,4],
              [5,9,3,9,9,5],
              [8,4,1,3,2,6],
              [3,7,2,8,6,4] ], entryPoint: Point(x: 0, y: 0))*/

/*find(array: [ [3,4,1,2,8,6],
 [6,1,8,2,7,4],
 [5,9,3,9,9,5],
 [8,4,1,3,2,6],
 [3,7,2,1,2,3] ], entryPoint: Point(x: 0, y: 0))*/

/*find(array: [ [19,10,19,10,19],
 [21,23,20,19,12],
 [20,12,20,11,10] ], entryPoint: Point(x: 0, y: 0))*/
