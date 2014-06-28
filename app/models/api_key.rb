class ApiKey < ActiveRecord::Base
  validates :app_name, :key, presence: true
  validates :key, uniqueness: true

  before_validation(on: :create) do
    generate_key
  end

  def generate_key
    begin
      self.key = SecureRandom.hex
    end while self.class.exists?(key: self.key)
  end
end
