class Lights::LogEntry < ActiveRecord::Base
  belongs_to :loggable, polymorphic: true
end
