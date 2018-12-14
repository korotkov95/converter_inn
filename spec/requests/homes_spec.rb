require 'rails_helper'
require './config/routes.rb'


describe "Home page" do
  before {visit root_path}
  it "should have the base title" do
    expect(page).to have_title("ConverterInn")
  end
  it "should have content 'УНП'" do
    expect(page).to have_content("УНП")
  end
  it "should have content submit button" do
    expect(page).to have_selector("input[type=submit][value='Искать!']")
  end
  describe "sending a wrong request" do
    before do
      fill_in "form_inn", with: "123456789"
      click_button "Искать!"
    end
    describe 'table' do
      it 'exists' do
        expect(page).to have_css 'table'
      end
      it 'has results inside' do
        within 'table' do
          expect(page).to have_content("Не существует")
        end
      end
    end
  end
  describe "sending a right request" do
    before do
      fill_in "form_inn", with: "190735914"
      click_button "Искать!"
    end
    describe 'table' do
      it 'exists' do
        expect(page).to have_css 'table'
      end
      it 'has results inside' do
        within 'table' do
          expect(page).to have_content("190735914")
          expect(page).to have_content("Действующий")
        end
      end
    end
  end
  describe "sending a multi-unp request" do
    before do
      fill_in "form_inn", with: "190436848
                                100063699
                                190735914
                                790916191
                                123456789
                                290505026
                                192456501
                                192369430"
      click_button "Искать!"
    end
    it "all values on page" do
      expect(page).to have_content("192369430")
    end
    it "all statistics on page" do
      expect(page).to have_content('Всего проверено : 8')
      # expect(page).to have_content('В статусе "Действующий" : 6')
      # expect(page).to have_content('В статусе "Ликвидирован / в процессе ликвидации" : 1')
      # expect(page).to have_content('В одном из значений ошибка!')
    end
  end
end

