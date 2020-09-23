# frozen_string_literal: true

module ToDo
  ### NewItemWindow Class
  class NewItemWindow < Gtk::Window
    type_register

    class << self
      def init
        set_template resource: '/com/sfeuga/gtk-todo/ui/new_item_window.ui'
      end
    end

    def initialize(application)
      super application: application
    end
  end
end
