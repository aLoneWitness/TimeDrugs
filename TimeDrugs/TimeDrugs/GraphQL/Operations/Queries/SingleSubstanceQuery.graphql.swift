// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension SubstanceSchema {
  class SingleSubstanceQuery: GraphQLQuery {
    static let operationName: String = "SingleSubstance"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"""
        query SingleSubstance($search: String) {
          substances(query: $search, limit: 1) {
            __typename
            name
            commonNames
            url
            roas {
              __typename
              name
              dose {
                __typename
                units
                threshold
                heavy
                common {
                  __typename
                  min
                  max
                }
                light {
                  __typename
                  min
                  max
                }
                strong {
                  __typename
                  min
                  max
                }
              }
              duration {
                __typename
                afterglow {
                  __typename
                  min
                  max
                  units
                }
                comeup {
                  __typename
                  min
                  max
                  units
                }
                duration {
                  __typename
                  min
                  max
                  units
                }
                offset {
                  __typename
                  min
                  max
                  units
                }
                onset {
                  __typename
                  min
                  max
                  units
                }
                peak {
                  __typename
                  min
                  max
                  units
                }
                total {
                  __typename
                  min
                  max
                  units
                }
              }
              bioavailability {
                __typename
                min
                max
              }
            }
            class {
              __typename
              chemical
              psychoactive
            }
            effects {
              __typename
              name
              url
            }
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
          "limit": 1
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
          .field("commonNames", [String?]?.self),
          .field("url", String?.self),
          .field("roas", [Roa?]?.self),
          .field("class", Class?.self),
          .field("effects", [Effect?]?.self),
        ] }

        var name: String? { __data["name"] }
        var commonNames: [String?]? { __data["commonNames"] }
        var url: String? { __data["url"] }
        var roas: [Roa?]? { __data["roas"] }
        var `class`: Class? { __data["class"] }
        var effects: [Effect?]? { __data["effects"] }

        /// Substance.Roa
        ///
        /// Parent Type: `SubstanceRoa`
        struct Roa: SubstanceSchema.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: ApolloAPI.ParentType { SubstanceSchema.Objects.SubstanceRoa }
          static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("name", String?.self),
            .field("dose", Dose?.self),
            .field("duration", Duration?.self),
            .field("bioavailability", Bioavailability?.self),
          ] }

          var name: String? { __data["name"] }
          var dose: Dose? { __data["dose"] }
          var duration: Duration? { __data["duration"] }
          var bioavailability: Bioavailability? { __data["bioavailability"] }

          /// Substance.Roa.Dose
          ///
          /// Parent Type: `SubstanceRoaDose`
          struct Dose: SubstanceSchema.SelectionSet {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            static var __parentType: ApolloAPI.ParentType { SubstanceSchema.Objects.SubstanceRoaDose }
            static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("units", String?.self),
              .field("threshold", Double?.self),
              .field("heavy", Double?.self),
              .field("common", Common?.self),
              .field("light", Light?.self),
              .field("strong", Strong?.self),
            ] }

            var units: String? { __data["units"] }
            var threshold: Double? { __data["threshold"] }
            var heavy: Double? { __data["heavy"] }
            var common: Common? { __data["common"] }
            var light: Light? { __data["light"] }
            var strong: Strong? { __data["strong"] }

            /// Substance.Roa.Dose.Common
            ///
            /// Parent Type: `SubstanceRoaRange`
            struct Common: SubstanceSchema.SelectionSet {
              let __data: DataDict
              init(_dataDict: DataDict) { __data = _dataDict }

              static var __parentType: ApolloAPI.ParentType { SubstanceSchema.Objects.SubstanceRoaRange }
              static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("min", Double?.self),
                .field("max", Double?.self),
              ] }

              var min: Double? { __data["min"] }
              var max: Double? { __data["max"] }
            }

            /// Substance.Roa.Dose.Light
            ///
            /// Parent Type: `SubstanceRoaRange`
            struct Light: SubstanceSchema.SelectionSet {
              let __data: DataDict
              init(_dataDict: DataDict) { __data = _dataDict }

              static var __parentType: ApolloAPI.ParentType { SubstanceSchema.Objects.SubstanceRoaRange }
              static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("min", Double?.self),
                .field("max", Double?.self),
              ] }

              var min: Double? { __data["min"] }
              var max: Double? { __data["max"] }
            }

            /// Substance.Roa.Dose.Strong
            ///
            /// Parent Type: `SubstanceRoaRange`
            struct Strong: SubstanceSchema.SelectionSet {
              let __data: DataDict
              init(_dataDict: DataDict) { __data = _dataDict }

              static var __parentType: ApolloAPI.ParentType { SubstanceSchema.Objects.SubstanceRoaRange }
              static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("min", Double?.self),
                .field("max", Double?.self),
              ] }

              var min: Double? { __data["min"] }
              var max: Double? { __data["max"] }
            }
          }

          /// Substance.Roa.Duration
          ///
          /// Parent Type: `SubstanceRoaDuration`
          struct Duration: SubstanceSchema.SelectionSet {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            static var __parentType: ApolloAPI.ParentType { SubstanceSchema.Objects.SubstanceRoaDuration }
            static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("afterglow", Afterglow?.self),
              .field("comeup", Comeup?.self),
              .field("duration", Duration?.self),
              .field("offset", Offset?.self),
              .field("onset", Onset?.self),
              .field("peak", Peak?.self),
              .field("total", Total?.self),
            ] }

            var afterglow: Afterglow? { __data["afterglow"] }
            var comeup: Comeup? { __data["comeup"] }
            var duration: Duration? { __data["duration"] }
            var offset: Offset? { __data["offset"] }
            var onset: Onset? { __data["onset"] }
            var peak: Peak? { __data["peak"] }
            var total: Total? { __data["total"] }

            /// Substance.Roa.Duration.Afterglow
            ///
            /// Parent Type: `SubstanceRoaDurationRange`
            struct Afterglow: SubstanceSchema.SelectionSet {
              let __data: DataDict
              init(_dataDict: DataDict) { __data = _dataDict }

              static var __parentType: ApolloAPI.ParentType { SubstanceSchema.Objects.SubstanceRoaDurationRange }
              static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("min", Double?.self),
                .field("max", Double?.self),
                .field("units", String?.self),
              ] }

              var min: Double? { __data["min"] }
              var max: Double? { __data["max"] }
              var units: String? { __data["units"] }
            }

            /// Substance.Roa.Duration.Comeup
            ///
            /// Parent Type: `SubstanceRoaDurationRange`
            struct Comeup: SubstanceSchema.SelectionSet {
              let __data: DataDict
              init(_dataDict: DataDict) { __data = _dataDict }

              static var __parentType: ApolloAPI.ParentType { SubstanceSchema.Objects.SubstanceRoaDurationRange }
              static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("min", Double?.self),
                .field("max", Double?.self),
                .field("units", String?.self),
              ] }

              var min: Double? { __data["min"] }
              var max: Double? { __data["max"] }
              var units: String? { __data["units"] }
            }

            /// Substance.Roa.Duration.Duration
            ///
            /// Parent Type: `SubstanceRoaDurationRange`
            struct Duration: SubstanceSchema.SelectionSet {
              let __data: DataDict
              init(_dataDict: DataDict) { __data = _dataDict }

              static var __parentType: ApolloAPI.ParentType { SubstanceSchema.Objects.SubstanceRoaDurationRange }
              static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("min", Double?.self),
                .field("max", Double?.self),
                .field("units", String?.self),
              ] }

              var min: Double? { __data["min"] }
              var max: Double? { __data["max"] }
              var units: String? { __data["units"] }
            }

            /// Substance.Roa.Duration.Offset
            ///
            /// Parent Type: `SubstanceRoaDurationRange`
            struct Offset: SubstanceSchema.SelectionSet {
              let __data: DataDict
              init(_dataDict: DataDict) { __data = _dataDict }

              static var __parentType: ApolloAPI.ParentType { SubstanceSchema.Objects.SubstanceRoaDurationRange }
              static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("min", Double?.self),
                .field("max", Double?.self),
                .field("units", String?.self),
              ] }

              var min: Double? { __data["min"] }
              var max: Double? { __data["max"] }
              var units: String? { __data["units"] }
            }

            /// Substance.Roa.Duration.Onset
            ///
            /// Parent Type: `SubstanceRoaDurationRange`
            struct Onset: SubstanceSchema.SelectionSet {
              let __data: DataDict
              init(_dataDict: DataDict) { __data = _dataDict }

              static var __parentType: ApolloAPI.ParentType { SubstanceSchema.Objects.SubstanceRoaDurationRange }
              static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("min", Double?.self),
                .field("max", Double?.self),
                .field("units", String?.self),
              ] }

              var min: Double? { __data["min"] }
              var max: Double? { __data["max"] }
              var units: String? { __data["units"] }
            }

            /// Substance.Roa.Duration.Peak
            ///
            /// Parent Type: `SubstanceRoaDurationRange`
            struct Peak: SubstanceSchema.SelectionSet {
              let __data: DataDict
              init(_dataDict: DataDict) { __data = _dataDict }

              static var __parentType: ApolloAPI.ParentType { SubstanceSchema.Objects.SubstanceRoaDurationRange }
              static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("min", Double?.self),
                .field("max", Double?.self),
                .field("units", String?.self),
              ] }

              var min: Double? { __data["min"] }
              var max: Double? { __data["max"] }
              var units: String? { __data["units"] }
            }

            /// Substance.Roa.Duration.Total
            ///
            /// Parent Type: `SubstanceRoaDurationRange`
            struct Total: SubstanceSchema.SelectionSet {
              let __data: DataDict
              init(_dataDict: DataDict) { __data = _dataDict }

              static var __parentType: ApolloAPI.ParentType { SubstanceSchema.Objects.SubstanceRoaDurationRange }
              static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("min", Double?.self),
                .field("max", Double?.self),
                .field("units", String?.self),
              ] }

              var min: Double? { __data["min"] }
              var max: Double? { __data["max"] }
              var units: String? { __data["units"] }
            }
          }

          /// Substance.Roa.Bioavailability
          ///
          /// Parent Type: `SubstanceRoaRange`
          struct Bioavailability: SubstanceSchema.SelectionSet {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            static var __parentType: ApolloAPI.ParentType { SubstanceSchema.Objects.SubstanceRoaRange }
            static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("min", Double?.self),
              .field("max", Double?.self),
            ] }

            var min: Double? { __data["min"] }
            var max: Double? { __data["max"] }
          }
        }

        /// Substance.Class
        ///
        /// Parent Type: `SubstanceClass`
        struct Class: SubstanceSchema.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: ApolloAPI.ParentType { SubstanceSchema.Objects.SubstanceClass }
          static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("chemical", [String?]?.self),
            .field("psychoactive", [String?]?.self),
          ] }

          var chemical: [String?]? { __data["chemical"] }
          var psychoactive: [String?]? { __data["psychoactive"] }
        }

        /// Substance.Effect
        ///
        /// Parent Type: `Effect`
        struct Effect: SubstanceSchema.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: ApolloAPI.ParentType { SubstanceSchema.Objects.Effect }
          static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("name", String?.self),
            .field("url", String?.self),
          ] }

          var name: String? { __data["name"] }
          var url: String? { __data["url"] }
        }
      }
    }
  }

}