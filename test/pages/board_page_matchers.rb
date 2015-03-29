module BoardPage
  module Matchers
    def lists
      all("[data-role='list']").to_a
    end

    def list(title)
      node = find('[data-role="list-title"]', text: title)
      ancestor_by_role_for(node, "list")
    end

    def todo_list
      list(t("lists.list.todo"))
    end

    def review_list
      list(t("lists.list.review"))
    end

    def doing_list
      list(t("lists.list.doing"))
    end

    alias_method :first_list, :todo_list
    alias_method :last_list, :review_list
    alias_method :another_list, :doing_list

    def card(title)
      find("[data-role='card']", text: title)
    end

    def cards_container_for_list(list)
      list.find("[data-role='cards-container']")
    end

    private

    def ancestor_by_role_for(child_node, ancestor_role)
      child_node.find(:xpath, "ancestor::*[@data-role='#{ancestor_role}']")
    end
  end
end
