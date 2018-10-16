# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReminderFinder do
  subject(:reminder_finder) { described_class.new }

  describe '.new' do
    it { is_expected.to be_present }
  end

  describe '#todays_reminders' do
    subject(:todays_reminders) { reminder_finder.todays_reminders }

    context 'with a reminder at noon today' do
      let!(:noon_reminder) do
        Reminder.create(alarm_at: noon)
      end
      let(:noon) { Time.new(2018, 10, 16, 12) } # ??
      # let(:noon) { Time.parse('2018-10-16 12:00:00') } # ??
      # let(:noon) { Time.now.beginning_of_day + 12.hours } # ??

      it 'includes a reminder' do
        expect(todays_reminders.length).to eq 1
      end

      it 'has the reminder set to noon ' do
        expect(todays_reminders.first.alarm_at).to eq noon
      end
    end

    context 'with a reminder at midnight today' do
      let!(:midnight_reminder) do
        Reminder.create(alarm_at: midnight)
      end
      let(:midnight) { Time.new(2018, 10, 16, 0) } # ??

      it 'includes a reminder' do
        expect(todays_reminders.length).to eq 1
      end

      it 'has the reminder set to midnight ' do
        expect(todays_reminders.first.alarm_at).to eq midnight
      end
    end

    context 'with a reminder late tonight' do
      let!(:late_reminder) do
        Reminder.create(alarm_at: late)
      end
      let(:late) {
       Time.new(2018, 10, 16, 11) } # ??

      it 'includes a reminder' do
        expect(todays_reminders.length).to eq 1
      end

      it 'has the reminder set to late ' do
        expect(todays_reminders.first.alarm_at).to eq late
      end
    end
  end
end
