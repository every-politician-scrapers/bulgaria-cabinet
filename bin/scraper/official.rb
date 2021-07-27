#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'open-uri/cached'
require 'pry'

class MemberList
  # details for an individual member
  class Member < Scraped::HTML
    field :name do
      name_and_position.first
    end

    field :position do
      name_and_position.last
    end

    private

    def name_and_position
      noko.css('a').text.split('-', 2).map(&:tidy)
    end
  end

  # The page listing all the members
  class Members < Scraped::HTML
    field :members do
      member_container.map { |member| fragment(member => Member).to_h }
    end

    private

    def member_container
      noko.css('.profiles .info')
    end
  end
end

url = 'https://www.gov.bg/en/Cabinet/CABINET-MEMBERS'
puts EveryPoliticianScraper::ScraperData.new(url).csv
