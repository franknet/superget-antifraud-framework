import UIKit

public enum GPTrasactionType: String, Codable {
    case PAYMENT_ACCOUNTS_CTA
    case TRANSITORY_CREDIT_PAYMENTS_ACCOUNTS_CTA
    case UNPROCESSED_PAYMENT_REC_CELL_CTA
    case ENTRANCE_BANK_TRANSFER_RECEIVED_CTA
    case RECHARGE_DEPOSIT_CTA
    case TRANSITORY_DEBIT_TRANSFER_BANK_CTA
    case BANK_TRANSFER_FEE_ENTRANCE_CTA
    case TRANSITORY_DEBT_RECEIVABLES_CTA
    case REVERSAL_DEPOSIT_BANK_SLIP_CTA
    case FINANCIAL_CREDIT_ACCOUNTS_CTA
    case REVERSAL_FEE_TRANSFERS_SENT_CTA
    case UNPROCESSED_PAYMENT_ACCOUNT_CTA
    case LIQ_FINANCY_TRANSFER_BANK_CTA
    case TRANSFER_BETWEEN_ACCOUNTS_FAVORED_CTA
    case TRANSITIONAL_DEBT_TRANSITION_ACCOUNT_CTA
    case BANK_TRANSFER_ENTRANCE_CTA
    case ACCOUNT_RECEIVABLES_DEBT_CTA
    case LOW_BANK_TRANSFER_RECEIVED_CTA
    case TRANSITORY_DEBIT_PAYMENTS_ACCOUNT_CTA
    case ADJUST_DEBIT_BACKOFFICE_CTA
    case TRANSITORY_CREDIT_TRANSFER_BANK_CTA
    case BANK_TRANSFER_CHARGEBACK_SENT_CTA
    case RATE_REC_DEPOSIT_BANK_SLIP_CTA
    case BANK_TRANSFER_RECEIVED_CTA
    case REFILL_SP_TRANSFER_CTA
    case RECEIVED_CTA
    case LIQ_FINANCY_DEBT_BANK_TRANSFER_CTA
    case UNPROCESSED_PAYMENT_REC_SP_TRANS_CTA
    case TRANSFER_BETWEEN_ACCOUNTS_SENDER_CTA
    case TRANSITORY_CREDIT_TRANSFER_ACCOUNTS_CTA
    case TRANSITORY_CREDIT_RECEIVABLES_CTA
    case ACCOUNT_RECEIVABLES_CREDIT_CTA
    case ADJUSTING_CREDIT_BACKOFFICE_CTA
    case MOBILE_TOP_UP_CTA
    case REFUND_RATE_REC_DEPOSIT_BANK_SPLIT_CTA
    case PIX_RECEIVED_TRANSACTIONAL_ACCOUNT
    case PIX_SENT_TRANSACTIONAL_ACCOUNT
    case PIX_FEE_SENT
    case PIX_CREDIT_FEE_RECEIVED
    case TRANSITIONAL_ACCOUNT_PIX_SENT_UNPROCESSED
    case PIX_DEBIT_FEE_CHARGE_SENT
    case PIX_SENT_FEE_UNPROCESSED
    case PIX_RECEIVED_FEE
    case PIX_DEBIT_FEE_CHARGE_RECEIVED
    case PIX_RECEIVED_NOT_PROCESSED_TRANSACTIONAL_ACCOUNT
    case PIX_FEE_RECEIVED_NOT_PROCESSED
    case PIX_RETURN_TRANSACTION_TRANSACTIONAL_ACCOUNT
    case PIX_RETURN_UNPROCESSED_TRANSACTIONAL_ACCOUNT
    case MOBILE_REVERSAL_CTA
    case CHARGEBACK_PAYMENT_ACCOUNTS
    case BILLS_PAYMENT_RATE
    case CHARGEBACK_RATE_PAYMENT_ACCOUNTS
    case UNKNOWN
    
    public var title: String {
        switch self {
        case .PAYMENT_ACCOUNTS_CTA:
            return "Pagamento de boleto"
            
        case .TRANSITORY_CREDIT_PAYMENTS_ACCOUNTS_CTA:
            return ""
            
        case .UNPROCESSED_PAYMENT_REC_CELL_CTA:
            return "Recarga de celular pendente"
            
        case .ENTRANCE_BANK_TRANSFER_RECEIVED_CTA:
            return "Transferência realizada"
            
        case .RECHARGE_DEPOSIT_CTA:
            return "Depósito boleto recebido"
            
        case .TRANSITORY_DEBIT_TRANSFER_BANK_CTA:
            return ""
            
        case .BANK_TRANSFER_FEE_ENTRANCE_CTA:
            return "Tarifa TED"
            
        case .TRANSITORY_DEBT_RECEIVABLES_CTA:
            return ""
            
        case .REVERSAL_DEPOSIT_BANK_SLIP_CTA:
            return ""
            
        case .FINANCIAL_CREDIT_ACCOUNTS_CTA:
            return ""
            
        case .REVERSAL_FEE_TRANSFERS_SENT_CTA:
            return "Estorno tarifa TED"
            
        case .UNPROCESSED_PAYMENT_ACCOUNT_CTA:
            return "Pagamento não realizado"
            
        case .LIQ_FINANCY_TRANSFER_BANK_CTA:
            return ""
            
        case .TRANSFER_BETWEEN_ACCOUNTS_FAVORED_CTA:
            return "Transferência recebida"
            
        case .TRANSITIONAL_DEBT_TRANSITION_ACCOUNT_CTA:
            return ""
            
        case .BANK_TRANSFER_ENTRANCE_CTA:
            return "TED enviada"
            
        case .ACCOUNT_RECEIVABLES_DEBT_CTA:
            return ""
            
        case .LOW_BANK_TRANSFER_RECEIVED_CTA:
            return "Duplicidade de Recebíveis"
            
        case .TRANSITORY_DEBIT_PAYMENTS_ACCOUNT_CTA:
            return ""
            
        case .ADJUST_DEBIT_BACKOFFICE_CTA:
            return "Ajuste de conta"
            
        case .TRANSITORY_CREDIT_TRANSFER_BANK_CTA:
            return ""
            
        case .BANK_TRANSFER_CHARGEBACK_SENT_CTA:
            return "Estorno TED"
            
        case .RATE_REC_DEPOSIT_BANK_SLIP_CTA:
            return "Tarifa boleto"
            
        case .BANK_TRANSFER_RECEIVED_CTA:
            return "Transferência recebida"
            
        case .REFILL_SP_TRANSFER_CTA:
            return "Recarga bilhete único"
            
        case .RECEIVED_CTA:
            return "Venda realizada"
            
        case .LIQ_FINANCY_DEBT_BANK_TRANSFER_CTA:
            return ""
            
        case .UNPROCESSED_PAYMENT_REC_SP_TRANS_CTA:
            return "Pagamento não realizado"
            
        case .TRANSFER_BETWEEN_ACCOUNTS_SENDER_CTA:
            return "Transferência enviada"
            
        case .TRANSITORY_CREDIT_TRANSFER_ACCOUNTS_CTA:
            return ""
            
        case .TRANSITORY_CREDIT_RECEIVABLES_CTA:
            return ""
            
        case .ACCOUNT_RECEIVABLES_CREDIT_CTA:
            return ""
            
        case .ADJUSTING_CREDIT_BACKOFFICE_CTA:
            return "Ajuste de conta"
            
        case .MOBILE_TOP_UP_CTA:
            return "Recarga de celular"
            
        case .REFUND_RATE_REC_DEPOSIT_BANK_SPLIT_CTA:
            return "Estorno tarifa boleto"
        case .PIX_RECEIVED_TRANSACTIONAL_ACCOUNT:
            return ""
            
        case .PIX_SENT_TRANSACTIONAL_ACCOUNT:
            return ""
            
        case .PIX_FEE_SENT:
            return ""
            
        case .PIX_CREDIT_FEE_RECEIVED:
            return ""
            
        case .TRANSITIONAL_ACCOUNT_PIX_SENT_UNPROCESSED:
            return ""
            
        case .PIX_DEBIT_FEE_CHARGE_SENT:
            return ""
            
        case .PIX_SENT_FEE_UNPROCESSED:
            return ""
            
        case .PIX_RECEIVED_FEE:
            return ""
            
        case .PIX_DEBIT_FEE_CHARGE_RECEIVED:
            return ""
            
        case .PIX_RECEIVED_NOT_PROCESSED_TRANSACTIONAL_ACCOUNT:
            return ""
            
        case .PIX_FEE_RECEIVED_NOT_PROCESSED:
            return ""
            
        case .PIX_RETURN_TRANSACTION_TRANSACTIONAL_ACCOUNT:
            return ""
            
        case .PIX_RETURN_UNPROCESSED_TRANSACTIONAL_ACCOUNT:
            return ""
            
        case .MOBILE_REVERSAL_CTA:
            return ""
            
        case .CHARGEBACK_PAYMENT_ACCOUNTS:
            return ""
            
        case .BILLS_PAYMENT_RATE:
            return ""
            
        case .CHARGEBACK_RATE_PAYMENT_ACCOUNTS:
            return ""
            
        case .UNKNOWN:
            return ""
            
        }
    }
    
    public var icon: UIImage {
        switch self {
        case .PAYMENT_ACCOUNTS_CTA:
            return GPAssets.gpPayBoleto.image
            
        case .TRANSITORY_CREDIT_PAYMENTS_ACCOUNTS_CTA:
            return GPAssets.gpMoney.image
            
        case .UNPROCESSED_PAYMENT_REC_CELL_CTA:
            return GPAssets.gpPhonePending.image
            
        case .ENTRANCE_BANK_TRANSFER_RECEIVED_CTA:
            return GPAssets.gpCashIn.image
            
        case .RECHARGE_DEPOSIT_CTA:
            return GPAssets.gpSaleBoleto.image
            
        case .TRANSITORY_DEBIT_TRANSFER_BANK_CTA:
            return GPAssets.gpMoney.image
            
        case .BANK_TRANSFER_FEE_ENTRANCE_CTA:
            return GPAssets.gpTarifa.image
            
        case .TRANSITORY_DEBT_RECEIVABLES_CTA:
            return GPAssets.gpMoney.image
            
        case .REVERSAL_DEPOSIT_BANK_SLIP_CTA:
            return GPAssets.gpChargeback2.image
            
        case .FINANCIAL_CREDIT_ACCOUNTS_CTA:
            return GPAssets.gpMoney.image
            
        case .REVERSAL_FEE_TRANSFERS_SENT_CTA:
            return GPAssets.gpChargeback2.image
            
        case .UNPROCESSED_PAYMENT_ACCOUNT_CTA:
            return GPAssets.gpTransactionError.image
            
        case .LIQ_FINANCY_TRANSFER_BANK_CTA:
            return GPAssets.gpMoney.image
            
        case .TRANSFER_BETWEEN_ACCOUNTS_FAVORED_CTA:
            return GPAssets.gpCashIn.image
            
        case .TRANSITIONAL_DEBT_TRANSITION_ACCOUNT_CTA:
            return GPAssets.gpMoney.image
            
        case .BANK_TRANSFER_ENTRANCE_CTA:
            return GPAssets.gpCashOut.image
            
        case .ACCOUNT_RECEIVABLES_DEBT_CTA:
            return GPAssets.gpCashIn.image
            
        case .LOW_BANK_TRANSFER_RECEIVED_CTA:
            return GPAssets.gpTransactionError.image
            
        case .TRANSITORY_DEBIT_PAYMENTS_ACCOUNT_CTA:
            return GPAssets.gpMoney.image
            
        case .ADJUST_DEBIT_BACKOFFICE_CTA:
            return GPAssets.gpMoney.image
            
        case .TRANSITORY_CREDIT_TRANSFER_BANK_CTA:
            return GPAssets.gpMoney.image
            
        case .BANK_TRANSFER_CHARGEBACK_SENT_CTA:
            return GPAssets.gpChargeback2.image
            
        case .RATE_REC_DEPOSIT_BANK_SLIP_CTA:
            return GPAssets.gpTarifa.image
            
        case .BANK_TRANSFER_RECEIVED_CTA:
            return GPAssets.gpCashIn.image
            
        case .REFILL_SP_TRANSFER_CTA:
            return GPAssets.gpTicket.image
            
        case .RECEIVED_CTA:
            return GPAssets.gpMoney.image
            
        case .LIQ_FINANCY_DEBT_BANK_TRANSFER_CTA:
            return GPAssets.gpMoney.image
            
        case .UNPROCESSED_PAYMENT_REC_SP_TRANS_CTA:
            return GPAssets.gpTransactionError.image
            
        case .TRANSFER_BETWEEN_ACCOUNTS_SENDER_CTA:
            return GPAssets.gpCashOut.image
            
        case .TRANSITORY_CREDIT_TRANSFER_ACCOUNTS_CTA:
            return GPAssets.gpMoney.image
            
        case .TRANSITORY_CREDIT_RECEIVABLES_CTA:
            return GPAssets.gpMoney.image
            
        case .ACCOUNT_RECEIVABLES_CREDIT_CTA:
            return GPAssets.gpMoney.image
            
        case .ADJUSTING_CREDIT_BACKOFFICE_CTA:
            return GPAssets.gpMoney.image
            
        case .MOBILE_TOP_UP_CTA:
            return GPAssets.gpRecharge.image
            
        case .REFUND_RATE_REC_DEPOSIT_BANK_SPLIT_CTA:
            return GPAssets.gpChargeback2.image
            
        case .UNKNOWN:
            return GPAssets.gpPayCard.image
            
        case .PIX_RECEIVED_TRANSACTIONAL_ACCOUNT:
            return GPAssets.gpPix.image
            
        case .PIX_SENT_TRANSACTIONAL_ACCOUNT:
            return GPAssets.gpPix.image
            
        case .PIX_FEE_SENT:
            return GPAssets.gpPix.image
            
        case .PIX_CREDIT_FEE_RECEIVED:
            return GPAssets.gpPix.image
            
        case .TRANSITIONAL_ACCOUNT_PIX_SENT_UNPROCESSED:
            return GPAssets.gpPix.image
            
        case .PIX_DEBIT_FEE_CHARGE_SENT:
            return GPAssets.gpPix.image
            
        case .PIX_SENT_FEE_UNPROCESSED:
            return GPAssets.gpPix.image
            
        case .PIX_RECEIVED_FEE:
            return GPAssets.gpPix.image
            
        case .PIX_DEBIT_FEE_CHARGE_RECEIVED:
            return GPAssets.gpPix.image
            
        case .PIX_RECEIVED_NOT_PROCESSED_TRANSACTIONAL_ACCOUNT:
            return GPAssets.gpPix.image
            
        case .PIX_FEE_RECEIVED_NOT_PROCESSED:
            return GPAssets.gpPix.image
            
        case .PIX_RETURN_TRANSACTION_TRANSACTIONAL_ACCOUNT:
            return GPAssets.gpPix.image
            
        case .PIX_RETURN_UNPROCESSED_TRANSACTIONAL_ACCOUNT:
            return GPAssets.gpPix.image
            
        default:
            return GPAssets.gpPayCard.image
        }
    }
}
