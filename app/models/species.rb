class Species
  FILE_PATH = Rails.root.join('config', 'data', 'species.yml')

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name

  validates :name, presence: true

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  # Return the species list as 1 array
  def self.all
    (freshwater + saltwater).sort
  end

  # Find only the saltwater species
  def self.saltwater
    load_data['saltwater'].sort
  end

  # Find only the freshwater species
  def self.freshwater
    load_data['freshwater'].sort
  end

  private

  def self.load_data
    YAML.load_file FILE_PATH
  end

  # Raise an exception if this method is called from a public context
  private_class_method :load_data
end
