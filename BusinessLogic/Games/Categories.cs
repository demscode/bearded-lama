using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataAccess.GameCategoriesTableAdapters;
using DataSets;

namespace BusinessLogic.Games {

    /// <summary>
    /// Business tier class for basic access to 'GameCategories' table data.
    /// </summary>
    [System.ComponentModel.DataObject]
    public class Categories {

        /// <summary>
        /// Gets full listing of Game Categories.
        /// </summary>
        /// <returns>DataTable of game categories</returns>
        [System.ComponentModel.DataObjectMethod(System.ComponentModel.DataObjectMethodType.Select)]
        public static GameCategories.GameCategoriesDataTable GetAllCategories() {
            GameCategoriesTableAdapter categoriesTableAdapter = new GameCategoriesTableAdapter();
            return categoriesTableAdapter.GetData();
        }
    }
}
