#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

# Bulgarian dates
class Bulgarian < WikipediaDate
  REMAP = {
    '…'         => '',
    'януари'    => 'January',
    'FEBRUARY'  => 'February',
    'март'      => 'March',
    'APRIL'     => 'April',
    'май'       => 'May',
    'JUNE'      => 'June',
    'юли'       => 'July',
    'август'    => 'August',
    'септември' => 'September',
    'октомври'  => 'October',
    'ноември'   => 'November',
    'декември'  => 'December',
  }.freeze

  def remap
    super.merge(REMAP)
  end
end

class OfficeholderList < OfficeholderListBase
  decorator RemoveReferences
  decorator UnspanAllTables
  decorator WikidataIdsDecorator::Links

  def header_column
    'име'
  end

  class Officeholder < OfficeholderBase
    def columns
      %w[_ name dates].freeze
    end

    def tds
      noko.css('td,th')
    end

    def date_class
      Bulgarian
    end
  end
end

url = ARGV.first
puts EveryPoliticianScraper::ScraperData.new(url, klass: OfficeholderList).csv
