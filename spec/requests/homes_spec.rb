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
    expect(page).to have_selector("input[type=submit][value='Save Form']")
  end
  describe "sending a wrong request" do
    before do
      fill_in "form_inn", with: "123456789"
      click_button "Save Form"
    end
    describe 'table' do
      it 'exists' do
        expect(page).to have_css 'table'
      end
      it 'has results inside' do
        within 'table' do
          expect(page).to have_content("ошибка")
        end
      end
    end
  end
  describe "sending a right request" do
    before do
      fill_in "form_inn", with: "190735914"
      click_button "Save Form"
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
end

