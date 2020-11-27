// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum GPAssets {
  public static let gnBackspace = ImageAsset(name: "gn_backspace")
  public static let gnQrcodeExpired = ImageAsset(name: "gn_qrcode_expired")
  public static let gnQrcodeSkeleton = ImageAsset(name: "gn_qrcode_skeleton")
  public static let gpAbout = ImageAsset(name: "gp_about")
  public static let gpAccessories = ImageAsset(name: "gp_accessories")
  public static let gpAccessoriesSmall = ImageAsset(name: "gp_accessories_small")
  public static let gpAccountOpen = ImageAsset(name: "gp_account_open")
  public static let gpAccountReview = ImageAsset(name: "gp_account_review")
  public static let gpAlert = ImageAsset(name: "gp_alert")
  public static let gpArrowForward = ImageAsset(name: "gp_arrow_forward")
  public static let gpArrowForwardSmall = ImageAsset(name: "gp_arrow_forward_small")
  public static let gpAvistaBig = ImageAsset(name: "gp_avista_big")
  public static let gpBack = ImageAsset(name: "gp_back")
  public static let gpBank = ImageAsset(name: "gp_bank")
  public static let gpBoletoBg = ImageAsset(name: "gp_boleto_bg")
  public static let gpBoletoBig = ImageAsset(name: "gp_boleto_big")
  public static let gpBorderDoc = ImageAsset(name: "gp_border_doc")
  public static let gpBuyCard = ImageAsset(name: "gp_buy_card")
  public static let gpBvSymbol = ImageAsset(name: "gp_bv_symbol")
  public static let gpCameraBoleto = ImageAsset(name: "gp_camera_boleto")
  public static let gpCardBig = ImageAsset(name: "gp_card_big")
  public static let gpCardBlocked = ImageAsset(name: "gp_card_blocked")
  public static let gpCardCanceled = ImageAsset(name: "gp_card_canceled")
  public static let gpCardNew = ImageAsset(name: "gp_card_new")
  public static let gpCashIn = ImageAsset(name: "gp_cash_in")
  public static let gpCashOut = ImageAsset(name: "gp_cash_out")
  public static let gpChangePass = ImageAsset(name: "gp_change_pass")
  public static let gpChargeback2 = ImageAsset(name: "gp_chargeback_2")
  public static let gpChaveAleatoria = ImageAsset(name: "gp_chave_aleatoria")
  public static let gpChaveCel = ImageAsset(name: "gp_chave_cel")
  public static let gpChaveCpf = ImageAsset(name: "gp_chave_cpf")
  public static let gpCheck = ImageAsset(name: "gp_check")
  public static let gpClose = ImageAsset(name: "gp_close")
  public static let gpCnh = ImageAsset(name: "gp_cnh")
  public static let gpCnhBack = ImageAsset(name: "gp_cnh_back")
  public static let gpCnhCase = ImageAsset(name: "gp_cnh_case")
  public static let gpCnhDesk = ImageAsset(name: "gp_cnh_desk")
  public static let gpCnhFront = ImageAsset(name: "gp_cnh_front")
  public static let gpCnhReflex = ImageAsset(name: "gp_cnh_reflex")
  public static let gpCnhReflexSmall = ImageAsset(name: "gp_cnh_reflex_small")
  public static let gpContactNotFound = ImageAsset(name: "gp_contact_not_found")
  public static let gpCopy = ImageAsset(name: "gp_copy")
  public static let gpCrediarioBig = ImageAsset(name: "gp_crediario_big")
  public static let gpCreditoBig = ImageAsset(name: "gp_credito_big")
  public static let gpDebitoBig = ImageAsset(name: "gp_debito_big")
  public static let gpDeviceConnected = ImageAsset(name: "gp_device_connected")
  public static let gpDisabledAccount = ImageAsset(name: "gp_disabled_account")
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
  public static let gpEmojiAngry = ImageAsset(name: "gp_emoji_angry")
  public static let gpEmojiAngryUnselected = ImageAsset(name: "gp_emoji_angry_unselected")
  public static let gpEmojiHappy = ImageAsset(name: "gp_emoji_happy")
  public static let gpEmojiHappyUnselected = ImageAsset(name: "gp_emoji_happy_unselected")
  public static let gpEmojiLove = ImageAsset(name: "gp_emoji_love")
  public static let gpEmojiLoveUnselected = ImageAsset(name: "gp_emoji_love_unselected")
  public static let gpEmojiNeutral = ImageAsset(name: "gp_emoji_neutral")
  public static let gpEmojiNeutralUnselected = ImageAsset(name: "gp_emoji_neutral_unselected")
  public static let gpEmojiSad = ImageAsset(name: "gp_emoji_sad")
  public static let gpEmojiSadUnselected = ImageAsset(name: "gp_emoji_sad_unselected")
  public static let gpEmprestimo = ImageAsset(name: "gp_emprestimo")
  public static let gpEmptyBusiness = ImageAsset(name: "gp_empty_business")
  public static let gpEmptyChaves = ImageAsset(name: "gp_empty_chaves")
  public static let gpError = ImageAsset(name: "gp_error")
  public static let gpEstorno = ImageAsset(name: "gp_estorno")
  public static let gpExit = ImageAsset(name: "gp_exit")
  public static let gpExtractEmpty = ImageAsset(name: "gp_extract_empty")
  public static let gpExtrato = ImageAsset(name: "gp_extrato")
  public static let gpExtratoSelected = ImageAsset(name: "gp_extrato_selected")
  public static let gpFaq = ImageAsset(name: "gp_faq")
  public static let gpFavorite = ImageAsset(name: "gp_favorite")
  public static let gpFileUpload = ImageAsset(name: "gp_file_upload")
  public static let gpFilter = ImageAsset(name: "gp_filter")
  public static let gpFingerprint = ImageAsset(name: "gp_fingerprint")
  public static let gpFingerprintAnimation = ImageAsset(name: "gp_fingerprint_animation")
  public static let gpFlash = ImageAsset(name: "gp_flash")
  public static let gpFlashOff = ImageAsset(name: "gp_flash_off")
  public static let gpFone = ImageAsset(name: "gp_fone")
  public static let gpGetnetApp = ImageAsset(name: "gp_getnet_app")
  public static let gpGetnetAppShadow = ImageAsset(name: "gp_getnet_app_shadow")
  public static let gpHidePass = ImageAsset(name: "gp_hide_pass")
  public static let gpHome2Intro1 = ImageAsset(name: "gp_home_2_intro_1")
  public static let gpHome2Intro2 = ImageAsset(name: "gp_home_2_intro_2")
  public static let gpHomeIntro1 = ImageAsset(name: "gp_home_intro_1")
  public static let gpHomeIntro2 = ImageAsset(name: "gp_home_intro_2")
  public static let gpHomeIntro3 = ImageAsset(name: "gp_home_intro_3")
  public static let gpHomeIntro4 = ImageAsset(name: "gp_home_intro_4")
  public static let gpHomeIntro5 = ImageAsset(name: "gp_home_intro_5")
  public static let gpInicio = ImageAsset(name: "gp_inicio")
  public static let gpInicioSelected = ImageAsset(name: "gp_inicio_selected")
  public static let gpInsertCard = ImageAsset(name: "gp_insert_card")
  public static let gpLoan = ImageAsset(name: "gp_loan")
  public static let gpLocked = ImageAsset(name: "gp_locked")
  public static let gpLockedBig = ImageAsset(name: "gp_locked_big")
  public static let gpLoginBg = ImageAsset(name: "gp_login_bg")
  public static let gpLogoSuperget = ImageAsset(name: "gp_logo_superget")
  public static let gpMessage = ImageAsset(name: "gp_message")
  public static let gpMoney = ImageAsset(name: "gp_money")
  public static let gpMore = ImageAsset(name: "gp_more")
  public static let gpNotification = ImageAsset(name: "gp_notification")
  public static let gpPassword = ImageAsset(name: "gp_password")
  public static let gpPayBoleto = ImageAsset(name: "gp_pay_boleto")
  public static let gpPayCard = ImageAsset(name: "gp_pay_card")
  public static let gpPayQrcode = ImageAsset(name: "gp_pay_qrcode")
  public static let gpPayment = ImageAsset(name: "gp_payment")
  public static let gpPhonePending = ImageAsset(name: "gp_phone_pending")
  public static let gpPhotoBulb = ImageAsset(name: "gp_photo_bulb")
  public static let gpPhotoBulbSmall = ImageAsset(name: "gp_photo_bulb_small")
  public static let gpPhotoFace = ImageAsset(name: "gp_photo_face")
  public static let gpPhotoFaceSmall = ImageAsset(name: "gp_photo_face_small")
  public static let gpPix = ImageAsset(name: "gp_pix")
  public static let gpPixIntro = ImageAsset(name: "gp_pix_intro")
  public static let gpPixIntro2 = ImageAsset(name: "gp_pix_intro_2")
  public static let gpPixIntro3 = ImageAsset(name: "gp_pix_intro_3")
  public static let gpPixIntroKeysRegister = ImageAsset(name: "gp_pix_intro_keys_register")
  public static let gpPixIntroKeysType = ImageAsset(name: "gp_pix_intro_keys_type")
  public static let gpPlus = ImageAsset(name: "gp_plus")
  public static let gpQrcodeBg = ImageAsset(name: "gp_qrcode_bg")
  public static let gpRadio = ImageAsset(name: "gp_radio")
  public static let gpRadioSelected = ImageAsset(name: "gp_radio_selected")
  public static let gpRate = ImageAsset(name: "gp_rate")
  public static let gpReceipt = ImageAsset(name: "gp_receipt")
  public static let gpReceiptEnd = ImageAsset(name: "gp_receipt_end")
  public static let gpRecharge = ImageAsset(name: "gp_recharge")
  public static let gpRefresh = ImageAsset(name: "gp_refresh")
  public static let gpRegistrationComplete = ImageAsset(name: "gp_registration_complete")
  public static let gpRg = ImageAsset(name: "gp_rg")
  public static let gpRgBack = ImageAsset(name: "gp_rg_back")
  public static let gpRgCase = ImageAsset(name: "gp_rg_case")
  public static let gpRgDesk = ImageAsset(name: "gp_rg_desk")
  public static let gpRgFront = ImageAsset(name: "gp_rg_front")
  public static let gpRgReflexSmall = ImageAsset(name: "gp_rg_reflex_small")
  public static let gpSale = ImageAsset(name: "gp_sale")
  public static let gpSaleBoleto = ImageAsset(name: "gp_sale_boleto")
  public static let gpSaleLink = ImageAsset(name: "gp_sale_link")
  public static let gpSalePinpad = ImageAsset(name: "gp_sale_pinpad")
  public static let gpSaleQrcode = ImageAsset(name: "gp_sale_qrcode")
  public static let gpSaleSelected = ImageAsset(name: "gp_sale_selected")
  public static let gpSales = ImageAsset(name: "gp_sales")
  public static let gpSearch = ImageAsset(name: "gp_search")
  public static let gpSelfie = ImageAsset(name: "gp_selfie")
  public static let gpSelfieCamera = ImageAsset(name: "gp_selfie_camera")
  public static let gpSendDocs = ImageAsset(name: "gp_send_docs")
  public static let gpServices = ImageAsset(name: "gp_services")
  public static let gpServicesSelected = ImageAsset(name: "gp_services_selected")
  public static let gpSettings = ImageAsset(name: "gp_settings")
  public static let gpShare = ImageAsset(name: "gp_share")
  public static let gpShowPass = ImageAsset(name: "gp_show_pass")
  public static let gpStar = ImageAsset(name: "gp_star")
  public static let gpSucsess = ImageAsset(name: "gp_sucsess")
  public static let gpTakePictureButton = ImageAsset(name: "gp_take_picture_button")
  public static let gpTarifa = ImageAsset(name: "gp_tarifa")
  public static let gpTicket = ImageAsset(name: "gp_ticket")
  public static let gpTransactionError = ImageAsset(name: "gp_transaction_error")
  public static let gpTransfer = ImageAsset(name: "gp_transfer")
  public static let gpTransferBg = ImageAsset(name: "gp_transfer_bg")
  public static let gpTransferEndtime = ImageAsset(name: "gp_transfer_endtime")
  public static let gpTransferReceived = ImageAsset(name: "gp_transfer_received")
  public static let gpTransferSend = ImageAsset(name: "gp_transfer_send")
  public static let gpTransferenciaBig = ImageAsset(name: "gp_transferencia_big")
  public static let gpTrash = ImageAsset(name: "gp_trash")
  public static let gpTypeBoleto = ImageAsset(name: "gp_type_boleto")
  public static let gpUnlocked = ImageAsset(name: "gp_unlocked")
  public static let gpUploadBoleto = ImageAsset(name: "gp_upload_boleto")
  public static let gpUserPermission = ImageAsset(name: "gp_user_permission")
  public static let gpVoucherBig = ImageAsset(name: "gp_voucher_big")
  public static let gpWallet = ImageAsset(name: "gp_wallet")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public struct ImageAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image named \(name).")
    }
    return result
  }
}

public extension ImageAsset.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
