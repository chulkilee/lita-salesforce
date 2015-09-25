require 'restforce'

module Lita
  module Handlers
    class Salesforce < Handler
      route(/salesforce (?<type>\S+) (?<id>\S+)/i,
            :show,
            command: true,
            help: { 'salesforce TYPE ID' => 'Shows detail of salesforce object' })

      config :fields_by_object, type: Hash
      config :type_alias, type: Hash

      DEFAULT_FIELDS_BY_OBJECT = {
        'account' => %w(Name Site Type Description Owner.Name),
        'contract' => %w(
          ContractNumber Status StartDate EndDate Description SpecialTerms
          Account.Id Account.Name Owner.Name),
        'opportunity' => %w(Name StageName CloseDate IsClosed Account.Id Account.Name Owner.Name)
      }

      DEFAULT_TYPE_ALIAS = {
        'opp' => 'opportunity'
      }

      def show(response)
        type, id, fields = parse_match(response.match_data)
        response.reply(ask_salesforce(type, id, fields))
      end

      private

      def type_alias
        @type_alias ||= DEFAULT_TYPE_ALIAS.merge(config.type_alias || {})
      end

      def fields_by_object
        @fields_by_object ||= DEFAULT_FIELDS_BY_OBJECT.merge(config.fields_by_object || {})
      end

      # @param [MatchData] m
      # @return [Array[String, String, Array]] type, id, fields
      def parse_match(m)
        type = type_alias[m['type']] || m['type']
        fields = fields_by_object[type.downcase] || []
        id = m['id']
        [type, id, fields]
      end

      def ask_salesforce(type, id, fields)
        return "Sorry, I don't know which fields to fetch for #{type} sobject." if fields.empty?

        data = client.select(type, id, fields, 'Id')
        pretty_text(data, fields)
      rescue StandardError => e
        "Sorry, I couldn't get the date due to error: #{e.class} (#{e.message})"
      end

      def pretty_text(hash, keys = nil)
        (keys || hash.keys).map { |k| "#{k}: #{fetch_data(hash, k)}" }.join("\n")
      end

      # restforce returns values for fields having dots in nested Hash.
      def fetch_data(hash, key)
        cur = hash
        key.split('.').each { |k| cur = (cur || {})[k] }
        cur
      end

      def client
        @client ||= Restforce.new
      end

      Lita.register_handler(self)
    end
  end
end
