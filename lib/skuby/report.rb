module Skuby
  class Report

    STATUS_MAPPING = {
      'DELIVERED'     => 'Messaggio consegnato',
      'EXPIRED'       => 'Messaggio scaduto (telefono spento/non raggiungibile)',
      'DELETED'       => 'Errore rete operatore',
      'UNDELIVERABLE' => 'Messaggio non spedito (Vedi sotto variabile error_code)',
      'UNKNOWN'       => 'Errore generico',
      'REJECTD'       => 'Messaggio rifiutato dall\'operatore'
    }

    ERROR_CODES = {
      1   => 'Consegnato',
      401 => 'Messaggio scaduto (telefono spento/non raggiungibile)',
      201 => 'Malfunzionamento rete operatore',
      203 => 'Destinatario non raggiungibile (in roaming)',
      301 => 'Destinatario non valido (inesistente/in portabilita\' - non abilitato)',
      302 => 'Numero errato',
      303 => 'Servizio SMS non abilitato',
      304 => 'Testo riconosciuto come spam',
      501 => 'Telefono non supporta l\'SMS',
      502 => 'Telefono con memoria piena',
      901 => 'Mappatura errata del malfunzionamento',
      902 => 'Servizio temporaneamente non disponibile',
      903 => 'Nessun operatore disponibile',
      904 => 'Messaggio privo di testo',
      905 => 'Destinatario non valido',
      906 => 'Destinatari duplicati',
      907 => 'Compilazione messaggio non corretta',
      909 => 'User_reference non corretta',
      910 => 'Testo troppo lungo',
      101 => 'Malfunzionamento generico operatore',
      202 => 'Messaggio rifiutato dall\'operatore'
    }

    attr_reader :raw

    def initialize(params)
      @raw = params
    end

    def success?
      status == "DELIVERED"
    end

    def status
      @raw["status"]
    end

    def error_code
      @raw["error_code"].to_i
    end

    def error_message
      "#{STATUS_MAPPING[status]} - #{ERROR_CODES[error_code]}"
    end

    def message_id
      @raw["skebby_message_id"].to_i
    end

    def dispatch_id
      @raw["skebby_dispatch_id"]
    end

    def delivered_at
      Time.zone.parse(@raw["operator_date_time"])
    end

    def skebby_at
      Time.zone.parse(@raw["skebby_date_time"])
    end

    def recipient
      @raw["recipient"]
    end
  end
end
