feature "ToDos" do
  scenario "A user can sign in a create a ToDo" do
    register_and_sign_in
    add_to_do
  end

  scenario "I can edit my to do list" do
    register_and_sign_in
    add_to_do
    click_button "Edit"
    fill_in "What would you like to change your to do to?", with: "Get a shave"
    click_button "Edit ToDo"
    expect(page).to have_content "ToDo Updated"
    within ".todos" do
      expect(page).to have_content "Get a shave"
      expect(page).to_not have_content "Get a haircut"

    end
  end

  scenario "I can finish my to dos" do
    register_and_sign_in
    add_to_do
    click_button "Complete"
    expect(page).to have_content "ToDo Completed"
    expect(page).to_not have_content "Get a haircut"

  end

  scenario "I can only see my own to do list" do
    register_another_user_and_add_to_do
    register_and_sign_in
    add_to_do
    expect(page).to_not have_content "Get a kitten"
  end
end


def register_and_sign_in
  visit "/"

  click_link "Register"

  fill_in "Username", with: "hunta"
  fill_in "Password", with: "pazzword"

  click_button "Register"

  fill_in "Username", with: "hunta"
  fill_in "Password", with: "pazzword"

  click_button "Sign In"
  expect(page).to have_content "Welcome, hunta"
end

def add_to_do
  fill_in "What do you need to do?", with: "Get a haircut"
  click_button "Add ToDo"

  expect(page).to have_content "ToDo added"

  within ".todos" do
    expect(page).to have_content "Get a haircut"
  end
end

def register_another_user_and_add_to_do
  visit "/"

  click_link "Register"

  fill_in "Username", with: "jeff"
  fill_in "Password", with: "pazzword"

  click_button "Register"

  fill_in "Username", with: "jeff"
  fill_in "Password", with: "pazzword"

  click_button "Sign In"
  expect(page).to have_content "Welcome, jeff"

  fill_in "What do you need to do?", with: "Get a kitten"
  click_button "Add ToDo"

  expect(page).to have_content "ToDo added"

  within ".todos" do
    expect(page).to have_content "Get a kitten"
  end
  click_button "Sign Out"
end

