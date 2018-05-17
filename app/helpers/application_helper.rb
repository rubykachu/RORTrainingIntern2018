# frozen_string_literal: true

module ApplicationHelper
  %w[create update].each do |method|
    define_method "act_#{method}?" do
      params[:action] == method
    end
  end

  def msg_form_errors(object, field)
    return if object.errors.blank?
    content_tag :div, class: "note valid" do
      object.errors.messages[field.to_sym].each do |message|
        concat content_tag :span, "#{field.to_s.humanize} #{message}", class: "form-errors"
      end
    end
  end

  def flash_notify
    return if flash.blank?
    klass = flash.keys.include?("notice") ? "alert-success" : "alert-danger"
    status = flash.keys.include?("notice") ? "Success!" : "Failed!"
    content_tag :div, class: "col-md-10" do
      content_tag :div, class: "alert #{klass}" do
        content_tag :strong, "#{status} #{flash[flash.keys.first]}"
      end
    end
  end

  def redirect_after_update_or_create(object)
    if object.try(:errors).try(:any?)
      act_create? ? render(:new) : render(:edit)
    else
      redirect_to edit_user_path(object), notice: message_notify(object)
    end
  end

  def message_notify(object)
    if act_create?
      "Add new #{object.model_name.name.downcase} successfully"
    else
      "Update #{object.model_name.name.downcase} successfully"
    end
  end

  def render_sidebar; end
end
