# frozen_string_literal: true

module ToDo
  # ApplicationWindow class
  class ApplicationWindow < Gtk::ApplicationWindow
    # Register the class in the GLib world
    type_register

    class << self
      def init
        # Set the template from the resources binary
        set_template resource: '/com/sfeuga/gtk-todo/ui/application_window.ui'

        bind_template_child 'add_new_item_button'
      end
    end

    def initialize(application)
      super application: application

      set_title 'My GTK+ Simple ToDo list'

      add_new_item_button.signal_connect 'clicked' do |button|
        new_item_window = NewItemWindow.new(application, ToDo::Item.new(user_data_path: application.user_data_path))
        new_item_window.present
      end
    end
  end
end
