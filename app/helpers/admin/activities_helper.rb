module Admin::ActivitiesHelper

  def activity_type_options
    Activity::TYPE_NAMES.map do |key, value|
      [value, key]
    end
  end
end
