require 'test_helper'

class DictionaryTest < Test::Unit::TestCase
  include Spout::Tests

  VALID_UNITS = ['micrograms per milliliter'.'kilograms per year','kilograms per year*meters squared','centimeters per year','','decibels','celsius','beats per minute','millimeters of mercury','centimeters','percent','months','years','pounds','ounces','inches','feet','kilograms','hours','days','minutes','seconds','events per hour','kilograms / meters squared','percentile','limb movements', 'percentage of oxygen saturation', 'desaturation events', 'limb movements per hour', 'percentage of carbon dioxide','events','millimoles per litre'] #Example ['mmHG','bpm','readings','minutes','%','hours','MET']

  def assert_units(units, msg = nil)
    full_message = build_message(msg, "? invalid units. Valid types: #{VALID_UNITS.join(', ')}", units)
    assert_block(full_message) do
      VALID_UNITS.include?(units)
    end
  end

  Dir.glob("variables/**/*.json").each do |file|
    if ['numeric','integer'].include?(json_value(file, :type))
      define_method("test_units: "+file) do
        assert_units json_value(file, :units)
      end
    end
  end
end
