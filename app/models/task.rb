class Task < ApplicationRecord
  belongs_to :project
  validates :name, presence: true
  validate :cannot_be_in_the_past
  acts_as_list
  def cannot_be_in_the_past
    if deadline.present? && deadline <= Time.zone.now
    end
  end
  def done!
    self.done = true
    save
  end

end
