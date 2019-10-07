# frozen_string_literal: true
# Generated with `rails generate valkyrie:model Book`
class Book < Valkyrie::Resource
  include Valkyrie::Resource::AccessControls
  attribute :title, Valkyrie::Types::Set
  attribute :author, Valkyrie::Types::Set
  attribute :description, Valkyrie::Types::Set
end
