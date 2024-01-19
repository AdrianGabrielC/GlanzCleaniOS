//
//  EmployeeStatsView.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 01.01.2024.
//

import SwiftUI
import Charts

struct EmployeeDataPoint: Identifiable {
    enum DataPointType: String {
        case net = "Net"
        case expenses = "Payment"

    }
    var id = UUID().uuidString
    var date: Date
    var revenue: Double
    var type: DataPointType
}
struct EmployeeStatsView: View {
    let stackColors: [AnyGradient] = [Color.green.gradient, Color.pink.gradient]
    @Environment(\.dismiss) var dismiss
    @State var showAlert = false
    @ObservedObject var serviceManager: ServiceManager = ServiceManager()
   
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Image("ProfileImg")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 100, maxHeight: 100)
                    VStack(alignment:.leading) {
                        Text("John Doe").font(.custom("Poppins-Bold", size: 24))
                        HStack {
                            Image(systemName: "envelope.fill")
                            Text("john@doe.com")
                        }
                        .font(.custom("Poppins-Bold", size: 14))
                        .tint(.gray)
                        .foregroundStyle(.gray)
                        HStack {
                            Image(systemName: "phone.fill")
                            Text("0750123456")
                        }
                        .font(.custom("Poppins-Bold", size: 14))
                        .foregroundStyle(.gray)
                    }
                    Spacer()
                }.padding(.bottom, 40)
                RevenueChart(dataPoints: generateRandomDataPoints()).padding(.bottom, 20)
               
            }
        }
        .scrollIndicators(.hidden)
        .padding()
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                Button {
                    dismiss()
                }label: {
                    HStack {
                        Image(systemName: "arrow.left.circle.fill").font(.title)
                        Text("Employee Statistics") .font(.custom("Poppins-Bold", size: 24))
                    }.foregroundColor(Color("MainYellow"))
                }
        )
    }
    
    
    @ViewBuilder
    func ChartItem(title:String, val:Double, currency:String = "$") -> some View {
        HStack {
            Text(title)
            Spacer()
            if currency == "%" {
                Text("**\(val, specifier: "%.2f")**\(currency)").foregroundStyle(Color(red: 200/255, green: 200/255, blue: 200/255))
            }
            else {
                Text("\(currency)**\(val, specifier: "%.0f")**").foregroundStyle(Color(red: 200/255, green: 200/255, blue: 200/255))
            }
        }.frame(width: 120)
    }
    
    @ViewBuilder
    func RevenueChart(dataPoints: [EmployeeDataPoint] ) -> some View {
        VStack(alignment:.leading) {
            Text("John Doe Revenue 2023").font(.custom("Poppins", size: 16)).bold()
            HStack(spacing: 0) {
                Text("Total: ")
                    .foregroundStyle(.secondary)
                Text("$\(dataPoints.reduce(0) {$0 + $1.revenue}, specifier: "%.0f")")
                    .foregroundStyle(.green)
            }.font(.custom("Poppins", size: 14))
            .fontWeight(.semibold)
            .font(.footnote)
            .padding(.bottom, 12)
            Chart {
                ForEach(dataPoints) { data in
                    BarMark(x:.value("", data.revenue)   ,
                            y: .value("", data.date, unit:.month))
                    .annotation(position:.overlay,content: {
                        Text("$\(data.revenue, specifier: "%.0f")")
                            .font(.custom("Poppins-Bold", size: 10))
                    })
                    .foregroundStyle(by: .value("Type", data.type.rawValue))
                }

            }
            .chartYAxis {
                AxisMarks(values: dataPoints.map {$0.date}) { date in
                    AxisValueLabel(format: .dateTime.month())
                }
            }
            .chartForegroundStyleScale(
                          range: stackColors
                      )//scale
            //.chartXScale(domain: 0...22000)
            .frame(height: 420)
            .font(.custom("Poppins", size: 12))
            .padding(.leading, 4)
            .padding(.bottom, 20)
            
            HStack {
                VStack(alignment:.leading) {
                    ChartItem(title: "Average:", val: dataPoints.reduce(0){$0 + $1.revenue} / Double(dataPoints.count))
                    ChartItem(title: "Peak:", val: dataPoints.max(by: {$0.revenue < $1.revenue})?.revenue ?? 0)
                    ChartItem(title: "Lowest:", val: dataPoints.min(by: {$0.revenue < $1.revenue && $0.revenue > 2000})?.revenue ?? 0)
                }.font(.custom("Poppins", size: 12)).foregroundStyle(.gray)
                Spacer()
                Rectangle().frame(width: 2).foregroundStyle(.gray)
                Spacer()
                VStack(alignment:.leading) {
                    ChartItem(title: "Total:", val: dataPoints.reduce(0){$0 + $1.revenue})
                    ChartItem(title: "AGR:", val: getAGR(dataPoints: dataPoints), currency: "%")
                    ChartItem(title: "MED:", val: getMedian(dataPoints: dataPoints))
                }.font(.custom("Poppins", size: 12)).foregroundStyle(.gray)
            }.frame(height: 50)
        }
    }
    func getMedian(dataPoints: [EmployeeDataPoint]) -> Double {
        let count = dataPoints.count
        let revenues = dataPoints.map { $0.revenue }
        let sorted = revenues.sorted()
        return sorted[count / 2]
    }
    func getAGR(dataPoints: [EmployeeDataPoint]) -> Double {
        let sortedByDate = dataPoints.sorted {$0.date < $1.date}
        if let first = sortedByDate.first?.revenue, let last = sortedByDate.last?.revenue {
            return ((last - first) / first) * 100
        }
        return 0
    }
    func generateRandomDataPoints() -> [EmployeeDataPoint] {
        var dataPoints = [EmployeeDataPoint]()

        let calendar = Calendar.current
        let currentDate = Date()

        for month in 1...12 {
            let date = calendar.date(from: DateComponents(year: 2024, month: month, day: 1))!


            let netDataPoint = EmployeeDataPoint(id: UUID().uuidString, date: date, revenue: Double.random(in: 2500...4000), type: .net)
            let expensesDataPoint = EmployeeDataPoint(id: UUID().uuidString, date: date, revenue: netDataPoint.revenue - (netDataPoint.revenue * 0.55), type: .expenses)

            dataPoints.append(contentsOf: [netDataPoint, expensesDataPoint])
        }

        return dataPoints
    }
}

#Preview {
    EmployeeStatsView(serviceManager: .init()).preferredColorScheme(.dark)
}
