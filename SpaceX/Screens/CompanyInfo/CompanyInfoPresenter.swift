//
//  CompanyInfoPresenter.swift
//  SpaceX
//
//  Created by Константин Маламуж on 23.11.2021.
//

import Foundation
import SpaceSDK


protocol CompanyInfoPresenterProtocol {
    func fetchCompanyInfo()
}


class CompanyInfoPresenter: CompanyInfoPresenterProtocol {
    
    let service: RocketServiceProtocol
    weak var viewController: CompanyInfoViewController?
    
    
    //MARK: - Fetching Data
    func fetchCompanyInfo() {
        service.fetchCompanyInfo { [weak self] result in
            switch result {
            case .failure(let error):
                self?.viewController?.showSimpleAlert(withTitle: "Error", message: error.localizedDescription)
            case .success(let company):
                let fields: [(key: String, value: String)] = [("Founder", company.founder),
                                                              ("CEO", company.ceo),
                                                              ("CTO", company.cto),
                                                              ("COO", company.coo),
                                                              ("Number of employees", "\(company.employees)")]
                self?.viewController?.updateUI(summary: company.summary, fields: fields)
            }
        }
    }
    
    //MARK: - Init
    init(service: RocketServiceProtocol, viewController: CompanyInfoViewController) {
        self.service = service
        self.viewController = viewController
    }
    
}
