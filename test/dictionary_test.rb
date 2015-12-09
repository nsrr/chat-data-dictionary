require 'test_helper'
require 'colorize'

class DictionaryTest < Minitest::Test
  # This line includes all default Spout Dictionary tests
  include Spout::Tests

  # This line provides access to @variables, @forms, and @domains
  # iterators that can be used to write custom tests
  include Spout::Helpers::Iterators

  VALID_UNITS = ['seconds from start of recording','seconds squared','microvolts squared per hertz','hertz','standard deviations from the mean','snores','international units per milliliter','seconds from date of randomization','milligrams per deciliter','micrograms per milliliter','kilograms per year','kilograms per year * meters squared','centimeters per year','','decibels','celsius','beats per minute','millimeters of mercury','centimeters','percent','months','years','pounds','ounces','inches','feet','kilograms','hours','days','minutes','seconds','events per hour','kilograms / meters squared','percentile','limb movements', 'percentage of oxygen saturation', 'desaturation events', 'limb movements per hour', 'percentage of carbon dioxide','events','millimoles per litre'] #Example ['mmHG','bpm','readings','minutes','%','hours','MET']

  @variables.select{|v| ['numeric','integer'].include?(v.type)}.each do |variable|
    define_method("test_units: "+variable.path) do
      message = "\"#{variable.units}\"".colorize( :red ) + " invalid units.\n" +
                "             Valid types: " +
                VALID_UNITS.sort.collect{|u| u.inspect.colorize( :white )}.join(', ')
      assert VALID_UNITS.include?(variable.units), message
    end
  end
end
