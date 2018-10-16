# frozen_string_literal: true

class ReminderFinder
  def todays_reminders
    time_start = Time.now.beginning_of_day
    time_end = time_start + 24.hours
    Reminder.where(
      alarm_at: (time_start...time_end)
    )
  end

  # def todays_reminders
  #   time_start = Time.current.beginning_of_day
  #   time_end = time_start + 24.hours
  #   Reminder.where(
  #     alarm_at: (time_start..time_end)
  #   )
  # end

  # def upcoming_for(user:, time:)
  #   time_zone = user.time_zone
  #   user_time = time.in_time_zone(time_zone)
  #   time_range = Time
  #   Reminder.where(

  #   )
  # end
end
