class Task < ApplicationRecord
  belongs_to :project
  validates :name, presence: true

  def done!
    self.done = true
    save
  end

end
