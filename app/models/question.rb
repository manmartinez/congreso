class Question < ActiveRecord::Base

  belongs_to :user
  belongs_to :activity

  validates :text, :votes, :activity_id, :user_id, presence: true
  validates :votes, numericality: { only_integer: true }
  validates :text, length: { maximum: 150 }

  after_create :publish_question

  include Searchable

  def self.search_operators
    {
      user_id: '=',
      activity_id: '='
    }
  end

  def self.time_attributes
    [:created_at, :updated_at]
  end

  protected
    def publish_question
      PrivatePub.publish_to "/questions", question: self.as_json(
        include: {
          user: { only: [:full_name] }, 
          activity: { only: [:name] }
        }
      )
    end
end
