class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # Ransack 4+ requires explicit allowlists. This helper keeps the decision
  # explicit at each model (opt-in), while avoiding repetitive boilerplate.
  def self.ransack_allow_all!
    define_singleton_method(:ransackable_attributes) do |_auth_object = nil|
      attrs = column_names.dup
      attrs.concat(attribute_aliases.keys) if respond_to?(:attribute_aliases)
      attrs.concat(_ransackers.keys) if respond_to?(:_ransackers)
      attrs.concat(_ransack_aliases.keys) if respond_to?(:_ransack_aliases)
      attrs.map(&:to_s).uniq
    end

    define_singleton_method(:ransackable_associations) do |_auth_object = nil|
      reflect_on_all_associations.map { |assoc| assoc.name.to_s }
    end
  end
end
