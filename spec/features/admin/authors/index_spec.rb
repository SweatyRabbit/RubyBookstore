# frozen_sstring_literal: true

RSpec.describe 'Index', type: :feature do
  let!(:authors) { create_list(:author, 5) }
  let!(:admin) { create(:admin_user) }
  let(:author_attributes) { Author.attribute_names.excluding('id', 'created_at', 'updated_at') }

  before do
    visit '/admin'
    fill_in('admin_user_email', with: admin.email)
    fill_in('admin_user_password', with: admin.password)
    click_button('Login')
    click_link('Authors')
  end

  it 'displays author attributes' do
    author_attributes.each do |attribute|
      authors.map(&attribute.to_sym).each do |text|
        expect(page).to have_content(text)
      end
    end
  end
end
