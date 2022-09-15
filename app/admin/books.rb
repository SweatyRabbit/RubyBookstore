# frozen_string_literal: true

ActiveAdmin.register Book do
  decorate_with BookDecorator
  permit_params :title, :price, :description,
                :publication_year, :width, :height, :quantity,
                :depth, :materials, :category_id, :title_image, body_images: [], author_ids: []

  index do
    selectable_column
    column :title_image do |book|
      image_tag book.resize_title_image(500) if book.title_image.attached?
    end
    column :title do |book|
      link_to book.title, resource_path(book)
    end
    colum  :quantity
    column :description
    column :authors_full_name
    column :category
    column :price
    actions
  end

  show do
    attributes_table do
      row :title_image do |book|
        image_tag book.resize_title_image(500) if book.title_image.attached?
      end
      book.resized_body_images(500).each do |image|
        row :body_images do
          image_tag image
        end
      end
      row :title
      row :authors, &:authors_full_name
      row :price
      row :quantity
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
      f.input :price
      f.input :quantity
      f.input :description
      f.input :publication_year
      f.input :height
      f.input :width
      f.input :depth
      f.input :materials
      f.input :title_image, as: :file
      f.input :body_images, as: :file, input_html: { multiple: true }
    end
    actions
  end
end
