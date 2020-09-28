# frozen_string_literal: true

module ToDo
  ### ItemListBoxRow Class
  class ItemListBoxRow < Gtk::ListBoxRow
    type_register

    class << self
      def init
        set_template resource: '/com/sfeuga/gtk-todo/ui/todo_item_list_box_row.ui'

        bind_template_child 'delete_button'
        bind_template_child 'details_button'
        bind_template_child 'edit_button'
        bind_template_child 'todo_item_details_revealer'
        bind_template_child 'todo_item_notes_text_view'
        bind_template_child 'todo_item_priority_label'
        bind_template_child 'todo_item_title_label'
      end
    end

    def initialize(item)
      super()

      delete_button.signal_connect 'clicked' do
        item.delete!

        application_window = application.windows.find { |window| window.is_a? ToDo::ApplicationWindow }
        application_window.load_todo_items
      end

      details_button.signal_connect 'clicked' do
        todo_item_details_revealer.set_reveal_child !todo_item_details_revealer.reveal_child?
      end

      edit_button.signal_connect 'clicked' do
        new_item_window = NewItemWindow.new(application, item)
        new_item_window.present
      end

      todo_item_notes_text_view.buffer.text = item.notes || ''

      todo_item_priority_label.text = item.priority || ''

      todo_item_title_label.text = item.title || ''
    end

    def application
      parent = self.parent
      parent = parent.parent until parent.is_a? Gtk::Window
      parent.application
    end
  end
end
