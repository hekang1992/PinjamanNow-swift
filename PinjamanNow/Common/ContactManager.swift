//
//  ContactManager.swift
//  PinjamanNow
//
//  Created by Ethan Hayes on 2026/2/5.
//

import UIKit
import Contacts
import ContactsUI

struct ContactModel: Codable {
    var tryatory: String
    var sy: String
    
    init(name: String, phoneNumbers: [String]) {
        self.sy = name
        self.tryatory = phoneNumbers.joined(separator: ",")
    }
}

class ContactManager: NSObject {
    
    static let shared = ContactManager()
    private let contactStore = CNContactStore()
    private var completionHandler: (([ContactModel]) -> Void)?
    private weak var viewController: UIViewController?
    
    private func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        let status = CNContactStore.authorizationStatus(for: .contacts)
        
        switch status {
        case .authorized:
            completion(true, nil)
        case .notDetermined:
            contactStore.requestAccess(for: .contacts) { granted, error in
                DispatchQueue.main.async {
                    completion(granted, error)
                }
            }
        case .restricted, .denied:
            completion(false, nil)
            
        case .limited:
            completion(true, nil)
            
        @unknown default:
            completion(false, nil)
        }
    }
    
    func getAllContacts(completion: @escaping ([ContactModel]) -> Void) {
        requestAuthorization { [weak self] granted, error in
            guard let self = self else { return }
            
            if granted {
                self.fetchAllContacts(completion: completion)
            } else {
                self.showPermissionAlert()
                completion([])
            }
        }
    }
    
    func pickSingleContact(from viewController: UIViewController, completion: @escaping (ContactModel?) -> Void) {
        self.viewController = viewController
        self.completionHandler = { contacts in
            completion(contacts.first)
        }
        
        requestAuthorization { [weak self] granted, error in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if granted {
                    self.presentContactPicker()
                } else {
                    self.showPermissionAlert()
//                    completion(nil)
                }
            }
        }
    }
    
    private func fetchAllContacts(completion: @escaping ([ContactModel]) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            var contacts = [ContactModel]()
            let keysToFetch = [
                CNContactGivenNameKey as CNKeyDescriptor,
                CNContactFamilyNameKey as CNKeyDescriptor,
                CNContactPhoneNumbersKey as CNKeyDescriptor
            ]
            
            let request = CNContactFetchRequest(keysToFetch: keysToFetch)
            
            do {
                try self.contactStore.enumerateContacts(with: request) { contact, stop in
                    let name = self.formatName(givenName: contact.givenName, familyName: contact.familyName)
                    let phoneNumbers = self.extractPhoneNumbers(from: contact.phoneNumbers)
                    
                    if !phoneNumbers.isEmpty {
                        let contactModel = ContactModel(name: name, phoneNumbers: phoneNumbers)
                        contacts.append(contactModel)
                    }
                }
                
                DispatchQueue.main.async {
                    completion(contacts)
                }
            } catch {
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }
    }
    
    private func formatName(givenName: String, familyName: String) -> String {
        var nameComponents = [String]()
        if !familyName.isEmpty {
            nameComponents.append(familyName)
        }
        if !givenName.isEmpty {
            nameComponents.append(givenName)
        }
        return nameComponents.joined(separator: " ")
    }
    
    private func extractPhoneNumbers(from phoneNumberObjects: [CNLabeledValue<CNPhoneNumber>]) -> [String] {
        var phoneNumbers = [String]()
        
        for phoneNumber in phoneNumberObjects {
            let numberString = phoneNumber.value.stringValue
            let cleanedNumber = self.cleanPhoneNumber(numberString)
            
            if !cleanedNumber.isEmpty {
                phoneNumbers.append(cleanedNumber)
            }
        }
        
        return phoneNumbers
    }
    
    private func cleanPhoneNumber(_ phoneNumber: String) -> String {
        var cleaned = ""
        for char in phoneNumber {
            if char.isNumber || char == "+" {
                cleaned.append(char)
            }
        }
        return cleaned
    }
    
    private func showPermissionAlert() {
        let alert = UIAlertController(
            title: LanguageManager.current == .indonesian ? "Izin akses kontak" : "Contacts Permission",
            message: LanguageManager.current == .indonesian ? "Izin kontak digunakan untuk verifikasi identitas dan pencegahan penipuan. Tinjauan akan tertunda jika tidak diaktifkan. Silakan pergi ke Pengaturan untuk memberikan otorisasi." : "Contacts permission is used for identity verification and fraud prevention. The review will be delayed if it is not enabled. Please go to Settings to authorize it.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: LanguageManager.current == .indonesian ? "Batalkan" : "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: LanguageManager.current == .indonesian ? "Masuk ke Pengaturan" : "Go to Settings", style: .default) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        })
        
        if let topVC = UIApplication.shared.keyWindow?.rootViewController {
            topVC.present(alert, animated: true)
        }
    }
}

extension ContactManager: CNContactPickerDelegate {
    
    private func presentContactPicker() {
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        contactPicker.displayedPropertyKeys = [CNContactPhoneNumbersKey]
        
        viewController?.present(contactPicker, animated: true)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let name = formatName(givenName: contact.givenName, familyName: contact.familyName)
        
        var phoneNumbers = [String]()
        if let firstPhoneNumber = contact.phoneNumbers.first {
            let numberString = firstPhoneNumber.value.stringValue
            let cleanedNumber = cleanPhoneNumber(numberString)
            if !cleanedNumber.isEmpty {
                phoneNumbers.append(cleanedNumber)
            }
        }
        
        let contactModel = ContactModel(name: name, phoneNumbers: phoneNumbers)
        completionHandler?([contactModel])
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        completionHandler?([])
    }
}

