# frozen_string_literal: true

ActiveAdmin.register Book do
  decorate_with BookDecorator
  permit_params :title, :price, :description,
                :publication_year, :width, :height,
                :depth, :materials, :category_id, author_ids: []

  index do
    selectable_column
    column :title do |book|
      link_to book.title, resource_path(book)
    end
    column :description
    column :authors_full_name
    column :category
    column :price
    actions
  end

  show do
    attributes_table do
      row :title
      row :authors, &:authors_full_name
      row :price
      row :description
      row :publication_year
      row :category
      row :height
      row :width
      row :depth
      row :materials
    end
  end

  form(html: { multipart: true }) do |f|
    f.inputs do
      f.input :category
      f.input :title
      f.input :authors, collection: Author.all.decorate(&:full_name), as: :check_boxes
      f.input :description
      f.input :price
      f.input :publication_year
      f.input :height
      f.input :width
      f.input :depth
      f.input :materials
    end
    actions
  end
end