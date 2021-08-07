//
// Created by 李和 on 2021/8/4.
//

import SwiftUI



struct TestDateUtilView: View {

    @State var timer: Int = 0

    @State var columns = [
        GridItem(.adaptive(minimum: 220))
    ]

    @State var views: [CellView] = []

    var body: some View {
        VStack{
            LazyVGrid(columns: columns, spacing: 10) {
                if(views.count > 0){
                    ForEach(0..<views.count) {i in
                        views[i]
                    }
                }
            }
        }.onAppear{
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                self.timer += 1
            }

            initPage()

        }
    }

    func initPage(){
        self.views.removeAll()

        self.views.append(line(label: "随机数", data: randomNum(1, 3)))
        self.views.append(line(label: "颜色", data: hex2decimal("11")))
        self.views.append(line(label: "子串1", data: "hello".slice(begin: 1, end: 2)))
        self.views.append(line(label: "子串2", data: "hello".slice(begin: 1, end: -1)))
        self.views.append(line(label: "子串3", data: "hello".slice(begin: 1, end: 7)))
        self.views.append(line(label: "子串4", data: "hello".slice(begin: 1, len: 1)))
        self.views.append(line(label: "子串4", data: "hello".slice(begin: 1, len: 2)))

        self.views.append(line(label: "当期时间戳", data: MyDateUtil.getCurrentTimeStamp()))

        self.views.append(line(label: "当期毫秒时间戳", data: MyDateUtil.getCurrentMilliTimeStamp()))

        self.views.append(line(label: "当期日期", data: MyDateUtil.formatDate(Date())))
        self.views.append(line(label: "当期时间", data: MyDateUtil.formatTime(Date())))
        self.views.append(line(label: "当期日期时间", data: MyDateUtil.formatDateTime(Date())))

        self.views.append(line(label: "转化日期", data: MyDateUtil.formatDate(MyDateUtil.parseDate("2021-02-19")!)))
        self.views.append(line(label: "转化日期时间", data: MyDateUtil.formatDateTime(MyDateUtil.parseDateTime("2021-02-19 10:11:11")!)))

        self.views.append(line(label: "昨天此刻", data: MyDateUtil.formatDateTime(MyDateUtil.getYesterday())))
        self.views.append(line(label: "今天凌晨时间", data: MyDateUtil.formatDateTime(MyDateUtil.getStartOfDay(Date()))))
        self.views.append(line(label: "今天结束时间", data: MyDateUtil.formatDateTime(MyDateUtil.getEndOfDay(Date()))))

        self.views.append(line(label: "今天星期几", data: MyDateUtil.getWeekdayString(Date())))
        self.views.append(line(label: "本周一", data: MyDateUtil.formatDate(MyDateUtil.getFirstDayOfWeek(Date()))))
        self.views.append(line(label: "本周日", data: MyDateUtil.formatDate(MyDateUtil.getLastDayOfWeek(Date()))))
        self.views.append(line(label: "今年第几周", data: MyDateUtil.getWeekOfYear(Date())))


        self.views.append(line(label: "本月第一天", data: MyDateUtil.formatDateTime(MyDateUtil.getFirstDayOfMonth(Date()))))
        self.views.append(line(label: "本月最后一天", data: MyDateUtil.formatDateTime(MyDateUtil.getLastDayOfMonth(Date()))))


        self.views.append(line(label: "相隔多少天", data: MyDateUtil.betweenDay(MyDateUtil.parseDate("2021-02-02")!,MyDateUtil.parseDate("2021-02-08")!)))


        self.views.append(line(label: "时间优化显示1", data: MyDateUtil.getShowTime(MyDateUtil.parseDate("2021-08-01")!)))
        self.views.append(line(label: "时间优化显示2", data: MyDateUtil.getShowTime(MyDateUtil.parseDate("2021-08-02")!)))
        self.views.append(line(label: "时间优化显示3", data: MyDateUtil.getShowTime(MyDateUtil.parseDateTime("2021-08-04 20:33:00")!)))
        self.views.append(line(label: "时间优化显示4", data: MyDateUtil.getShowTime(MyDateUtil.parseDateTime("2021-07-04 20:33:00")!)))
        self.views.append(line(label: "时间优化显示5", data: MyDateUtil.getShowTime(MyDateUtil.parseDateTime("2021-09-04 20:33:00")!)))
        self.views.append(line(label: "时间优化显示6", data: MyDateUtil.getShowTime(MyDateUtil.gap(Date(), unit: .second, number: -10))))
        self.views.append(line(label: "时间优化显示7", data: MyDateUtil.getShowTime(MyDateUtil.gap(Date(), unit: .minute, number: -10))))
    }

    func line(label: String, data: Any) -> CellView {
        CellView(label: label, data: data)
    }

}

struct CellView: View {

    var label: String
    var data: Any
    var body: some View {
        VStack(spacing: 10){
            Text(String(describing: data)).font(.system(size: 20))
            Text(label).font(.system(size: 12)).foregroundColor(.gray.opacity(0.8))
        }.padding().frame(maxWidth: .infinity)
//                .background(LinearGradient(gradient: Gradient(colors: [.blue, .yellow]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(6)
    }
}