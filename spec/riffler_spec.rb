require 'spec_helper'

class QueryDoc
  include Riffler
  attr_reader :doc

  def initialize(doc)
    @doc = doc
  end
end

RSpec.describe Riffler do

  let(:file_name) { 'sample.html' }
  let(:base_doc)  {
    File.open(File.join('spec', 'fixtures', 'sample.html')) { |f| Nokogiri::HTML(f.read) }
  }
  let(:doc)       { QueryDoc.new(base_doc) }

  describe "#find_by_xpath" do
    it "finds the first matching node by xpath" do
      result = doc.find_by_xpath(xpath: "//div[@class='container']//li")
      expect(result).to eq("First")
    end

    it "takes a match argument" do
      result = doc.find_by_xpath(
        xpath: "//div[@class='container']//li",
        match: /second/i
      )
      expect(result).to eq("Second")
    end
  end
end
