# Rails 7.1 deprecates `serialize :column, Array` in favor of `serialize :column, type: Array`.
# Some legacy gems (e.g. slow_your_roles) still call the positional form, so normalize it here.
module ActiveRecordSerializePositionalCompat
  def serialize(attr_name, class_name_or_coder = nil, coder: nil, type: Object, yaml: {}, **options)
    normalized_coder = coder
    normalized_type = type
    legacy_second_arg = class_name_or_coder

    if class_name_or_coder.is_a?(Class) && coder.nil? && type == Object
      legacy_second_arg = nil
      normalized_type = class_name_or_coder
    elsif !class_name_or_coder.nil? && coder.nil?
      legacy_second_arg = nil
      normalized_coder = class_name_or_coder
    end

    if Gem::Version.new(ActiveRecord.gem_version.to_s) >= Gem::Version.new("8.0.0")
      return super(attr_name, coder: normalized_coder, type: normalized_type, yaml: yaml, **options)
    end

    super(attr_name, legacy_second_arg, coder: normalized_coder, type: normalized_type, yaml: yaml, **options)
  end
end

ActiveSupport.on_load(:active_record) do
  ActiveRecord::AttributeMethods::Serialization::ClassMethods.prepend(ActiveRecordSerializePositionalCompat)
end
