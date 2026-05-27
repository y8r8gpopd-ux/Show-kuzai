const recipeForm = function () {

  const recipeFormCard = document.querySelector(".recipe-form-card");
  if (!recipeFormCard) return;
  const buildIngredientBtn = document.getElementById("add-ingredient");


  const container = document.getElementById("ingredient-forms");
  // テンプレート取得、indexの算出
  const template = document.getElementById("ingredient-template");
  let index = document.querySelectorAll(".ingredient-card").length;

  // 食材フォーム追加
  const buildCard = function () {
    // indexの割り振り、作成
    const ingredientHtml = template.innerHTML.replace(/INDEX/g, index);
    container.insertAdjacentHTML("beforeend", ingredientHtml);

    index++;

    attachEvents();
  };

  // 削除イベント
  const attachEvents = function () {

    const deleteBtns = document.querySelectorAll(".delete-btn");

    // 削除ボタンでhidden destroy formを「１」にして非表示にする
    deleteBtns.forEach((btn) => {
      btn.addEventListener("click", () => {
        // closetは属する親要素を探す
        const ingredientCard = btn.closest(".ingredient-card");

        const destroyField = ingredientCard.querySelector('input[name*="_destroy"]');

        if (destroyField) {
          destroyField.value = "1";
        }

        ingredientCard.style.display = "none";
      });
    });

  };

  attachEvents();
  buildIngredientBtn.addEventListener("click", buildCard);
};

document.addEventListener("turbo:load", recipeForm);
