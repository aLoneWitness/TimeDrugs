// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

protocol SubstanceSchema_SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == SubstanceSchema.SchemaMetadata {}

protocol SubstanceSchema_InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == SubstanceSchema.SchemaMetadata {}

protocol SubstanceSchema_MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == SubstanceSchema.SchemaMetadata {}

protocol SubstanceSchema_MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == SubstanceSchema.SchemaMetadata {}

extension SubstanceSchema {
  typealias ID = String

  typealias SelectionSet = SubstanceSchema_SelectionSet

  typealias InlineFragment = SubstanceSchema_InlineFragment

  typealias MutableSelectionSet = SubstanceSchema_MutableSelectionSet

  typealias MutableInlineFragment = SubstanceSchema_MutableInlineFragment

  enum SchemaMetadata: ApolloAPI.SchemaMetadata {
    static let configuration: ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

    static func objectType(forTypename typename: String) -> Object? {
      switch typename {
      case "Query": return SubstanceSchema.Objects.Query
      case "Substance": return SubstanceSchema.Objects.Substance
      default: return nil
      }
    }
  }

  enum Objects {}
  enum Interfaces {}
  enum Unions {}

}