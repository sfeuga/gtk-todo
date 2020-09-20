# frozen_string_literal: true

module ToDo
  # Application class
  class Application < Gtk::Application
    def initialize
      super 'com.sfeuga.gtk-todo', Gio::ApplicationFlags::FLAGS_NONE

      signal_connect :activate do |application|
        window = ToDo::ApplicationWindow.new(application)
        window.present
      end
    end
  end
end
