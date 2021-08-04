#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  # details for an individual member
  class Member < Scraped::HTML
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

  # The page listing all the members
  class Members < Scraped::HTML
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

file = Pathname.new 'html/official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
