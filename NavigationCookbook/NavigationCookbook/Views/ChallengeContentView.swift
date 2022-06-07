/*
 See LICENSE folder for this sample’s licensing information.

 Abstract:
 The content view for the WWDC22 challenge.
 */

import SwiftUI

struct ChallengeContentView: View {
    @Binding var showExperiencePicker: Bool
    @EnvironmentObject private var navigationModel: NavigationModel
    var dataModel = DataModel.shared

    var body: some View {
        NavigationSplitView(columnVisibility: $navigationModel.columnVisibility) {
            List(selection: $navigationModel.selectedRecipe) {
                ForEach(Category.allCases) { category in
                    DisclosureGroup {
                        ForEach(dataModel.recipes(in: category)) { recipe in
                            NavigationLink(recipe.name, value: recipe)
                        }
                    } label: {
                        Text(category.localizedName)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Cookbook")
            .toolbar {
                ExperienceButton(isActive: $showExperiencePicker)
            }
        } detail: {
            RecipeDetail(recipe: navigationModel.selectedRecipe) { relatedRecipe in
                Button {
                    navigationModel.selectedRecipe = relatedRecipe
                } label: {
                    Text(relatedRecipe.name)
                }
            }
        }
    }
}

struct ChallengeContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeContentView(showExperiencePicker: .constant(false))
    }
}
