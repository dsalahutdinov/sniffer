# frozen_string_literal: true

require "anyway_config"

module Sniffer
  # Sniffer configuration
  class Config < Anyway::Config
    config_name :sniffer

    attr_config logger: Logger.new($stdout),
                severity: Logger::Severity::DEBUG,
                log: {
                  request_url: true,
                  request_headers: true,
                  request_body: true,
                  request_method: true,
                  response_status: true,
                  response_headers: true,
                  response_body: true,
                  timing: true
                },
                store: true,
                enabled: false,
                url_whitelist: nil,
                url_blacklist: nil

    def capacity?
      store.is_a?(Hash) && store.key?(:capacity)
    end

    def capacity
      store.fetch(:capacity).to_i
    end

    def rotate?
      return false unless capacity?

      store.fetch(:rotate, true)
    end
  end
end
