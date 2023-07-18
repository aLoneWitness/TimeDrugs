// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension SubstanceSchema {
  class SubstanceListQuery: GraphQLQuery {
    static let operationName: String = "SubstanceList"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"""
        query SubstanceList($search: String) {
          substances(query: $search, limit: 999) {
            __typename
            name
          }
        }
        """#
      ))

    public var search: GraphQLNullable<String>

    public init(search: GraphQLNullable<String>) {
      self.search = search
    }

    public var __variables: Variables? { ["search": search] }

    struct Data: SubstanceSchema.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { SubstanceSchema.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("substances", [Substance?]?.self, arguments: [
          "query": .variable("search"),
          "limit": 999
        ]),
      ] }

      var substances: [Substance?]? { __data["substances"] }

      /// Substance
      ///
      /// Parent Type: `Substance`
      struct Substance: SubstanceSchema.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { SubstanceSchema.Objects.Substance }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("name", String?.self),
        ] }

        var name: String? { __data["name"] }
      }
    }
  }

}