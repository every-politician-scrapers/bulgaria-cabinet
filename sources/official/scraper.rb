#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    field :name do
      name_and_position.first
    end

    field :position do
      name_and_position.last.split (/ and (?=M)/)
    end

    private

    def name_and_position
      noko.css('a').text.split('-', 2).map(&:tidy)
    end
  end

  class Members
    field :members do
      # 'position' is a list of 1 or more positions
      member_container.flat_map do |member|
        data = fragment(member => Member).to_h
        data.delete(:position).map { |posn| data.merge(position: posn) }
      end
    end

    private

    def member_container
      noko.css('.profiles .info')
    end
  end
end

file = Pathname.new 'official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
