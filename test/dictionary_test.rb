# frozen_string_literal: true

require "test_helper"

	class DictionaryTest < Minitest::Test
	# This line includes all default Spout Dictionary tests.
	include Spout::Tests::JsonValidation
	include Spout::Tests::DomainExistenceValidation
	include Spout::Tests::DomainFormat
	include Spout::Tests::DomainNameFormat
	include Spout::Tests::DomainNameUniqueness
	include Spout::Tests::DomainSpecified
	include Spout::Tests::FormExistenceValidation
	include Spout::Tests::FormNameFormat
	include Spout::Tests::FormNameMatch
	include Spout::Tests::FormNameUniqueness
	# include Spout::Tests::VariableDisplayNameLength
	include Spout::Tests::VariableNameFormat
	include Spout::Tests::VariableNameMatch
	include Spout::Tests::VariableNameUniqueness
	include Spout::Tests::VariableTypeValidation

  # This line provides access to @variables, @forms, and @domains iterators
  # iterators that can be used to write custom tests.
  include Spout::Helpers::Iterators

  # Example 1: Create custom tests to show that `integer` and `numeric`
  # variables have a valid unit type.
  VALID_UNITS = [
    'natural logarithm degrees', 'seconds from start of recording',
    'seconds squared (s2)', 'microvolts squared per hertz (uV2/Hz)', 'hertz (Hz)',
    'standard deviations from the mean', 'snores',
    'international units per milliliter (IU/mL)', 'seconds from date of randomization',
    'milligrams per deciliter (mg/dL)', 'micrograms per milliliter (ug/mL)',
    'kilograms per year', 'kilograms per year * meters squared',
    'centimeters per year', 'celsius (C)', 'beats per minute (bpm)',
    'millimeters of mercury (mmHg)', 'centimeters (cm)', 'percent (%)', 'months', 'years',
    'pounds (lb)', 'ounces (oz)', 'inches (in)', 'feet', 'kilograms (kg)', 'hours (h)', 'days',
    'minutes (min)', 'seconds (s)', 'events per hour', 'kilograms / meters squared (kg/m2)',
    'percentile', 'limb movements', 'percentage of oxygen saturation',
    'desaturation events', 'limb movements per hour', 'decibels (dB)', 'breaths per minute',
    'percentage of carbon dioxide','events','millimoles per liter (mmol/L)',
    'millimeters of mercury','kilograms per square meter','', 'seconds', 'hours', nil
  ]
  @variables.select { |v| %w(numeric integer).include?(v.type) }.each do |variable|
    define_method("test_units: #{variable.path}") do
      message = "\"#{variable.units}\"".red + " invalid units.\n" +
                "             Valid types: " +
                VALID_UNITS.sort_by(&:to_s).collect { |u| u.inspect.white }.join(", ")
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
