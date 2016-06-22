require 'rails_helper'

RSpec.describe TdlPast, :type => :model do
  describe '#waittime_with_status' do
    it 'status が false の時に -1 が返る' do
      create(:tdl_past, status: false, waittime: 30)
      expect(TdlPast.last.waittime_with_status).to eq(-1)
    end

    it 'status が true の時に waittime が返る' do
      create(:tdl_past, status: true, waittime: 30)
      expect(TdlPast.last.waittime_with_status).to eq(30)
    end
  end
end
