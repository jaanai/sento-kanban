Given(/^I'm creating a board with an empty title$/) do
  step %(I go to the list of boards)
  step %(I click the new board block)
  step %(I click on "#{I18n.t('sento.kanban.buttons.create')}")
end
