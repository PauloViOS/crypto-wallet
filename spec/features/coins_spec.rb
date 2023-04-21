require 'rails_helper'

RSpec.feature "Coins", type: :feature, js: true do
  it "Visits the index page" do
    visit(coins_path)
    page.save_screenshot('coins_index_screenshot.png')
    expect(page).to have_current_path(coins_path)
  end

  it "Creates a coin" do
    visit(new_coin_path)

    fill_in("Descrição", with: "Uma moeda de teste")
    fill_in("Sigla", with: "UMT")
    fill_in("Url da imagem", with: "data:image/jpeg;base64,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")

    click_button("Criar Moeda")

    expect(page).to have_content("Coin was successfully created.")
  end
end