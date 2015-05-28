class Species
  FILE_NAME = 'species.yml'

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

  def self.all
    YAML.load_file Rails.root.join('config', 'data', FILE_NAME)
  end

end
