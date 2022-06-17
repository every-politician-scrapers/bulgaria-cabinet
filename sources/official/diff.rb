#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/comparison'

# Not listed on the site
SKIP = [
  ['---', 'Kiril Petkov', 'Prime Minister of Bulgaria']
].freeze

diff = EveryPoliticianScraper::DecoratedComparison.new('wikidata.csv', 'scraped.csv').diff
                                                 .reject { |row| SKIP.include? row }

puts diff.sort_by { |r| [r.first, r.last.to_s] }.reverse.map(&:to_csv)
