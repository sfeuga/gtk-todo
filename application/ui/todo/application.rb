# frozen_string_literal: true

module ToDo
  # Application class
  class Application < Gtk::Application
    attr_reader :user_data_path

    def initialize
      super 'com.sfeuga.gtk-todo', Gio::ApplicationFlags::FLAGS_NONE

      @user_data_path = File.expand_path('~/.gtk-todo')
      unless File.directory?(@user_data_path)
        puts "First run. Creating user's application path: #{@user_data_path}"
        FileUtils.mkdir_p(@user_data_path)
      end

      signal_connect :activate do |application|
        window = ToDo::ApplicationWindow.new(application)
        window.present
      end
    end
  end
end
