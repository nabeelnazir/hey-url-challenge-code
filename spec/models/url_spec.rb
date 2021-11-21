# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Url, type: :model do
  describe 'validations' do
    let(:url) { FactoryBot.create(:url) }

    it 'validates original URL is a valid URL' do
      skip 'add test'
    end

    it 'validates short URL is present' do
      skip 'add test'
    end

    it 'MUST have 5 characters in length' do
      expect(url.short_url.length).to eq(5)
    end

    it 'MUST generate only upper case letters' do
      expect(url.short_url).to eq(url.short_url.upcase)
    end

    it 'MUST NOT generate special characters' do
      expect(url.short_url.scan(/[!@#$%^&*()_+{}\[\]:;'"\/\\?><.,]/).empty?).to eq(true)
    end

    it 'MUST NOT generate whitespace' do
      expect(url.short_url.length).to eq(url.short_url.strip.length)
    end

    it 'must be unique' do
      another_url = Url.new
      another_url.short_url = Url.generate_short_url
      expect(url.short_url).not_to eq(another_url.short_url)
    end


    
  end
end
