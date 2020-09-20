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
      end
    end

    def initialize(application)
      super application: application

      set_title 'My GTK+ Simple ToDo list'
    end
  end
end
