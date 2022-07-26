# frozen_string_literal: true

class FilterBooksByCategory
  DEFAULT_FILTER = :created_at_desc
  BOOK_FILTER = {
    created_at_desc: { created_at: :desc },
    popular_asc: { created_at: :desc },
    low_to_high: { price: :asc },
    high_to_low: { price: :desc },
    title_atoz: { title: :asc },
    title_ztoa: { title: :desc }
  }.freeze

  def initialize(params)
    @category_name = params[:filter_by]
    @filter = params[:filter]&.to_sym || DEFAULT_FILTER
  end

  def call
    show_books_by_category
    show_books_by_filter
  end

  private

  def show_books_by_category
    @books = @category_name ? Book.joins(:category).where(category: { name: @category_name }) : Book.all
  end

  def show_books_by_filter
    @books.order(BOOK_FILTER[@filter])
  end
end
