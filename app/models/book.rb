# frozen_string_literal: true
# Generated with `rails generate valkyrie:model Book`
class Book < Valkyrie::Resource
  include Valkyrie::Resource::AccessControls
  attribute :title, Valkyrie::Types::Set
  attribute :author, Valkyrie::Types::Set
  attribute :description, Valkyrie::Types::Set

  def self.count
    Valkyrie.config.metadata_adapter.query_service.find_all_of_model(model: self).count
  end
end
