class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # Rails 8 + Ransack 4 requires explicit allowlists. This broad app-wide
  # fallback preserves current behavior during the upgrade; tighten per model
  # later if stricter search exposure is needed.
  def self.ransackable_attributes(_auth_object = nil)
    attrs = column_names.dup
    attrs.concat(attribute_aliases.keys) if respond_to?(:attribute_aliases)
    attrs.concat(_ransackers.keys) if respond_to?(:_ransackers)
    attrs.concat(_ransack_aliases.keys) if respond_to?(:_ransack_aliases)
    attrs.map(&:to_s).uniq
  end

  def self.ransackable_associations(_auth_object = nil)
    reflect_on_all_associations.map { |assoc| assoc.name.to_s }
  end
end
