require 'test_helper'

class DictionaryTest < Minitest::Test
  include Spout::Tests

  VALID_UNITS = ['seconds from date of randomization','milligrams per deciliter','micrograms per milliliter','kilograms per year','kilograms per year * meters squared','centimeters per year','','decibels','celsius','beats per minute','millimeters of mercury','centimeters','percent','months','years','pounds','ounces','inches','feet','kilograms','hours','days','minutes','seconds','events per hour','kilograms / meters squared','percentile','limb movements', 'percentage of oxygen saturation', 'desaturation events', 'limb movements per hour', 'percentage of carbon dioxide','events','millimoles per litre'] #Example ['mmHG','bpm','readings','minutes','%','hours','MET']

  Dir.glob("variables/**/*.json").each do |file|
    if ['numeric','integer'].include?(json_value(file, :type))
      define_method("test_units: "+file) do
        units = json_value(file, :units)
        message = "#{units} invalid units. Valid types: #{VALID_UNITS.join(', ')}"
        assert VALID_UNITS.include?(units), message
      end
    end
  end
end
