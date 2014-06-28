class Activity < ActiveRecord::Base

  include Searchable

  TYPES = {
    conference: 0,
    workshop: 1,
    discussion_board: 2,
    paper: 3
  }

  TYPE_NAMES = {
    TYPES[:conference] => 'Conferencia',
    TYPES[:workshop] => 'Taller',
    TYPES[:discussion_board] => 'Panel',
    TYPES[:paper] => 'Ponencia'
  }

  belongs_to :room
  belongs_to :speaker

  validates :name, :activity_type, :description, :starts_at, :ends_at, :room_id, :speaker_id, presence: true
  validates :name, length: { maximum: 100 }
  validate :dates_are_valid

  def type_name
    TYPE_NAMES[self.activity_type]
  end

  def self.search_operators
    {
      name: 'ilike',
      activity_type: '=',
      starts_at: 'between',
      ends_at: 'between',
      room_id: '=',
      speaker_id: '=' 
    }
  end

  def self.time_attributes
    [:starts_at, :ends_at, :created_at, :updated_at]
  end

  protected
    def dates_are_valid
      errors.add(:starts_at, 'La fecha de inicio debe ser menor a la fecha fin') if self.starts_at > self.ends_at
    end

end
