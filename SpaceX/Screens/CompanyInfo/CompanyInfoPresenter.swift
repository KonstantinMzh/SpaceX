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
    
    let service: SpaceServiceProtocol
    weak var viewController: CompanyInfoViewController?
    
    
    //MARK: - Fetching Data
    func fetchCompanyInfo() {
        service.fetchCompanyInfo { [weak self] result in
            switch result {
            case .failure(let error):
                self?.viewController?.showSimpleAlert(withTitle: "Error", message: error.localizedDescription)
            case .success(let company):
                self?.viewController?.updateUI(company: company)
            }
        }
    }
    
    //MARK: - Init
    init(service: SpaceServiceProtocol, viewController: CompanyInfoViewController) {
        self.service = service
        self.viewController = viewController
    }
    
}
