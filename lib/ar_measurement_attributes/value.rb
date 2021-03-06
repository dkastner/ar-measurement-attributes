require 'active_resource'
require 'conversions'

module ARMeasurementAttributes
  # Class used to convert internal representations of measurement 
  # attributes into external representations, according to defined 
  # options
  class Value
    attr_accessor :measurement, :internal_value, :options

    # Parameters:
    #  * measurement - the type of measurement (e.g. :length)
    #  * internal_value - the metric value of the measurement
    #  * options - all default, DSL, and runtime options
    def initialize(measurement, internal_value, options)
      self.measurement = measurement
      self.internal_value = internal_value
      self.options = (options || {})
    end

    # The scale/precision used for display of measurement
    def scale
      scale = options[:precision] || options[:scale]
    end
    
    # Converts and scales a measurement to the external representation
    def convert_measurement
      return convert_percentage if measurement == :percentage
      return internal_value if options[:internal].nil? || options[:external].nil?

      args = [options[:internal], options[:external]]
      converted_value = internal_value.convert(*args)
      
      scale_value(converted_value)
    end

    # Converts percentage values from a decimal <= 1 to a number <= 100
    def convert_percentage
      percentage = internal_value * 100.0
      scale_value(percentage)
    end

    # Scale the value to the specified precision
    def scale_value(value)
      value = "%.#{scale}f" % value if scale
      if options[:hide_zeros_for_whole_numbers] &&
        value =~ /\d+\.0+/
        value = value.to_i
      end

      value.to_s
    end

    # Add the appropriate label to the measurement
    def label_measurement(value)
      return value if options[:external].nil?

      label = ARMeasurementAttributes.label_for(options[:external])

      if label.respond_to?(:keys) && label[:prefix]
        "#{label[:text]}#{value}"
      else
        "#{value}#{label}"
      end
    end

    # Display the measurement with its label, converted to 
    # external representation
    def to_s
      return nil if internal_value.nil?
      converted_value = convert_measurement
      label_measurement(converted_value)
    end
  end
end
