require 'rails_helper'

RSpec.describe Coin, type: :model do
  context "Valid coin creation" do
    let(:mining_type)  { build :mining_type }
    let(:coin) { create :coin, mining_type: mining_type }

    it 'Creates a Coin' do
      expect(coin.description).to eq("Moedinha")
    end

  end
end
