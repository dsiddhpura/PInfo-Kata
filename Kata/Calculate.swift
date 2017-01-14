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
    
    init(pt: Point, value: Int)
    {
        self.point = pt
        self.value = value
    }
}

class Path: NSObject, NSCopying
{
    private var pathMap: [Cell] = [Cell]()
    var totalWeight: Int = 0
    var isSucceed: Bool = false
    
    override init()
    {
        super.init()
    }
    
    private init(pathMap: [Cell], totalWeight: Int)
    {
        self.pathMap = pathMap
        self.totalWeight = totalWeight
        self.isSucceed = false
        
        super.init()
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Path(pathMap: self.pathMap, totalWeight: self.totalWeight)
        return copy
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

var listOfPath = [Path]()

func find(array: [[Int]], entryPoint: Point) -> (Bool, Int, String)
{
    if (array.count <= entryPoint.x)
    {
        return (false, 0, "Index out of bounds")
    }
    
    max_row_count = array.count
    max_column_count = array[entryPoint.x].count
    
    let currentPoint = entryPoint
    
    let cellPath = Path()
    listOfPath.append(cellPath)
    
    let value = array[currentPoint.x][currentPoint.y]
    
    let cell = Cell(pt: currentPoint, value: value)
    cellPath.addCell(cell: cell)
    
    compute(array: array, fromPoint: currentPoint, forPath: cellPath)
    
    if(listOfPath.count > 0)
    {
        var lowest: (Int, Int) = (Int(INT_MAX), Int(INT_MAX))
        
        for index in 0..<listOfPath.count
        {
            let cellPath = listOfPath[index]
            
            if(lowest.0 > cellPath.totalWeight)
            {
                lowest.0 = cellPath.totalWeight
                lowest.1 = index
            }
        }
        
        let path = listOfPath[lowest.1]
        print("\(path.isSucceed)" + "\n\(path.totalWeight)" + "\n\(path.getIndexPath())")
        listOfPath.removeAll()
        
        return (path.isSucceed, path.totalWeight, path.getIndexPath())
    }
        
    else
    {
        print("false", "\n-1", "\n---")
        return (false, -1, "---")
    }
}

func compute(array: [[Int]], fromPoint: Point, forPath cellPath: Path)
{
    var currentPoint = fromPoint
    
    currentPoint.y = currentPoint.y + 1
    
    if currentPoint.y < max_column_count
    {
        let rows = getNeighbourRows(forPoint: currentPoint)
        //        let topRow: Int = rows.top
        //        let currentRow: Int = rows.current
        //        let bottomRow: Int = rows.bottom
        
        
        let topCellValue = array[rows.top][currentPoint.y]
        
        if (cellPath.totalWeight + topCellValue < 50)
        {
            let result = getNextCellPath(row: rows.top, path: cellPath, point: currentPoint, value: topCellValue)
            compute(array: array, fromPoint: result.point, forPath: result.path)
        }
        
        let middleCellValue = array[rows.current][currentPoint.y]
        
        if (cellPath.totalWeight + middleCellValue < 50)
        {
            let result = getNextCellPath(row: rows.current, path: cellPath, point: currentPoint, value: middleCellValue)
            compute(array: array, fromPoint: result.point, forPath: result.path)
        }
        
        let bottomCellValue = array[rows.bottom][currentPoint.y]
        
        if (cellPath.totalWeight + bottomCellValue < 50)
        {
            let result = getNextCellPath(row: rows.bottom, path: cellPath, point: currentPoint, value: bottomCellValue)
            compute(array: array, fromPoint: result.point, forPath: result.path)
        }
        
        if let index = listOfPath.index(of: cellPath)
        {
            listOfPath.remove(at: index)
        }
    }
        
    else
    {
        cellPath.isSucceed = true
    }
}

func getNextCellPath(row: Int, path: Path, point: Point, value: Int) -> (point: Point, path: Path)
{
    let nextCellPath = path.copy() as! Path
    listOfPath.append(nextCellPath)
    
    let nextPoint = Point(x: row, y: point.y)
    
    let cell = Cell(pt: nextPoint, value: value)
    nextCellPath.addCell(cell: cell)
    
    return (nextPoint, nextCellPath)
}

func getNeighbourRows(forPoint currentPoint: Point) -> (top: Int, current: Int, bottom: Int)
{
    var topRow: Int = currentPoint.x - 1
    if(topRow < 0)
    {
        topRow = max_row_count - 1
    }
    
    let currentRow: Int = currentPoint.x
    
    var bottomRow: Int = currentPoint.x + 1
    if(bottomRow > max_row_count - 1)
    {
        bottomRow = 0
    }
    
    return (topRow, currentRow, bottomRow)
}
