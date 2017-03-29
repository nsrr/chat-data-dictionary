# frozen_string_literal: true

require 'test_helper'

# Launches default Spout tests and custom tests for specific to this dictionary
class DictionaryTest < Minitest::Test
  # This line includes all default Spout Dictionary tests
  include Spout::Tests

  # This line provides access to @variables, @forms, and @domains iterators
  # iterators that can be used to write custom tests
  include Spout::Helpers::Iterators

  # Example 1: Create custom tests to show that `integer` and `numeric` variables have a valid unit type
  VALID_UNITS = [
    'natural logarithm degrees', 'seconds from start of recording',
    'seconds squared', 'microvolts squared per hertz', 'hertz',
    'standard deviations from the mean', 'snores',
    'international units per milliliter', 'seconds from date of randomization',
    'milligrams per deciliter', 'micrograms per milliliter',
    'kilograms per year', 'kilograms per year * meters squared',
    'centimeters per year', '', 'decibels', 'celsius', 'beats per minute',
    'millimeters of mercury', 'centimeters', 'percent', 'months', 'years',
    'pounds', 'ounces', 'inches', 'feet', 'kilograms', 'hours', 'days',
    'minutes', 'seconds', 'events per hour', 'kilograms / meters squared',
    'percentile', 'limb movements', 'percentage of oxygen saturation',
    'desaturation events', 'limb movements per hour',
    'percentage of carbon dioxide','events','millimoles per litre'
  ] #Example ['mmHG','bpm','readings','minutes','%','hours','MET']

  @variables.select { |v| %w(numeric integer).include?(v.type) }.each do |variable|
    define_method("test_units: #{variable.path}") do
      message = "\"#{variable.units}\"".colorize(:red) + " invalid units.\n" +
                "             Valid types: " +
                VALID_UNITS.sort_by(&:to_s).collect { |u| u.inspect.colorize(:white) }.join(', ')
      assert VALID_UNITS.include?(variable.units), message
    end
  end

  # Example 2: Create custom tests to show that variables have 2 or more labels.
  # @variables.select { |v| %w(numeric integer).include?(v.type) }.each do |variable|
  #   define_method("test_at_least_two_labels: #{variable.path}") do
  #     assert_operator 2, :<=, variable.labels.size
  #   end
  # end

  # Example 3: Create regular Ruby tests
  # You may add additional tests here
  # def test_truth
  #   assert true
  # end
end
