const ingredientSearch = () => {
  const searchInput = document.getElementById("ingredient-search");
  if (!searchInput) return;

  searchInput.addEventListener("keyup", () => {
    const keyword = searchInput.value;

    fetch(`/ingredients/search?keyword=${keyword}`)
      .then(response => response.json())
      .then(data => {
        const resultArea = document.getElementById("search-result");
        resultArea.innerHTML = "";

        // 検索結果を一つずつ取り出して表示
        data.forEach((ingredient) => {
          const result = document.createElement("div");
          result.classList.add("search-result-ingredient");
          result.innerHTML = ingredient.name;

          result.addEventListener("click", () => {
            const selectedArea = document.getElementById("selected-ingredients");

            // 表示用
            const selected = document.createElement("div");
            selected.classList.add("selected-ingredient");
            selected.textContent = ingredient.name;
            // hiddenフォーム生成
            const hiddenField = document.createElement("input");
            hiddenField.type = "hidden";
            hiddenField.name = "fridge_item[ingredient_ids][]";
            hiddenField.value = ingredient.id;
            // 削除ボタンも生成
            const deleteBtn = document.createElement("div");
            deleteBtn.classList.add("delete-btn");
            deleteBtn.textContent = "×";

            deleteBtn.addEventListener("click", () => {
              selected.remove();
            });

            selected.appendChild(hiddenField);
            selected.appendChild(deleteBtn);
            selectedArea.appendChild(selected);

            searchInput.value = "";
            resultArea.innerHTML = "";
          })

          resultArea.appendChild(result);
        })
      })

  })
};

document.addEventListener("turbo:load", ingredientSearch);