const recipeForm = function () {

  const recipeCard = document.querySelector(".recipe-form-card");
  if (!recipeCard) return;
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

    deleteBtns.forEach((btn) => {
      btn.onclick = () => {
        // closetは属する親要素を探す
        btn.closest(".ingredient-card").remove();
      };

    });

  }

  buildIngredientBtn.addEventListener("click", buildCard);
};

document.addEventListener("turbo:load", recipeForm);