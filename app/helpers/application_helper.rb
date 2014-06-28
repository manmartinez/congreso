module ApplicationHelper
  ALERT_TYPES = [:danger, :info, :success, :warning]

  def pagination(collection, options={})
    will_paginate collection, options.merge(renderer: BootstrapPagination::Rails)
  end

  def bootstrap_flash
    output = ''
    
    flash.each do |type, message|
      Rails.logger.info "[INFO] #{type} => #{message}"
      next if message.blank?
      type = :success if type == :notice
      type = :danger   if type == :alert
      next unless ALERT_TYPES.include?(type)
      output += flash_container(type, message)
    end
    Rails.logger.info "[INFO] #{output}"
    raw(output)
  end

  def flash_container(type, message)
    raw(content_tag(:div, :class => "bootstrap-flash alert alert-#{type}") do
      content_tag(:a, raw("&times;"),:class => 'close', :data => {:dismiss => 'alert'}) +
      message.html_safe
    end)
  end
end
