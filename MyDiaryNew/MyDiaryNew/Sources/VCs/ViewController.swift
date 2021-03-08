//
//  ViewController.swift
//  autoLayout_Test02
//
//  Created by MinWoo Lee on 2021/02/16.
//

import UIKit
import FSCalendar
import SQLite3

@IBDesignable
class ViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {

    @IBOutlet weak var myCalendar: FSCalendar!
    
    // For Connect SQLite3
    var db : OpaquePointer?
    
    // Variable for save selected date
    var selectDate = ""
    
    // Variable for check current date
    var current_date_string = ""
    
    // Date on current page of calendar
    var currentPageDate = ""
    
    // For DateFormatter
    let dateFormatter = DateFormatter()
    
    // List of days of registration
    var eventDates = [Date]()
    
    // List of filenames of images
    var imageFileNames = [String]()
    
    // Variables for func called moveCurrentPage
    private var currentPage: Date?
    private lazy var today: Date = {
        return Date()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Calendar design
        calendarDesign()

        // Connect FSCalendar
        myCalendar.delegate = self
        myCalendar.dataSource = self

        // For get current date
        dateFormatter.dateFormat = "YYYY-MM-dd"
        dateFormatter.locale = Locale(identifier: "ko")
        current_date_string = dateFormatter.string(from: Date())
        
        // For when use button with other buttons on same view
        view.addSubview(myCalendar)
        myCalendar.addSubview(myCalendar.calendarHeaderView)
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        myCalendar.calendarHeaderView.addGestureRecognizer(tapGR)
        
        // Create SQLite DB
        createSQLite()
        
        // DB select action
        readValues()

        myCalendar.register(FSCalendarCell.self, forCellReuseIdentifier: "CELL")
            }

    // When touch title on calendar
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        
        currentPageDate = dateFormatter.string(from: myCalendar.currentPage)
        // Save current page on calendar
        let varDate = String(currentPageDate.split(separator: "-")[0]) + "-" + String(currentPageDate.split(separator: "-")[1])
        
        self.performSegue(withIdentifier: "moveList", sender: self)
        ListDateYear = String(currentPageDate.split(separator: "-")[0])
        ListDateMonth = String(currentPageDate.split(separator: "-")[1])
        ListDateYM = String(varDate)
        
    }
    
    // Reload data when back from other view
    override func viewWillAppear(_ animated: Bool) {
        
        // DB select action
        readValues()
        
        // Connect FSCalendar
        myCalendar.delegate = self
        myCalendar.dataSource = self
        
        // Reload Data
        myCalendar.reloadData()

    }

    // Button for move to SelectEmotionViewController
    @IBAction func btnNew(_ sender: UIButton) {
        // Exception handling when if don't select any date
        if selectDate == ""{
            // Show alert
            let shouldSelectAlert = UIAlertController(title: "", message: "날짜를 선택해주세요.", preferredStyle: UIAlertController.Style.alert)
            let onAction = UIAlertAction(title: "네, 알겠습니다.", style: UIAlertAction.Style.destructive, handler: nil)

            shouldSelectAlert.addAction(onAction)
            present(shouldSelectAlert, animated: true, completion: nil)
        }else{
            dateFormatter.dateFormat = "YYYY-MM-dd"
            dateFormatter.locale = Locale(identifier: "ko")
            let date = dateFormatter.date(from: selectDate)!
      
            selectDate_EmotionView = selectDate
            self.performSegue(withIdentifier: "moveSelectEmo", sender: self)
            
            self.myCalendar.deselect(date)
            selectDate = ""
        }
    }
    
    // Func for Calendar Design
    func calendarDesign(){
        // Remove placeholder
        myCalendar.placeholderType = .none
        
        // Today color
        myCalendar.appearance.todayColor = UIColor(red: 170/255, green: 193/255, blue: 214/255, alpha: 1)
        
        // Click date color
        myCalendar.appearance.selectionColor = UIColor(red: 204/255, green: 226/255, blue: 203/255, alpha: 1)
  
        // Allow scroll
        myCalendar.scrollEnabled = true
        
        // Set border radious of clicked date
        myCalendar.appearance.borderRadius = 1
        
        // Set color of weekday
        myCalendar.appearance.titleDefaultColor = .black

        // Set color of weekend
        myCalendar.appearance.titleWeekendColor = .red

        // Set color title of year and month
        myCalendar.appearance.headerTitleColor = .black

        // Set color weekday text
        myCalendar.appearance.weekdayTextColor = .gray
        
        // Set color title
        myCalendar.appearance.titleSelectionColor = .black
        
        // Set color subtitle
        myCalendar.appearance.subtitleSelectionColor = .black
        
        // Change header dateformat to Korea
        myCalendar.appearance.headerDateFormat = "YYYY년 M월"

        // First way to can change text of day of the week
        myCalendar.locale = Locale(identifier: "ko_KR")
                
        // Second way to can change text of day of the week
        myCalendar.calendarWeekdayView.weekdayLabels[0].text = "일"
        myCalendar.calendarWeekdayView.weekdayLabels[1].text = "월"
        myCalendar.calendarWeekdayView.weekdayLabels[2].text = "화"
        myCalendar.calendarWeekdayView.weekdayLabels[3].text = "수"
        myCalendar.calendarWeekdayView.weekdayLabels[4].text = "목"
        myCalendar.calendarWeekdayView.weekdayLabels[5].text = "금"
        myCalendar.calendarWeekdayView.weekdayLabels[6].text = "토"
        
        // Remove placeholder on calnedar
        myCalendar.appearance.headerMinimumDissolvedAlpha = 0
    }
    
    // When click a date
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        dateFormatter.dateFormat = "YYYY-MM-dd"
        selectDate = dateFormatter.string(from: date)
       
        // When the date is registered
        if self.eventDates.contains(date){
            strDate = selectDate
            self.performSegue(withIdentifier: "MoveDetailDirect", sender: self)
            self.myCalendar.deselect(date)
            selectDate = ""
        }
    }
    
    // When uncheck date
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectDate = ""
    }
    
    // Image output instead of date
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {

        if self.eventDates.contains(date){
            return UIImage(named: imageFileNames[eventDates.firstIndex(of: date)!])
        }
        return nil
    }
    
    // Can select date until today
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    
    // Create SQLite DB
    func createSQLite(){
        // For create DB
          let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("MyDiaryData.sqlite")
          
          if sqlite3_open(fileURL.path, &db) != SQLITE_OK{
              print("error opening database")
          }
          
          // If table exist don't create else create table
          if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS contents (cId INTEGER PRIMARY KEY AUTOINCREMENT, cTitle TEXT, cContent TEXT, cImageFileName TEXT, cInsertDate TEXT, cUpdateDate TEXT)", nil, nil, nil) != SQLITE_OK{
              let errmsg = String(cString: sqlite3_errmsg(db)!)
              print("error creating table : \(errmsg)")
          }
    }
    
    // DB SELECT Action
    func readValues(){
        let queryString = "SELECT * FROM contents"
        var stmt : OpaquePointer?
        var tempDate = [Date]()
        var tempImageFileNames = [String]()
        
        eventDates.removeAll()
        imageFileNames.removeAll()
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select : \(errmsg)")
            return
        }
        
        while sqlite3_step(stmt) == SQLITE_ROW{
            let cImageFileName = String(cString: sqlite3_column_text(stmt, 3))
            let cInsertDate = String(cString: sqlite3_column_text(stmt, 4))
            dateFormatter.locale = Locale(identifier: "ko")
        
            tempImageFileNames.append(changeCalendarImageName(beforename : cImageFileName))
            tempDate.append(dateFormatter.date(from: cInsertDate)!)
            
            eventDates = tempDate
            imageFileNames = tempImageFileNames
        }
    }
    
    // Find to simulator path
    func getDocumentDirectory() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    // Change imagefilename for show on calendar
    func changeCalendarImageName(beforename : String) -> String{
        switch beforename{
        case "beige.png":
            return "cal_beige.png"
        case "deepgray.png":
            return "cal_deepgray.png"
        case "green.png":
            return "cal_green.png"
        case "deepPurple.png":
            return "cal_deepPurple.png"
        case "liteblue.png":
            return "cal_liteblue.png"
        case "yellow.png":
            return "cal_yellow.png"
        case "purple.png":
            return "cal_purple.png"
        case "pink2.png":
            return "cal_pink.png"
        case "deepRed.png":
            return "cal_deepRed.png"
        case "laidgray.png":
            return "cal_laidgray.png"
        case "orange.png":
            return "cal_orange.png"
        case "navy.png":
            return "cal_navy.png"
        default:
            return ""
        }
    }
}


