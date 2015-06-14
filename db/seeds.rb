# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

form = Form.create form_title: 'My first form'
form.fields = Field.create([
  {
    odk_type: 'text',
    name: 'some_text',
    label: 'This is a basic fill in the blank question.'
  },
  {
    odk_type: 'note',
    name: 'my_note',
    label: 'No user input: explanation only.'
  }
])

Form.create form_title: 'Form #2'
