//
//  FacilityService.swift
//  GlanzCleaniOS
//
//  Created by Adrian Gabriel Chiper on 19.01.2024.
//

import Foundation

class FacilityService {
    func getFacilities(page: Int, pageSize: Int) async -> APIResponse<GET.Facility> {
        guard let response: [GET.Facility] = try? await APIRequest.request(apiRouter: .getFacilities(page: page, pageSize: pageSize)) else { return APIResponse(status: .Failure, message: "Failed to retrieve facilities", data: nil) }
        return APIResponse(status: .Success, message: "Facilities successfully retrieved", data: response)
    }

    func getFacilitiesById(facilityId: String) async -> APIResponse<GET.Facility> {
        guard let response: GET.Facility = try? await APIRequest.request(apiRouter: .getFacilityById(facilityId: facilityId)) else { return APIResponse(status: .Failure, message: "Failed to retrieve facility", data: nil) }
        return APIResponse(status: .Success, message: "Facility successfully retrieved", data: [response])
    }

    func createFacility(facility: POST.Facility) async -> APIResponse<POST.Facility> {
        do {
            guard let data: POST.Facility = try await APIRequest.request(apiRouter: .createFacility(facility: facility)) else { return APIResponse(status: .Success, message: "Facility successfully created!", data: nil) } // Created but not returned from API
            return APIResponse(status: .Success, message: "Facility successfully created!", data: [data]) // Created and returned from API
        } catch {
            return APIResponse(status: .Failure, message: "Failed to create facility", data: nil) // Failed to create in API
        }
    }

    func editFacility(facilityId: String, facility: PUT.Facility) async -> APIResponse<PUT.Facility> {
        do {
            guard let data: PUT.Facility = try await APIRequest.request(apiRouter: .editFacility(facilityId: facilityId, facility: facility)) else { return APIResponse(status: .Success, message: "Facility successfully edited!", data: nil) } // Created but not returned from API
            return APIResponse(status: .Success, message: "Facility successfully created!", data: [data]) // Created and returned from API
        } catch {
            return APIResponse(status: .Failure, message: "Failed to edit facility", data: nil) // Failed to create in API
        }
    }

}
