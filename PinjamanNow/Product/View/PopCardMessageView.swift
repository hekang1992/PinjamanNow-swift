//
//  PopCardMessageView.swift
//  PinjamanNow
//
//  Created by hekang on 2026/2/5.
//

import UIKit
import SnapKit
import BRPickerView

class PopCardMessageView: UIView {
    
    var cancelBlock: (() -> Void)?
    
    var sureBlock: (() -> Void)?
    
    let languageCode = LanguageManager.current
    
    var model: BaseModel? {
        didSet {
            guard let model = model else { return }
            oneView.enterFiled.text = model.record?.sy ?? ""
            twoView.enterFiled.text = model.record?.pylacity ?? ""
            threeView.enterFiled.text = model.record?.killature ?? ""
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "pu_cat_in_image")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var lockImageView: UIImageView = {
        let lockImageView = UIImageView()
        lockImageView.image = UIImage(named: "lock_bg_image")
        return lockImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.text = languageCode == .indonesian ? "Verifikasi Informasi Identitas" : "Verify Identity Information"
        nameLabel.textColor = UIColor.init(hexString: "#010204")
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return nameLabel
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textAlignment = .left
        descLabel.numberOfLines = 0
        descLabel.text = languageCode == .indonesian ? "*Mohon periksa kembali informasi KTP Anda dengan benar, jika sudah terkirim tidak akan diubah lagi" : "*Please check your lD information correctly, oncesubmitted it is not changed again"
        descLabel.textColor = UIColor.init(hexString: "#1370EE")
        descLabel.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        return descLabel
    }()
    
    lazy var oneView: CardMessageListView = {
        let oneView = CardMessageListView(frame: .zero)
        oneView.nameLabel.text = languageCode == .indonesian ? "Nama sesuai KTP" : "Real name"
        oneView.enterFiled.placeholder = languageCode == .indonesian ? "Nama sesuai KTP" : "Real name"
        return oneView
    }()
    
    lazy var twoView: CardMessageListView = {
        let twoView = CardMessageListView(frame: .zero)
        twoView.nameLabel.text = languageCode == .indonesian ? "Nomor KTP" : "ID number"
        twoView.enterFiled.placeholder = languageCode == .indonesian ? "Nomor KTP" : "ID number"
        return twoView
    }()
    
    lazy var threeView: CardMessageListView = {
        let threeView = CardMessageListView(frame: .zero)
        threeView.nameLabel.text = languageCode == .indonesian ? "Ulang tahun" : "Birthday"
        threeView.enterFiled.placeholder = languageCode == .indonesian ? "Ulang tahun" : "Birthday"
        threeView.arrowImageView.isHidden = false
        threeView.clickBtn.isHidden = false
        return threeView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    lazy var leftBtn: UIButton = {
        let leftBtn = UIButton(type: .custom)
        leftBtn.setTitle(languageCode == .indonesian ? "Membatalkan" : "Cancel", for: .normal)
        leftBtn.setTitleColor(UIColor.init(hexString: "#0956FB"), for: .normal)
        leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        leftBtn.layer.borderWidth = 1
        leftBtn.layer.borderColor = UIColor.init(hexString: "#0956FB")?.cgColor
        leftBtn.layer.cornerRadius = 22.pix()
        leftBtn.layer.masksToBounds = true
        leftBtn.addTarget(self, action: #selector(cancelClick), for: .touchUpInside)
        return leftBtn
    }()
    
    lazy var rightBtn: UIButton = {
        let rightBtn = UIButton(type: .custom)
        rightBtn.setTitle(languageCode == .indonesian ? "Mengonfirmasi" : "Confirm", for: .normal)
        rightBtn.setTitleColor(.white, for: .normal)
        rightBtn.backgroundColor = UIColor.init(hexString: "#0956FB")
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        rightBtn.layer.cornerRadius = 24.pix()
        rightBtn.layer.masksToBounds = true
        rightBtn.addTarget(self, action: #selector(sureClick), for: .touchUpInside)
        return rightBtn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        addSubview(lockImageView)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(descLabel)
        bgImageView.addSubview(scrollView)
        scrollView.addSubview(oneView)
        scrollView.addSubview(twoView)
        scrollView.addSubview(threeView)
        bgImageView.addSubview(leftBtn)
        bgImageView.addSubview(rightBtn)
        
        bgImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: 375.pix(), height: 484.pix()))
        }
        lockImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 73.pix(), height: 113.pix()))
            make.right.equalToSuperview().offset(-20.pix())
            make.top.equalTo(bgImageView.snp.top).offset(-10.pix())
        }
        nameLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(20)
            make.height.equalTo(16)
        }
        descLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.right.equalToSuperview().offset(-63.pix())
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom).offset(17)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-104.pix())
        }
        oneView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335.pix(), height: 88.pix()))
        }
        twoView.snp.makeConstraints { make in
            make.top.equalTo(oneView.snp.bottom).offset(15.pix())
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335.pix(), height: 88.pix()))
        }
        threeView.snp.makeConstraints { make in
            make.top.equalTo(twoView.snp.bottom).offset(15.pix())
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335.pix(), height: 88.pix()))
            make.bottom.equalToSuperview().offset(-20.pix())
        }
        leftBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-34.pix())
            make.left.equalToSuperview().offset(20.pix())
            make.size.equalTo(CGSize(width: 143.pix(), height: 48.pix()))
        }
        rightBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-34.pix())
            make.right.equalToSuperview().offset(-20.pix())
            make.size.equalTo(CGSize(width: 184.pix(), height: 48.pix()))
        }
        
        threeView.tapBlock = { [weak self] in
            guard let self = self else { return }
            self.endEditing(true)
            self.tapTimeClick(dateTx: threeView.enterFiled)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PopCardMessageView {
    
    @objc func cancelClick() {
        self.cancelBlock?()
    }
    
    @objc func sureClick() {
        self.sureBlock?()
    }
    
    private func tapTimeClick(dateTx: UITextField) {
        let selectedDate = DateParser.parseDate(from: dateTx.text, defaultDate: "01/01/1990")
        DatePickerPresenter.showDatePicker(for: dateTx, selectedDate: selectedDate)
    }

    private class DateParser {
        static func parseDate(from timeString: String?, defaultDate: String = "01/01/1990") -> Date {
            guard let timeString = timeString, !timeString.isEmpty else {
                return parseDate(from: defaultDate)
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            return dateFormatter.date(from: timeString) ?? parseDate(from: defaultDate)
        }
    }

    private class DatePickerPresenter {
        static func showDatePicker(for dateTx: UITextField, selectedDate: Date) {
            let datePickerView = BRDatePickerView()
            datePickerView.pickerMode = .YMD
            datePickerView.title = LanguageManager.current == .indonesian ? "Pemilihan Waktu" : "Time selection"
            datePickerView.selectDate = selectedDate
            datePickerView.pickerStyle = createPickerStyle()
            
            datePickerView.resultBlock = { selectedDate, _ in
                DateUpdater.updateTime(dateTx: dateTx, with: selectedDate)
            }
            
            datePickerView.show()
        }
        
        private static func createPickerStyle() -> BRPickerStyle {
            let style = BRPickerStyle()
            style.rowHeight = 45.pix()
            style.language = "en"
            style.doneBtnTitle = LanguageManager.current == .indonesian ? "OKE" : "OK"
            style.cancelBtnTitle = LanguageManager.current == .indonesian ? "Batal" : "Cancel"
            style.doneTextColor = UIColor(hexString: "#010204")
            style.selectRowTextColor = UIColor(hexString: "#010204")
            style.pickerTextFont = UIFont.systemFont(ofSize: 14.pix(), weight: .bold)
            style.selectRowTextFont = UIFont.systemFont(ofSize: 14.pix(), weight: .bold)
            return style
        }
    }

    private class DateUpdater {
        static func updateTime(dateTx: UITextField, with date: Date?) {
            guard let date = date else { return }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            dateTx.text = dateFormatter.string(from: date)
        }
    }
    
}
