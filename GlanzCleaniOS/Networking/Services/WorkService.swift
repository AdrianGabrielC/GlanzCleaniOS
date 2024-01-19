//
//  WorkService.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 01.01.2024.
//

import Foundation
class WorkService {
    func getWorks(page: Int, pageSize: Int, year: Int?, month: Int?, day: Int?) async -> APIResponse<GET.Work> {
        guard let response: [GET.Work] = try? await APIRequest.request(apiRouter: .getWork(page: page, pageSize: pageSize, year: year, month: month, day: day)) else { return APIResponse(status: .Failure, message: "Failed to retrieve works", data: nil) }
        return APIResponse(status: .Success, message: "Works successfully retrieved", data: response)
    }

    func getWorksById(workId: String) async -> APIResponse<GET.Work> {
        guard let response: GET.Work = try? await APIRequest.request(apiRouter: .getWorkById(workId: workId)) else { return APIResponse(status: .Failure, message: "Failed to retrieve work", data: nil) }
        return APIResponse(status: .Success, message: "Work successfully retrieved", data: [response])
    }

    func createWork(work: POST.Work) async -> APIResponse<POST.Work> {
        do {
            guard let data: POST.Work = try await APIRequest.request(apiRouter: .createWork(work: work)) else { return APIResponse(status: .Success, message: "Work successfully created!", data: nil) } // Created but not returned from API
            return APIResponse(status: .Success, message: "Work successfully created!", data: [data]) // Created and returned from API
        } catch {
            return APIResponse(status: .Failure, message: "Failed to create work", data: nil) // Failed to create in API
        }
    }

    func editWork(workId: String, work: PUT.Work) async -> APIResponse<PUT.Work> {
        do {
            guard let data: PUT.Work = try await APIRequest.request(apiRouter: .editWork(workId: workId, work: work)) else { return APIResponse(status: .Success, message: "Work successfully edited!", data: nil) } // Created but not returned from API
            return APIResponse(status: .Success, message: "Work successfully created!", data: [data]) // Created and returned from API
        } catch {
            return APIResponse(status: .Failure, message: "Failed to edit work", data: nil) // Failed to create in API
        }
    }

}
