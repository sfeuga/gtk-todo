# frozen_string_literal: true

require 'securerandom'
require 'json'

module ToDo
  ### Item class
  class Item
    PROPERTIES = %i[
      creation_datetime
      filename
      id
      notes
      priority
      title
    ].freeze

    PRIORITIES = %w[
      high
      low
      medium
      normal
    ].freeze

    attr_accessor(*PROPERTIES)

    def initialize(options = {})
      if user_data_path == options[:user_data_path]
        @id = SecureRandom.uuid
        @creation_datetime = Time.now.to_s
        @filename = "#{user_data_path}/#{id}.json"
      elsif filename == options[:filename]
        load_from_file filename
      else
        raise ArgumentError, 'Please specify the :user_data_path for new item or the :filename to load existing'
      end
    end

    def load_from_file(filename)
      properties = JSON.parse(File.read(filename))

      PROPERTIES.each do |property|
        send "#{property}=", properties[property.to_s]
      end
    rescue StandardError => e
      raise ArgumentError, "Failed to load existing item: #{e.message}"
    end

    def new?
      !File.exist? @filename
    end

    def save!
      File.open(@filename, 'w') do |file|
        file.write to_json
      end
    end

    def delete!
      raise 'Item is not saves!' if new?

      File.delete(@filename)
    end

    def to_json(*_args)
      result = {}
      PROPERTIES.each do |property|
        result[property] = send property
      end

      result.to_json
    end
  end
end
