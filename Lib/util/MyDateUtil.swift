//
// Created by 李和 on 2021/8/3.
//

import Foundation


let weekmap = [2: "周一", 3: "周二", 4: "周三", 5: "周四", 6: "周五", 7: "周六", 0: "周日"]
let weekgap = [2: 0, 3: 1, 4: 2, 5: 3, 6: 4, 7: 5, 0: 6]

struct MyDateUtil {

    //时间戳（精确到秒）
    static func getTimeStamp(_ date: Date) -> Int {
        Int(floor(date.timeIntervalSince1970))
    }
    //时间戳（精确到毫秒）
    static func getMilliTimeStamp(_ date: Date) -> Int {
        Int(floor(date.timeIntervalSince1970 * 1000))
    }
    //当期时间戳（精确到秒）
    static func getCurrentTimeStamp() -> Int {
        getTimeStamp(Date())
    }
    //当期时间戳（精确到毫秒）
    static func getCurrentMilliTimeStamp() -> Int {
        getMilliTimeStamp(Date())
    }
    //格式化日期
    static func formatDate(_ date: Date) -> String {
        format(date, format: "yyyy-MM-dd")
    }
    //格式化时间
    static func formatTime(_ date: Date) -> String {
        format(date, format: "HH:mm:ss")
    }
    //格式化日期时间
    static func formatDateTime(_ date: Date) -> String {
        format(date, format: "yyyy-MM-dd HH:mm:ss")
    }
    //格式化
    static func format(_ date: Date, format: String) -> String {
        let c = Calendar.current
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = format
        let date = formatter.string(from: date)
        return date
    }
    //日期转化
    static func parse(_ str: String, format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.init(identifier: "zh_CN")
        return dateFormatter.date(from: str)
    }

    //日期转化
    static func parseDate(_ str: String) -> Date? {
        parse(str, format: "yyyy-MM-dd")
    }

    //日期时间转化
    static func parseDateTime(_ str: String) -> Date? {
        parse(str, format: "yyyy-MM-dd HH:mm:ss")
    }

    //日期操作
    static func gap(_ date: Date, unit: Calendar.Component, number: Int) -> Date {
        let cal = Calendar.current
        return cal.date(byAdding: unit, value: number, to: date)!
    }
    //某天凌晨
    static func getStartOfDay(_ date: Date) -> Date {
        let cal = Calendar.current
        return cal.date(bySettingHour: 0, minute: 0, second: 0, of: date)!
    }
    //某天夜晚
    static func getEndOfDay(_ date: Date) -> Date {
        let cal = Calendar.current
        return cal.date(bySettingHour: 23, minute: 59, second: 59, of: date)!
    }
    //昨天此时
    static func getYesterday() -> Date{
        gap(Date(), unit: .day, number: -1)
    }
    //当期第几周
    static func getWeekOfYear(_ date: Date) -> Int {
        let cal = Calendar.current
        let dc = cal.dateComponents([.weekOfYear], from: date)
        return dc.weekOfYear!
    }
    //当期星期几
    static func getWeekday(_ date: Date) -> Int {
        let cal = Calendar.current
        let dc = cal.dateComponents([.weekday], from: date)
        return dc.weekday!
    }
    //当期星期几
    static func getWeekdayString(_ date: Date) -> String {
        let cal = Calendar.current
        let dc = cal.dateComponents([.weekday], from: date)
        return weekmap[dc.weekday!]!
    }
    //获取本周第一天
    static func getFirstDayOfWeek(_ date: Date) -> Date {
        let weekday = getWeekday(date)
        let gapFirstDay = weekgap[weekday]!
        return gap(date, unit: .day, number: -gapFirstDay)
    }
    //获取本周最后一天
    static func getLastDayOfWeek(_ date: Date) -> Date {
        let weekday = getWeekday(date)
        let gapFirstDay = weekgap[weekday]!
        let gapLastDay = 6 - weekgap[weekday]!
        return gap(date, unit: .day, number: gapLastDay)
    }
    //获取某月第一天
    static func set(_ date: Date, unit: Calendar.Component, value: Int) -> Date {
        let c = Calendar.current
        var component = c.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        component.setValue(value, for: unit)
        return c.date(from: component)!
    }
    static func getFirstDayOfMonth(_ date: Date) -> Date {
        let mdate = set(date, unit: .day, value: 1)
        return getStartOfDay(mdate)
    }
    //获取某月最后一天
    static func getLastDayOfMonth(_ date: Date) -> Date {
        let firstDayOfMonth = getFirstDayOfMonth(date)
        let nextMonth = gap(firstDayOfMonth, unit: .month, number: 1)
        return getEndOfDay(gap(nextMonth, unit: .day, number: -1))
    }

    //判断两个日期之间间隔了多少天
    static func betweenDay(_ date1: Date, _ date2: Date) -> Int {
        let t1 = getTimeStamp(getStartOfDay(date1))
        let t2 = getTimeStamp(getStartOfDay(date2))
        return abs(t1 - t2) / 3600 / 24
    }

    //比较日期大小
    static func isAfterDateString(target: String) -> Bool {
        guard let d = parseDate(target) else {
            return false
        }
        return isAfter(Date(), target: d)
    }

    //比较日期大小
    static func isAfter(_ date1: Date, target: Date) -> Bool {
        getMilliTimeStamp(date1) > getMilliTimeStamp(target)
    }

    //比较日期大小
    static func isAfter(target: Date) -> Bool {
        isAfter(Date(), target: target)
    }

    //比较日期大小
    static func isBefore(_ date1: Date,target: Date) -> Bool {
        getMilliTimeStamp(date1) < getMilliTimeStamp(target)
    }

    //比较日期大小
    static func isBefore(target: Date) -> Bool {
        isBefore(Date(), target: target)
    }


    //获取显示时间
    static func getShowTime(_ date: Date) -> String {
        let now = getCurrentTimeStamp()
        let mtime = getTimeStamp(date)
        if(mtime > now){
            return "未来"
        }
        var gap = now - mtime
        if(gap < 60){
            return "\(gap)秒前"
        }
        gap = gap / 60
        if(gap < 60){
            return "\(gap)分钟前"
        }
        gap = gap / 60
        if(gap < 24) {
            return "\(gap)小时前"
        }
        gap = gap / 24
        if(gap < 5){
            return "\(gap)天前"
        }
        return formatDate(date)
    }
}