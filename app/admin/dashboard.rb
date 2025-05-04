# frozen_string_literal: true

ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Total Users" do
          para User.count
        end
      end

      column do
        panel "Total Books" do
          para Book.count
        end
      end

      column do
        panel "Total Comments" do
          para Comment.count
        end
      end
    end

    columns do
      column do
        panel "Recent Comments" do
          ul do
            Comment.order(created_at: :desc).limit(5).map do |comment|
              li link_to("Comment by #{comment.user.email} on #{comment.book.title}", admin_comment_path(comment))
            end
          end
        end
      end
    end
  end
end
