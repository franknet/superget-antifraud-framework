// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSImage
  public typealias AssetColorTypeAlias = NSColor
  public typealias AssetImageTypeAlias = NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  public typealias AssetColorTypeAlias = UIColor
  public typealias AssetImageTypeAlias = UIImage
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum GPAssets {
  public static let gpAbout = ImageAsset(name: "gp_about")
  public static let gpAccessories = ImageAsset(name: "gp_accessories")
  public static let gpAccessoriesSmall = ImageAsset(name: "gp_accessories_small")
  public static let gpAccountReview = ImageAsset(name: "gp_account_review")
  public static let gpAlert = ImageAsset(name: "gp_alert")
  public static let gpArrowForward = ImageAsset(name: "gp_arrow_forward")
  public static let gpAvistaBig = ImageAsset(name: "gp_avista_big")
  public static let gpBack = ImageAsset(name: "gp_back")
  public static let gpBank = ImageAsset(name: "gp_bank")
  public static let gpBoletoBig = ImageAsset(name: "gp_boleto_big")
  public static let gpBuyCard = ImageAsset(name: "gp_buy_card")
  public static let gpCameraBoleto = ImageAsset(name: "gp_camera_boleto")
  public static let gpCardBig = ImageAsset(name: "gp_card_big")
  public static let gpCardBlocked = ImageAsset(name: "gp_card_blocked")
  public static let gpCardNew = ImageAsset(name: "gp_card_new")
  public static let gpChangePass = ImageAsset(name: "gp_change_pass")
  public static let gpCheck = ImageAsset(name: "gp_check")
  public static let gpClose = ImageAsset(name: "gp_close")
  public static let gpCnh = ImageAsset(name: "gp_cnh")
  public static let gpCnhBack = ImageAsset(name: "gp_cnh_back")
  public static let gpCnhCase = ImageAsset(name: "gp_cnh_case")
  public static let gpCnhDesk = ImageAsset(name: "gp_cnh_desk")
  public static let gpCnhReflex = ImageAsset(name: "gp_cnh_reflex")
  public static let gpContactNotFound = ImageAsset(name: "gp_contact_not_found")
  public static let gpCopy = ImageAsset(name: "gp_copy")
  public static let gpCrediarioBig = ImageAsset(name: "gp_crediario_big")
  public static let gpCreditoBig = ImageAsset(name: "gp_credito_big")
  public static let gpDebitoBig = ImageAsset(name: "gp_debito_big")
  public static let gpDocLamp = ImageAsset(name: "gp_doc_lamp")
  public static let gpDocRegistration = ImageAsset(name: "gp_doc_registration")
  public static let gpDocsAddress = ImageAsset(name: "gp_docs_address")
  public static let gpDown = ImageAsset(name: "gp_down")
  public static let gpDownloadQrcode = ImageAsset(name: "gp_download_qrcode")
  public static let gpEc = ImageAsset(name: "gp_ec")
  public static let gpEdit = ImageAsset(name: "gp_edit")
  public static let gpEmail = ImageAsset(name: "gp_email")
  public static let gpEmailSent = ImageAsset(name: "gp_email_sent")
  public static let gpEmissorBig = ImageAsset(name: "gp_emissor_big")
  public static let gpEmptyBusiness = ImageAsset(name: "gp_empty_business")
  public static let gpError = ImageAsset(name: "gp_error")
  public static let gpEstorno = ImageAsset(name: "gp_estorno")
  public static let gpExit = ImageAsset(name: "gp_exit")
  public static let gpExtractEmpty = ImageAsset(name: "gp_extract_empty")
  public static let gpExtrato = ImageAsset(name: "gp_extrato")
  public static let gpFaq = ImageAsset(name: "gp_faq")
  public static let gpFavorite = ImageAsset(name: "gp_favorite")
  public static let gpFileUpload = ImageAsset(name: "gp_file_upload")
  public static let gpFilter = ImageAsset(name: "gp_filter")
  public static let gpFingerprint = ImageAsset(name: "gp_fingerprint")
  public static let gpFingerprintAnimation = ImageAsset(name: "gp_fingerprint_animation")
  public static let gpFlash = ImageAsset(name: "gp_flash")
  public static let gpFlashOff = ImageAsset(name: "gp_flash_off")
  public static let gpFone = ImageAsset(name: "gp_fone")
  public static let gpHidePass = ImageAsset(name: "gp_hide_pass")
  public static let gpInicio = ImageAsset(name: "gp_inicio")
  public static let gpInsertCard = ImageAsset(name: "gp_insert_card")
  public static let gpLocked = ImageAsset(name: "gp_locked")
  public static let gpLockedBig = ImageAsset(name: "gp_locked_big")
  public static let gpMessage = ImageAsset(name: "gp_message")
  public static let gpMore = ImageAsset(name: "gp_more")
  public static let gpNotification = ImageAsset(name: "gp_notification")
  public static let gpPassword = ImageAsset(name: "gp_password")
  public static let gpPayBoleto = ImageAsset(name: "gp_pay_boleto")
  public static let gpPayQrcode = ImageAsset(name: "gp_pay_qrcode")
  public static let gpPayment = ImageAsset(name: "gp_payment")
  public static let gpPhotoBulb = ImageAsset(name: "gp_photo_bulb")
  public static let gpPhotoBulbSmall = ImageAsset(name: "gp_photo_bulb_small")
  public static let gpPhotoFace = ImageAsset(name: "gp_photo_face")
  public static let gpPhotoFaceSmall = ImageAsset(name: "gp_photo_face_small")
  public static let gpPlus = ImageAsset(name: "gp_plus")
  public static let gpRate = ImageAsset(name: "gp_rate")
  public static let gpReceipt = ImageAsset(name: "gp_receipt")
  public static let gpRecharge = ImageAsset(name: "gp_recharge")
  public static let gpRefresh = ImageAsset(name: "gp_refresh")
  public static let gpRegistrationComplete = ImageAsset(name: "gp_registration_complete")
  public static let gpRg = ImageAsset(name: "gp_rg")
  public static let gpRgBack = ImageAsset(name: "gp_rg_back")
  public static let gpRgCase = ImageAsset(name: "gp_rg_case")
  public static let gpRgDesk = ImageAsset(name: "gp_rg_desk")
  public static let gpSale = ImageAsset(name: "gp_sale")
  public static let gpSaleBoleto = ImageAsset(name: "gp_sale_boleto")
  public static let gpSaleLink = ImageAsset(name: "gp_sale_link")
  public static let gpSalePinpad = ImageAsset(name: "gp_sale_pinpad")
  public static let gpSaleQrcode = ImageAsset(name: "gp_sale_qrcode")
  public static let gpSales = ImageAsset(name: "gp_sales")
  public static let gpSearch = ImageAsset(name: "gp_search")
  public static let gpSelfie = ImageAsset(name: "gp_selfie")
  public static let gpSendDocs = ImageAsset(name: "gp_send_docs")
  public static let gpSettings = ImageAsset(name: "gp_settings")
  public static let gpShare = ImageAsset(name: "gp_share")
  public static let gpShowPass = ImageAsset(name: "gp_show_pass")
  public static let gpSucsess = ImageAsset(name: "gp_sucsess")
  public static let gpTransfer = ImageAsset(name: "gp_transfer")
  public static let gpTransferEndtime = ImageAsset(name: "gp_transfer_endtime")
  public static let gpTransferReceived = ImageAsset(name: "gp_transfer_received")
  public static let gpTransferSend = ImageAsset(name: "gp_transfer_send")
  public static let gpTransferenciaBig = ImageAsset(name: "gp_transferencia_big")
  public static let gpTypeBoleto = ImageAsset(name: "gp_type_boleto")
  public static let gpUnlocked = ImageAsset(name: "gp_unlocked")
  public static let gpUploadBoleto = ImageAsset(name: "gp_upload_boleto")
  public static let gpUserPermission = ImageAsset(name: "gp_user_permission")
  public static let gpVoucherBig = ImageAsset(name: "gp_voucher_big")
  public static let gpWallet = ImageAsset(name: "gp_wallet")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public struct ColorAsset {
  public fileprivate(set) var name: String

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  public var color: AssetColorTypeAlias {
    return AssetColorTypeAlias(asset: self)
  }
}

public extension AssetColorTypeAlias {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

public struct DataAsset {
  public fileprivate(set) var name: String

  #if os(iOS) || os(tvOS) || os(OSX)
  @available(iOS 9.0, tvOS 9.0, OSX 10.11, *)
  public var data: NSDataAsset {
    return NSDataAsset(asset: self)
  }
  #endif
}

#if os(iOS) || os(tvOS) || os(OSX)
@available(iOS 9.0, tvOS 9.0, OSX 10.11, *)
public extension NSDataAsset {
  convenience init!(asset: DataAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(name: asset.name, bundle: bundle)
    #elseif os(OSX)
    self.init(name: NSDataAsset.Name(asset.name), bundle: bundle)
    #endif
  }
}
#endif

public struct ImageAsset {
  public fileprivate(set) var name: String

  public var image: AssetImageTypeAlias {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    let image = AssetImageTypeAlias(named: name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = AssetImageTypeAlias(named: name)
    #endif
    guard let result = image else { fatalError("Unable to load image named \(name).") }
    return result
  }
}

public extension AssetImageTypeAlias {
  @available(iOS 1.0, tvOS 1.0, watchOS 1.0, *)
  @available(OSX, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = Bundle(for: BundleToken.self)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

private final class BundleToken {}
