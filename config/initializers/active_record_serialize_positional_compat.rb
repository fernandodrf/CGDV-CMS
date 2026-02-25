# Rails 7.1 deprecates `serialize :column, Array` in favor of `serialize :column, type: Array`.
# Some legacy gems (e.g. slow_your_roles) still call the positional form, so normalize it here.
module ActiveRecordSerializePositionalCompat
  def serialize(attr_name, class_name_or_coder = nil, coder: nil, type: Object, yaml: {}, **options)
    if class_name_or_coder.is_a?(Class) && coder.nil? && type == Object
      return super(attr_name, nil, coder: nil, type: class_name_or_coder, yaml: yaml, **options)
    end

    super
  end
end

ActiveSupport.on_load(:active_record) do
  ActiveRecord::AttributeMethods::Serialization::ClassMethods.prepend(ActiveRecordSerializePositionalCompat)
end
