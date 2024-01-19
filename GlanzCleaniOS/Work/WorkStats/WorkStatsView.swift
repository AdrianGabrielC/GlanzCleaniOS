//
//  WorkStatsView.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 01.01.2024.
//

import SwiftUI
import Charts


struct WorkDataPoint2: Identifiable {
    var id = UUID().uuidString
    var month: Date
    var revenue: Double
}

struct WorkDataPoint: Identifiable {
    enum DataPointType: String {
        case net = "Net"
        case expenses = "Expenses"
        case tax = "Tax"

    }
    var id = UUID().uuidString
    var date: Date
    var revenue: Double
    var type: DataPointType
}

struct WorkStatsView: View {
    let stackColors: [AnyGradient] = [Color.green.gradient, Color.yellow.gradient, Color.pink.gradient]
    @Environment(\.dismiss) var dismiss

    var body: some View {
        
        ScrollView {
            VStack(alignment:.leading) {
                RevenueChart(dataPoints: generateRandomDataPoints()).padding(.bottom, 40)
                NetChart(dataPoints: createDummyDataForNetChart()).padding(.bottom, 40)
                AllYearsRevenueChart(dataPoints: createDummyDataForAllYearsRevenueChart())
                Spacer()
            }
        }
        .scrollIndicators(.hidden)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                Button {
                    dismiss()
                }label: {
                    HStack {
                        Image(systemName: "arrow.left.circle.fill").font(.title)
                        Text("GlanzClean Inc.").font(.custom("Poppins-Bold", size: 24))
                    }.foregroundColor(Color("MainYellow"))
                }
        )
        .padding()
    }
    
    @ViewBuilder
    func AllYearsRevenueChart(dataPoints: [WorkDataPoint2]) -> some View {
        VStack(alignment:.leading) {
            Text("Revenue Over Time")
                .font(.custom("Poppins", size: 14))
                .bold()
                .foregroundStyle(Color(red: 200/255, green: 200/255, blue: 200/255))
            Chart {
                ForEach(dataPoints) { data in
                    BarMark(x: .value("Name", data.month, unit:.month),
                            y: .value("Sales", data.revenue))
                    .foregroundStyle(.gray)
                }
            }
            .frame(height: 40)
            .chartYAxis(.hidden)
            HStack {
                VStack(alignment:.leading) {
                    AllTimeRevenueChartItem(title: "Average:", val: dataPoints.reduce(0){$0 + $1.revenue} / Double(dataPoints.count))
                    AllTimeRevenueChartItem(title: "Peak:", val: dataPoints.max(by: {$0.revenue < $1.revenue})?.revenue ?? 0)
                    AllTimeRevenueChartItem(title: "Lowest:", val: dataPoints.min(by: {$0.revenue < $1.revenue && $0.revenue > 2000})?.revenue ?? 0)
                }.font(.custom("Poppins", size: 12)).foregroundStyle(.gray)
                Spacer()
                Rectangle().frame(width: 2).foregroundStyle(.gray)
                Spacer()
                VStack(alignment:.leading) {
                    AllTimeRevenueChartItem(title: "Total:", val: dataPoints.reduce(0){$0 + $1.revenue})
                    AllTimeRevenueChartItem(title: "AGR:", val: getAGR(dataPoints: dataPoints), currency: "%")
                    AllTimeRevenueChartItem(title: "MED:", val: getMedian(dataPoints: dataPoints))
                }.font(.custom("Poppins", size: 12)).foregroundStyle(.gray)
            }.frame(height: 50)
        }
    }
    
    @ViewBuilder
    func AllTimeRevenueChartItem(title:String, val:Double, currency: String = "$") -> some View {
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
    func NetChart(dataPoints: [WorkDataPoint2]) -> some View {
        VStack(alignment:.leading) {
            Text("Profit 2023").font(.custom("Poppins", size: 16)).bold()
            HStack(spacing: 5) {
                Text("Total:").foregroundStyle(.secondary)
                Text("$\(dataPoints.reduce(0){$0 + $1.revenue},specifier: "%.2f")").foregroundStyle(.green)
            }.font(.custom("Poppins", size: 14))
            .fontWeight(.semibold)
            .font(.footnote)
            .padding(.bottom, 12)
            Chart {
                ForEach(dataPoints) { data in
                    LineMark(x: .value("", data.month, unit:.month),
                            y: .value("", data.revenue))
                    .foregroundStyle(.green.gradient)
                    .shadow(color: .green, radius: 10, x: 0.0, y: 2)
                    .shadow(color: .green.opacity(0.8), radius: 10, x: 0.0, y: 5)
                    .shadow(color: .green.opacity(0.7), radius: 10, x: 0.0, y: 8)
                    .shadow(color: .green.opacity(0.5), radius: 10, x: 0.0, y: 12)
                }
            }.frame(height: 80)
        }
    }
    
    @ViewBuilder
    func RevenueChart(dataPoints: [WorkDataPoint]) -> some View {
        VStack(alignment:.leading) {
            Text("Revenue 2023").font(.custom("Poppins", size: 16)).bold()
            HStack(spacing: 0) {
                Text("Total: ")
                    .foregroundStyle(.secondary)
                Text("$\(dataPoints.reduce(0){$0 + $1.revenue}, specifier: "%.2f")")
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
                        Text(data.type == .tax ? "" : "$\(data.revenue, specifier: "%.0f")")
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
            //.chartXScale(domain: 0...dataPoints.max(by: {$0.revenue < $1.revenue})!.revenue + 10000)
            .frame(height: 420)
            .font(.custom("Poppins", size: 12))
            .padding(.leading, 4)
        }
    }
    

    func createDummyDataForAllYearsRevenueChart() -> [WorkDataPoint2] {
        // Create an array of WorkDataPoint2
        var workDataPoints: [WorkDataPoint2] = []

        // Generate data for each month over 5 years
        for yearIndex in 0..<5 {
            for monthIndex in 1...12 {
                let calendar = Calendar.current
                let currentYear = calendar.component(.year, from: Date())
                let year = (currentYear + yearIndex) - 6
                
                var components = DateComponents()
                components.year = year
                components.month = monthIndex
                components.day = 1
                
                // Create the first day of the month
                guard let monthDate = calendar.date(from: components) else {
                    fatalError("Error creating date for month \(monthIndex) of year \(year)")
                }
                
                // Generate a random revenue between 10,000 and 30,000
                let randomRevenue = Double.random(in: 25000.0...50000.0)
                
                // Create a WorkDataPoint2 and add it to the array
                let dataPoint = WorkDataPoint2(month: monthDate, revenue: randomRevenue)
                workDataPoints.append(dataPoint)
            }
        }
        return workDataPoints
    }
    func createDummyDataForNetChart() -> [WorkDataPoint2] {
        // Create an array of WorkDataPoint2
        var workDataPoints: [WorkDataPoint2] = []

        // Generate 12 months starting from January
        for monthIndex in 1...12 {
            let calendar = Calendar.current
            let year = calendar.component(.year, from: Date())
            
            var components = DateComponents()
            components.year = year
            components.month = monthIndex
            components.day = 1
            
            // Create the first day of the month
            guard let monthDate = calendar.date(from: components) else {
                fatalError("Error creating date for month \(monthIndex)")
            }
            
            // Generate a random revenue between 10,000 and 30,000
            let randomRevenue = Int.random(in: 15000...25000)
            
            // Create a WorkDataPoint2 and add it to the array
            let dataPoint = WorkDataPoint2(month: monthDate, revenue: Double(randomRevenue))
            workDataPoints.append(dataPoint)
        }
        
        return workDataPoints
    }
    
    func generateRandomDataPoints() -> [WorkDataPoint] {
        var dataPoints = [WorkDataPoint]()

        let calendar = Calendar.current
        let currentDate = Date()

        for month in 1...12 {
            let date = calendar.date(from: DateComponents(year: 2024, month: month, day: 1))!


            let netDataPoint = WorkDataPoint(id: UUID().uuidString, date: date, revenue: Double.random(in: 10000...25000), type: .net)
            let taxDataPoint = WorkDataPoint(id: UUID().uuidString, date: date, revenue: netDataPoint.revenue * 0.17, type: .tax)
            let expensesDataPoint = WorkDataPoint(id: UUID().uuidString, date: date, revenue: netDataPoint.revenue * 0.55, type: .expenses)

            dataPoints.append(contentsOf: [netDataPoint, expensesDataPoint,  taxDataPoint])
        }

        return dataPoints
    }
    
    func getMedian(dataPoints: [WorkDataPoint2]) -> Double {
        let count = dataPoints.count
        let revenues = dataPoints.map { $0.revenue }
        let sorted = revenues.sorted()
        return sorted[count / 2]
    }
    func getAGR(dataPoints: [WorkDataPoint2]) -> Double {
        let sortedByDate = dataPoints.sorted {$0.month < $1.month}
        if let first = sortedByDate.first?.revenue, let last = sortedByDate.last?.revenue {
            return ((last - first) / first) * 100
        }
        return 0
    }
}

#Preview {
    WorkStatsView().preferredColorScheme(.dark)
}
