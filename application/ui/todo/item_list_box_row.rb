# frozen_string_literal: true

module ToDo
  ### ItemListBoxRow Class
  class ItemListBoxRow < Gtk::ListBoxRow
    type_register

    class << self
      def init
        set_template resource: '/com/sfeuga/gtk-todo/ui/todo_item_list_box_row.ui'
      end
    end

    def initialize(_item)
      super()
    end
  end
end
